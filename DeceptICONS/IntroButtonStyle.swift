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
            .foregroundStyle(.white)
            .font(.headline)
            .padding(18)
            .frame(maxWidth: .infinity)
            .background {
                RoundedRectangle(cornerRadius: 20)
                    .fill(
                        LinearGradient(
                            gradient: Gradient(
                                colors: [
                                    .black.mix(with: .white, by: 0.4),
                                    .black.mix(with: .white, by: 0.2)
                                ]
                            ),
                            startPoint: .top,
                            endPoint: .bottom
                        )
                    )
            }
            .frame(height: 60)
            .scaleEffect(configuration.isPressed ? 0.95 : 1)
            .animation(.smooth(duration: 0.2), value: configuration.isPressed)
    }
}
