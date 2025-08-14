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
    @ObservedObject var aiViewModel = AIViewModel.shared
    @Query private var chats: [Chat]

    var body: some View {
        NavigationSplitView {
            List {
                ForEach(chats) { chat in
                    NavigationLink {
                        ChatAreaView(chat: chat)
                    } label: {
                        Text("\(chat.name)")
                    }.contextMenu {
                        
                        Button("Remove") {
                            
                            modelContext.delete(chat);
                            
                        }
                        
                    }

                }
                .onDelete(perform: deleteChats)
                
            }
            .navigationSplitViewColumnWidth(min: 180, ideal: 200)
            .toolbar {
                ToolbarItem {
                    Button(action: addItem) {
                        Label("New chat", systemImage: "plus")
                    }
                }
            }
        } detail: {
            
            ChatAreaView(chat: chats.first ?? Chat(name: "New chat", messages: []))
            
        }
    }

    private func addItem() {
        withAnimation {
            let newItem = Chat(name: "New chat", messages: [])
            modelContext.insert(newItem)
        }
    }

    private func deleteChats(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(chats[index])
            }
        }
    }
    
}

#Preview {
    ContentView()
        .modelContainer(
            for: [Item.self, Message.self, Chat.self],
            inMemory: true
        )
}
