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
    
    lazy var model: SystemLanguageModel = {
        SystemLanguageModel.default
    }()
    
    var options: GenerationOptions {
        return GenerationOptions(temperature: 2.0)
    }

    func generateTitle(from text: String) async throws -> String {

        let session = LanguageModelSession(
            instructions: """
            Generate a very short chat title.

            Rules:
            - Maximum 5 words
            - No quotes
            - No punctuation
            - Summarize the topic clearly
            """
        )

        let response = try await session.respond(
            to: "Create a title for: \(text)"
        )

        return response.content.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    func sendMessage(
        modelContext: ModelContext,
        _ content: String,
        instruction: String,
        chat: Chat,
        _ update: @escaping(_ data: String) -> Void,
        palId: String?
    ) {

        _ = swiftDataUtils.insertMessage(
            modelContext: modelContext,
            message: content,
            chat: chat,
            isAi: false
        )
        
        var aiMessage: Message? = nil
        
        Task {

            do {

                if chat.name == "New chat" || chat.name.isEmpty {

                    let title = try await generateTitle(from: content)

                    chat.name = title

                }

                let session = LanguageModelSession(
                    instructions: instruction
                )

                let stream = session.streamResponse(to: content)
                
                update("Typing...")

                aiMessage = swiftDataUtils.insertMessage(
                    modelContext: modelContext,
                    message: "Typing...",
                    chat: chat,
                    isAi: true
                )

                for try await response in stream {

                    if let aiMessage = aiMessage {
                        aiMessage.content = response.content
                    }
                }

            } catch {
                
                update("Error occurred.")

            }

        }

    }
}
