//
//  IntroButtonStyle.swift
//  DeceptICONS
//
//  Created by Kai Azim on 2024-11-09.
//

import SwiftUI

struct IntroButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundStyle(.text)
            .font(.headline)
            .padding(18)
            .frame(maxWidth: .infinity)
            .background {
                RoundedRectangle(cornerRadius: 20)
                    .foregroundStyle(Color(.background))
                    .opacity(0.3)
            }
            .frame(height: 60)
            .scaleEffect(configuration.isPressed ? 0.95 : 1)
            .animation(.smooth(duration: 0.2), value: configuration.isPressed)
    }
}

struct InputModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .frame(maxWidth: .infinity)
            .padding(.leading)
            .frame(height: 45)
            .background {
                RoundedRectangle(cornerRadius: 15)
                    .strokeBorder(Color(.text).opacity(0.25), lineWidth: 2)
            }
    }
}

#Preview {
    AccountCreationView()
        .environmentObject(AppModel())
}
