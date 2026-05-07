//
//  ChatAreaView.swift
//  AIPaddy
//
//  Created by Chidume Nnamdi on 12/08/2025.
//

import SwiftUI
import SwiftData

struct ChatAreaView: View {
    
    @Environment(\.modelContext) var modelContext
    let aiViewModel = AIViewModel.shared
    
    var chat: Chat
    @State var text = ""
        
    var body: some View {
        
        VStack {
            
            if chat.messages.isEmpty {
                
                Text("Ask me anything")
                    .font(.title)
                
            } else {
                
                ScrollViewReader { proxy in
                    ScrollView(.vertical) {
                        
                        ForEach(chat.messages.sorted(by: {
                            $0.created < $1.created
                        })) { message in
                            
                            MessageRow(message: message)
                                .id(message.id)
                            
                        }
                        
                    }
                    .onChange(of: chat.messages.count) {
                        if let last = chat.messages.last {
                            proxy.scrollTo(last.id, anchor: .bottom)
                        }
                    }
                }
            }
            
            Spacer()
            
            HStack {
                
                TextField("Tell me something...", text: $text)
                    .onSubmit {
                        sendMessage()
                    }
                    .padding(10)
                
                Button {
                    
                    sendMessage()
                    
                } label: {
                    Image(systemName: "paperplane")
                }
                
            }
            
        }.padding()
    }
    
    func sendMessage() {
        aiViewModel
            .sendMessage(
                modelContext: modelContext,
                text,
                instruction: Instructions.god,
                chat: chat,
                { data in },
                palId: ""
            )
        
        text = ""
        
    }
        
}

#Preview {
    ChatAreaView(chat: Chat(name: "", messages: []))
        .modelContainer(for: [Chat.self, Message.self], inMemory: true)
}
