//
//  ContentView.swift
//  AIPaddy
//
//  Created by Chidume Nnamdi on 12/08/2025.
//

import SwiftUI
import SwiftData

//struct ContentView: View {
//    @Environment(\.modelContext) private var modelContext
//    @ObservedObject var aiViewModel = AIViewModel.shared
//    @Query private var chats: [Chat]
//
//    var body: some View {
//        NavigationSplitView {
//            List {
//                ForEach(chats) { chat in
//                    NavigationLink {
//                        ChatAreaView(chat: chat)
//                    } label: {
//                        Text("\(chat.name)")
//                    }.contextMenu {
//                        
//                        Button("Remove") {
//                            
//                            modelContext.delete(chat);
//                            
//                        }
//                        
//                    }
//
//                }
//                .onDelete(perform: deleteChats)
//                
//            }
//            .navigationSplitViewColumnWidth(min: 180, ideal: 200)
//            .toolbar {
//                ToolbarItem {
//                    Button(action: addItem) {
//                        Label("New chat", systemImage: "plus")
//                    }
//                }
//            }
//        } detail: {
//            
//
//            ChatAreaView(chat: chats.first ?? Chat(name: "New chat", messages: []))
//            
//        }
//    }
//
//    private func addItem() {
//        withAnimation {
//            let newItem = Chat(name: "New chat", messages: [])
//            modelContext.insert(newItem)
//        }
//    }
//
//    private func deleteChats(offsets: IndexSet) {
//        withAnimation {
//            for index in offsets {
//                modelContext.delete(chats[index])
//            }
//        }
//    }
//    
//}

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
