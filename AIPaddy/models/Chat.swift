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
    
    var id = UUID()
    var name: String
    var messages: [Message] = []
    var created = Data()
    
    init(
        name: String,
        messages: [Message],
    ) {
        self.name = name
        self.messages = messages
    }
    
}
