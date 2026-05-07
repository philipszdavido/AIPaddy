//
//  Chat.swift
//  AIPaddy
//
//  Created by Chidume Nnamdi on 12/08/2025.
//

import Foundation
import SwiftData

@Model
final class Chat {
    
    var created = Date()
    var name: String
    
    @Relationship(deleteRule: .cascade)
    var messages: [Message] = []
        
    init(
        name: String,
        messages: [Message] = [],
    ) {
        self.name = name
        self.messages = messages
    }
    
}
