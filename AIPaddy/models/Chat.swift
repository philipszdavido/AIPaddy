//
//  Chat.swift
//  AIPaddy
//
//  Created by Chidume Nnamdi on 12/08/2025.
//

import Foundation
import SwiftData

@Model
final class Chat: Identifiable {
    
    var id = UUID()
    var name: String
    var messages: [Message] = []
    var created = Data()
    
    init(
        id: UUID = UUID(),
        name: String,
        messages: [Message],
        created: Data = Data()
    ) {
        self.id = id
        self.name = name
        self.messages = messages
        self.created = created
    }
    
}
