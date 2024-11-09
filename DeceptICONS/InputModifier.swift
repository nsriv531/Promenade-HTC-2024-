//
//  InputModifier.swift
//  DeceptICONS
//
//  Created by Kai Azim on 2024-11-09.
//

import SwiftUI

struct InputModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .frame(maxWidth: .infinity)
            .padding(.leading)
            .frame(height: 45)
            .background {
                RoundedRectangle(cornerRadius: 15)
                    .strokeBorder(.quaternary, lineWidth: 2)
            }
    }
}
