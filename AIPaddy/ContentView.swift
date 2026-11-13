//
//  ContentView.swift
//  AIPaddy
//
//  Created by Chidume Nnamdi on 12/08/2025.
//

import SwiftUI
import SwiftData

struct ContentView: View {

    @Environment(\.modelContext) private var modelContext

    @Query(sort: \Chat.created, order: .reverse)
    private var chats: [Chat]

    @State private var selectedChat: Chat?

    var body: some View {

        NavigationSplitView {

            List(chats, selection: $selectedChat) {

                chat in

                NavigationLink(value: chat) {

                    Text(chat.name)

                }
                .contextMenu {

                    Button("Remove") {
                        withAnimation {
                            modelContext.delete(chat)
                        }
                    }

                }

            }
            .navigationTitle("Chats")
            .toolbar {

                ToolbarItem {

                    Button(action: addItem) {

                        Label("New chat", systemImage: "plus")

                    }

                }
                
                ToolbarItem {
                    Button(action: clearAll) {

                        Label("Clear all", systemImage: "paintbrush.fill")
                        
                    }

                }

            }

        } detail: {

            if let chat = selectedChat {

                ChatAreaView(chat: chat)

            } else {

                ChatAreaView(chat: Chat(name: "", messages: []))

//                ContentUnavailableView(
//                    "Ready when you are",
//                    systemImage: "message"
//                )

            }

        }

    }

    private func addItem() {

        let newChat = Chat(
            name: "",
            messages: []
        )

        modelContext.insert(newChat)

        selectedChat = newChat

    }
    
    private func clearAll() {
        withAnimation {
            
            for chat in chats {
                chat.messages.removeAll()
                modelContext.delete(chat)
            }
            
            try! modelContext.save()
        }
    }

}

#Preview {
    ContentView()
        .modelContainer(
            for: [Message.self, Chat.self],
            inMemory: true
        )
}
