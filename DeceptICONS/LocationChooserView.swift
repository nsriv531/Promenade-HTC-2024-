//
//  LocationChooserView.swift
//  DeceptICONS
//
//  Created by Kai Azim on 2024-11-09.
//

import SwiftUI

struct LocationChooserView: View {
    let initialLocation: Location? = nil
    let finalLocation: Location? = nil

    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: 12) {
                Group {
                    Text("Promenade...")
                        .exposureTitle()
                    
                    Text("Start a new adventure.")
                        .interSubheadline()
                }

                Spacer()
                    .frame(height: 12)

                NavigationLink {
                    ContentView()
                } label: {
                    Button("Choose Starting Destination...") {

                    }
                    .buttonStyle(IntroButtonStyle())
                }

                NavigationLink {
                    ContentView()
                } label: {
                    Button("Choose Final Destination...") {

                    }
                    .buttonStyle(IntroButtonStyle())
                }

                Spacer()
                
                Button("Continue") {
                    //                model.nextPage()
                }
                .buttonStyle(IntroButtonStyle())
                .disabled(initialLocation == nil || finalLocation == nil)
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
        }
    }
}

#Preview {
    LocationChooserView()
}
