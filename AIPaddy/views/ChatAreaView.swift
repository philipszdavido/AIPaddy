//
//  ChatAreaView.swift
//  AIPaddy
//
//  Created by Chidume Nnamdi on 12/08/2025.
//

import SwiftUI
import SwiftData

struct ChatAreaView: View {
    
    var chat: Chat
    @State var text = ""
    
    var body: some View {
        
        VStack {
            
            Text("Ask me anything")
                .font(.title)
            
            Spacer()
            
            HStack {
                
                TextField("New Chat", text: $text)
                    .padding(10)
                
                Button {
                    
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
