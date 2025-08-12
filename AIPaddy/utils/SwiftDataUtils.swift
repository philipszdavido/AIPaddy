//
//  SwiftDataUtils.swift
//  AIPaddy
//
//  Created by Chidume Nnamdi on 12/08/2025.
//

import Foundation
import SwiftData

class SwiftDataUtils {
    
    static let shared = SwiftDataUtils()
    
    func insertChat(modelContext: ModelContext, text: String) -> Chat {
        let chat = Chat(name: text, messages: []);
        modelContext.insert(chat);
        return chat
    }
    
    func insertMessage(modelContext: ModelContext, message: String) -> Message {
        let message = Message(created: Date(), content: message);
        modelContext.insert(message)
        return message
    }
    
}
