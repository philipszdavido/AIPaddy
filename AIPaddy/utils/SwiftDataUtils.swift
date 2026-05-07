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
    
    func insertChat(modelContext: ModelContext, text: String, msgs: [Message]) -> Chat {
        let chat = Chat(name: text, messages: msgs);
        modelContext.insert(chat);
        return chat
    }

    func insertMessage(modelContext: ModelContext, message: String, chat: Chat, isAi: Bool) -> Message {
        let message = Message(content: message, chat: chat);
        message.isAi = isAi;
        modelContext.insert(message)
        return message
    }
        
}
