//
//  ContentView.swift
//  DeceptICONS
//
//  Created by Kai Azim on 2024-11-09.
//

import Defaults
import SwiftUI

struct ContentView: View {
    @ObservedObject var firebase: FirebaseManager = .shared
    @StateObject var model = AppModel()

    var body: some View {
        model.currentPage.view()
            .environmentObject(model)
            .sheet(isPresented: .constant(firebase.currentlyInPromenade)) {
                ActivePromenadeView()
                    .interactiveDismissDisabled(true)
            }
//            .onAppear {
//                let users = AccountInfo.sampleUsers
//
//                // encode to JSON array
//                let encoder = JSONEncoder()
//                encoder.outputFormatting = .prettyPrinted
//                let data = try! encoder.encode(users)
//                let jsonString = String(data: data, encoding: .utf8)!
//
//                print(jsonString)
//            }
//            .onAppear {
//                let users = Location.all
//
//                // encode to JSON array
//                let encoder = JSONEncoder()
//                encoder.outputFormatting = .prettyPrinted
//                let data = try! encoder.encode(users)
//                let jsonString = String(data: data, encoding: .utf8)!
//
//                print(jsonString)
//            }
    }
}

struct ActivePromenadeView: View {
    @ObservedObject var firebase: FirebaseManager = .shared

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Active Promenade")
                .exposureFont()
                .frame(maxWidth: .infinity, alignment: .leading)

            Text("Your team is comprised of:")
                .interFont()

            ForEach(firebase.promenadeUsers) { user in
                UserView(user: user)
            }

            Spacer()
        }
        .padding()
        .modifier(BackgroundMeshModifier())
    }
}

extension ActivePromenadeView {
    struct UserView: View {
        let user: User
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
                            ForEach(0 ..< 5, id: \.self) { star in
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
                            Text("Interests: \(user.interests.map(\.name).joined(separator: ", "))")
                                .lineLimit(5)
                                .fixedSize(horizontal: false, vertical: true)

                            Text("Languages: \(user.languages.joined(separator: ", "))")
                                .lineLimit(5)
                                .fixedSize(horizontal: false, vertical: true)

                            Text("Age range: \(user.ageRange.name)")
                                .lineLimit(5)
                                .fixedSize(horizontal: false, vertical: true)
                        }
                    }
                }
            }
            .buttonStyle(IntroButtonStyle(cornerRadius: 28))
            .clipped()
        }
    }
}

#Preview {
    ActivePromenadeView()
}
