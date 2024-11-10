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
                    .exposureFont()

                Text("Walk together, anytime.")
                    .interFont()
                    .offset(y: showIntro ? 0 : 10)
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
        .modifier(BackgroundMeshModifier())
        .onAppear {
            withAnimation(.easeOut(duration: 1.0).delay(0.2)) {
                showIntro = true
            }
        }
    }
}

extension Text {
    func exposureFont(size: CGFloat = 56) -> some View {
        font(.custom("Exposure Trial VAR", size: size))
            .foregroundStyle(.text)
    }

    func interFont(size: CGFloat = 24) -> some View {
        font(.custom("Inter", size: size))
            .foregroundStyle(.text)
    }
}

struct Trapezoid: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let width = rect.size.width
        let height = rect.size.height
        path.move(to: CGPoint(x: 0.00071 * width, y: 0.99917 * height))
        path.addLine(to: CGPoint(x: 0.00071 * width, y: 0.43939 * height))
        path.addLine(to: CGPoint(x: 0.99977 * width, y: 0))
        path.addLine(to: CGPoint(x: 0.99977 * width, y: 0.12121 * height))
        path.addLine(to: CGPoint(x: 0.00071 * width, y: 0.99917 * height))
        path.closeSubpath()
        return path
    }
}

#Preview {
    IntroWelcomeView()
        .environmentObject(AppModel())
}
