//
//  IntroWelcomeView.swift
//  DeceptICONS
//
//  Created by Kai Azim on 2024-11-09.
//

import SwiftUI

struct IntroWelcomeView: View {
    @EnvironmentObject var model: AppModel
    @State var showIntro: Bool = false

    var body: some View {
        VStack(alignment: .center, spacing: 12) {
            Spacer()

            Group {
                Text("Promenade")
                    .exposureTitle()

                Text("Walk together, anytime.")
                    .interSubheadline()
            }
            .blur(radius: showIntro ? 0 : 10)
            .opacity(showIntro ? 1 : 0)
            .offset(y: showIntro ? 0 : 20)

            Spacer()

            Button("Continue") {
                model.nextPage()
            }
            .buttonStyle(IntroButtonStyle())
        }
        .padding()
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
        .onAppear {
            withAnimation(.easeOut(duration: 1.0)) {
                showIntro = true
            }
        }
    }
}

extension Text {
    func exposureTitle() -> some View {
        self
            .font(.custom("Exposure Trial VAR", size: 56))
            .foregroundStyle(.text)
    }

    func interSubheadline() -> some View {
        self
            .font(.custom("Inter", size: 24))
            .foregroundStyle(.text)
    }
}

struct Trapezoid: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let width = rect.size.width
        let height = rect.size.height
        path.move(to: CGPoint(x: 0.00071*width, y: 0.99917*height))
        path.addLine(to: CGPoint(x: 0.00071*width, y: 0.43939*height))
        path.addLine(to: CGPoint(x: 0.99977*width, y: 0))
        path.addLine(to: CGPoint(x: 0.99977*width, y: 0.12121*height))
        path.addLine(to: CGPoint(x: 0.00071*width, y: 0.99917*height))
        path.closeSubpath()
        return path
    }
}

#Preview {
    IntroWelcomeView()
        .environmentObject(AppModel())
}
