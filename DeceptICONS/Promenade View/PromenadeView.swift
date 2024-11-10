//
//  PromenadeView.swift
//  DeceptICONS
//
//  Created by Kai Azim on 2024-11-10.
//

import SwiftUI

//struct PromenadeView: View {
//    @ObservedObject var firebase: FirebaseManager = .shared
//
//    var body: some View {
//        NavigationView {
//            ScrollView {
//                VStack(alignment: .leading, spacing: 12) {
//                    Text("Promenade...")
//                        .exposureFont()
//
//                    Text("Start a new adventure.")
//                        .interFont()
//
//                    Spacer()
//                        .frame(height: 12)
//
//                    NavigationLink("Begin...") {
//                        LocationChooserView()
//                    }
//                    .buttonStyle(IntroButtonStyle())
//
//                    if !firebase.sentInvites.isEmpty {
//                        NavigationLink("View Sent Invites (\(firebase.sentInvites.count))") {
//                            SentInvitesView()
//                        }
//                        .buttonStyle(IntroButtonStyle())
//                    }
//
//                    if !firebase.receivedInvites.isEmpty {
//                        NavigationLink("View Received Invites (\(firebase.receivedInvites.count))") {
//                            ReceivedInvitesView()
//                        }
//                        .buttonStyle(IntroButtonStyle())
//                    }
//
//                    Spacer()
//                }
//                .padding()
//            }
//            .refreshable {
//                await firebase.fetchSentInvites()
//                await firebase.fetchReceivedInvites()
//            }
//            .modifier(BackgroundMeshModifier())
//        }
//    }
//}
