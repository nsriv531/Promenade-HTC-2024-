//
//  LocationChooserView.swift
//  DeceptICONS
//
//  Created by Kai Azim on 2024-11-09.
//

import Defaults
import SwiftUI

struct LocationChooserView: View {
    @ObservedObject var firebase: FirebaseManager = .shared

    @State private var initialLocation: Location? = nil
    @State private var finalLocation: Location? = nil
    @Default(.account) var me

    @State var didSearch = false

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 12) {
                    Group {
                        Text("Promenade...")
                            .exposureFont()

                        Text("Start a new adventure.")
                            .interFont()
                    }

                    Spacer()
                        .frame(height: 12)

                    NavigationLink(initialLocation?.name ?? "Choose Starting Destination...") {
                        LocationSearchView(selectedLocation: $initialLocation)
                    }
                    .buttonStyle(IntroButtonStyle())

                    NavigationLink(finalLocation?.name ?? "Choose Final Destination...") {
                        LocationSearchView(selectedLocation: $finalLocation)
                    }
                    .buttonStyle(IntroButtonStyle())

                    Button("Search...") {
                        didSearch = true
                    }
                    .buttonStyle(IntroButtonStyle())
                    .disabled(me == nil || initialLocation == nil || finalLocation == nil)

                    if didSearch, let me, let initialLocation, let finalLocation {
                        Spacer()
                            .frame(height: 12)

                        Text("Choose your pals.")
                            .interFont()
                        MatchFinderView(me: me, startingLocation: initialLocation, finalLocation: finalLocation)

                        if firebase.sentInvites.count > 0 {
                            NavigationLink("Next") {
                                SentInvitesView()
                            }
                            .buttonStyle(IntroButtonStyle(highlight: true))
                        }
                    }
                }
                .padding()
            }
            .modifier(BackgroundMeshModifier())
            .onChange(of: firebase.currentlyInPromenade) {
                didSearch = false
            }
        }
    }
}

struct LocationSearchView: View {
    @Environment(\.presentationMode) private var presentationMode
    @ObservedObject private var firebase: FirebaseManager = .shared

    @State private var searchText = ""
    @Binding var selectedLocation: Location?

    var body: some View {
        NavigationStack {
            List {
                ForEach(searchResults, id: \.self) { location in
                    Button {
                        selectedLocation = location
                        presentationMode.wrappedValue.dismiss()
                    } label: {
                        Text(location.name)
                    }
                }
            }
        }
        .searchable(text: $searchText)
    }

    var searchResults: [Location] {
        if searchText.isEmpty {
            firebase.locations
        } else {
            firebase.locations.filter { $0.name.contains(searchText) }
        }
    }
}
