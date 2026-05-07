//
//  MessageRow.swift
//  AIPaddy
//
//  Created by Chidume Nnamdi on 06/05/2026.
//

import SwiftUI

struct MessageRow: View {
    let message: Message

    var body: some View {
        HStack {
            if message.isAi {
                Text(message.content)
                    .padding()
                    .background(Color.gray.opacity(0.2))
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                Spacer()
            } else {
                Spacer()
                Text(message.content)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
            }
        }
        .padding(.horizontal)
    }
}

//#Preview {
//    MessageRow(message: Message(content: "", chatId: UUID()))
//}
