//
//  Message.swift
//  AIPaddy
//
//  Created by Chidume Nnamdi on 12/08/2025.
//

import Foundation
import SwiftData

@Model
final class Message {
    
    var created = Date()
    var content: String
    var isAi: Bool = false
    var chat: Chat?
    
    init(content: String, chat: Chat? = nil) {
        self.content = content
        self.chat = chat
    }
    
}
