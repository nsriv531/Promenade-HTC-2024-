//
//  IntroWelcomeView.swift
//  DeceptICONS
//
//  Created by Kai Azim on 2024-11-09.
//

import SwiftUI

struct IntroWelcomeView: View {
    @EnvironmentObject var model: AppModel

    var body: some View {
        VStack(alignment: .leading, spacing: 32) {
            Text("Welcome to *Promenade*")
                .font(.largeTitle.bold())

            Text("Promenade enables you to find new walk buddies!.")

            Spacer()

            Button("Continue") {
                model.nextPage()
            }
            .buttonStyle(IntroButtonStyle())
        }
        .padding()
    }
}
