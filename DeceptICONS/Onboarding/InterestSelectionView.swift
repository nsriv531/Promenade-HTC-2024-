//
//  InterestSelectionView.swift
//  DeceptICONS
//
//  Created by Kai Azim on 2024-11-09.
//


import SwiftUI

struct InterestSelectionView: View {
    @EnvironmentObject var model: AppModel
    @State var interests: [AccountInfo.Interest] = []

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Interests")
                .exposureTitle()

            Text("Connect through shared interests.")
                .interSubheadline()

            Spacer()
                .frame(height: 12)

            WrappingCollectionView(
                data: AccountInfo.Interest.allCases,
                singleItemHeight: 16
            ) { item in
                Button {
                    withAnimation(.smooth(duration: 0.1)) {
                        if interests.contains(item) {
                            interests.removeAll(where: { $0 == item })
                        } else {
                            interests.append(item)
                        }
                    }
                } label: {
                    Text(item.name)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 4)
                        .background(interests.contains(item) ? .lavenderPink : .background.opacity(0.3))
                        .clipShape(.capsule)
                        .fixedSize()
                }
                .buttonStyle(.plain)
            }

            Spacer()

            Button("Create Account") {
                model.account?.interests = interests
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
    }
}

#Preview {
    InterestSelectionView()
        .environmentObject(AppModel())
}
