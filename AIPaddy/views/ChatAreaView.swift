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
    
    @Query
    var messages: [Message]
    
    var body: some View {
        
        VStack {
            
            if messages.isEmpty {

                Text("Ask me anything")
                    .font(.title)

            } else {
                
                ForEach(messages) { message in
                    
                    HStack(alignment: .top) {
                        
                        //if message.isAi {
                            
                            Spacer()
                            
                            Text(message.content)
                                .padding()
                        //}
                    }
                }
            }
            
            Spacer()
            
            HStack {
                
                TextField("New Chat", text: $text)
                    .padding(10)
                
                Button {
                    
                    aiViewModel
                        .sendMessage(
                            modelContext: modelContext,
                            text,
                            instruction: "You are an all knowing god.",
                            palId: ""
                        )
                    
                    text = ""
                    
                } label: {
                    Image(systemName: "paperplane")
                }
                
            }
            
        }.padding()
        
    }
    
}

#Preview {
    ChatAreaView(chat: Chat(name: "", messages: []))
        .modelContainer(for: [Chat.self], inMemory: true)
}
