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
    
    var id = UUID()
    var created = Date()
    var content: String
    var isAi: Bool = false
    
    init(content: String) {
        self.content = content
    }
    
}
