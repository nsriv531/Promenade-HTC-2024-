//
//  InterestSelectionView.swift
//  DeceptICONS
//
//  Created by Kai Azim on 2024-11-09.
//

import SwiftUI

struct InterestSelectionView: View {
    @ObservedObject var firebaseManager: FirebaseManager = .shared
    @EnvironmentObject var model: AppModel
    @State var interests: [User.Interest] = FirebaseManager.shared.account?.interests ?? []

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Interests")
                .exposureFont()

            Text("Connect through shared interests.")
                .interFont()

            Spacer()
                .frame(height: 12)

            WrappingCollectionView(
                data: User.Interest.allCases,
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

            Button("Continue") {
                Task {
                    if var user = firebaseManager.account {
                        user.interests = interests
                        await firebaseManager.updateAccount(user)
                    }

                    model.nextPage()
                }
            }
            .buttonStyle(IntroButtonStyle())
        }
        .padding()
        .modifier(BackgroundMeshModifier())
    }
}

#Preview {
    InterestSelectionView()
        .environmentObject(AppModel())
}
