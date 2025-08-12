//
//  Message.swift
//  AIPaddy
//
//  Created by Chidume Nnamdi on 12/08/2025.
//

import Foundation
import SwiftData

@Model
final class Message: Identifiable {
    
    var id = UUID()
    var created: Date
    var text: String
    
    init(id: UUID = UUID(), created: Date, text: String) {
        self.id = id
        self.created = created
        self.text = text
    }
    
}
