//
//  IntroButtonStyle.swift
//  DeceptICONS
//
//  Created by Kai Azim on 2024-11-09.
//

import SwiftUI

struct IntroButtonStyle: ButtonStyle {
    @Environment(\.isEnabled) var enabled
    let cornerRadius: CGFloat
    let padding: CGFloat

    init(cornerRadius: CGFloat = 20, padding: CGFloat = 18) {
        self.cornerRadius = cornerRadius
        self.padding = padding
    }

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundStyle(.text.opacity(enabled ? 1 : 0.5))
            .font(.headline)
            .padding(padding)
            .frame(maxWidth: .infinity)
            .background {
                RoundedRectangle(cornerRadius: cornerRadius)
                    .foregroundStyle(Color(.background))
                    .opacity(0.3)
            }
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

struct BackgroundMeshModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .background {
                MeshGradient(
                    width: 3, height: 3,
                    points: [
                        [0.0, 0.0], [0.5, 0], [1.0, 0.0],
                        [0.0, 0.5], [0.6, 0.5], [1.0, 0.5],
                        [0.0, 1.0], [0.5, 1.0], [1.0, 1.0]
                    ],
                    colors: [
                        .background, .thistle, .orchidPink,
                        .orchidPink, .thistle, .background,
                        .lavenderPink, .thistle, .lavenderPink
                    ],
                    smoothsColors: true,
                    colorSpace: .perceptual
                )
                .ignoresSafeArea()
            }
    }
}
