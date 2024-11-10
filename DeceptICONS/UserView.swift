//
//  UserView.swift
//  DeceptICONS
//
//  Created by Kai Azim on 2024-11-09.
//

import SwiftUI

struct UserView: View {
    let user: AccountInfo
    @State var isExpanded = false

    var body: some View {
        Button {
            withAnimation(.smooth(duration: 0.2)) {
                isExpanded.toggle()
            }
        } label: {
            VStack(alignment: .leading, spacing: 12) {
                HStack(spacing: 12) {
                    AsyncImage(
                        url: URL(string: "https://thispersondoesnotexist.com/")!,
                        content: { image in
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                        },
                        placeholder: {
                            Rectangle()
                                .fill(.secondary)
                                .aspectRatio(contentMode: .fit)
                        }
                    )
                    .clipShape(.rect(cornerRadius: 10))

                    VStack(alignment: .leading) {
                        Text(user.firstName)
                            .exposureFont(size: 32)
                            .fixedSize()

                        Group {
                            Text(user.pronouns)
                                .interFont(size: 16)
                        }
                    }

                    Spacer()

                    HStack(spacing: 2) {
                        ForEach(0..<5, id: \.self) { star in
                            let fullStar = "star.fill"
                            let halfStar = "star.lefthalf.fill"
                            let emptyStar = "star"

                            let starRange = user.userRating - Float(star)
                            let iconName = starRange >= 1 ? fullStar : starRange >= 0.5 ? halfStar : emptyStar

                            Image(systemName: iconName)
                        }
                    }
                }
                .frame(height: 60)

                if isExpanded {
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Interests: \(user.interests.map { $0.name }.joined(separator: ", "))")
                            .lineLimit(5)
                            .fixedSize(horizontal: false, vertical: true)

                        Text("Languages: \(user.languages.joined(separator: ", "))")
                            .lineLimit(5)
                            .fixedSize(horizontal: false, vertical: true)

                        Text("Age range: \(user.ageRange.name)")
                            .lineLimit(5)
                            .fixedSize(horizontal: false, vertical: true)

                        Button {
                            print("Invited \(user.firstName)")
                        } label: {
                            Text("Invite to Promenade...")
                                .shadow(color: .orchidPink.opacity(0.5), radius: 10)
                        }
                        .bold()
                        .buttonStyle(IntroButtonStyle(cornerRadius: 16, padding: 8))
                    }
                }
            }
        }
        .buttonStyle(IntroButtonStyle(cornerRadius: 28))
        .clipped()
    }
}
