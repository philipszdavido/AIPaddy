//
//  AIViewModel.swift
//  AIPaddy
//
//  Created by Chidume Nnamdi on 12/08/2025.
//

import Foundation
import Combine
import FoundationModels
import SwiftData

class AIViewModel: ObservableObject {

    private let swiftDataUtils = SwiftDataUtils.shared
    
    static let shared = AIViewModel()
    
    var model: SystemLanguageModel {
        return SystemLanguageModel.default
    }
    
    var options: GenerationOptions {
        return GenerationOptions(temperature: 2.0)
    }

    func sendMessage(modelContext: ModelContext, _ content: String, instruction: String?, palId: String?) {
        
        _ = swiftDataUtils
            .insertMessage(modelContext: modelContext, message: content)
        
        Task {
            
            do {
                
                let session = LanguageModelSession(instructions: instruction)
                
                let stream = session.streamResponse(to: content)
                
                let message = swiftDataUtils.insertMessage(
                    modelContext: modelContext,
                    message: "Typing..."
                )
                
                for try await response in stream {
                                        
                    message.content = response.content
                    
                }
                
                // message.isPartial = false
                                
                
            } catch {
                
                
            }
            
        }
        
    }
    
}
