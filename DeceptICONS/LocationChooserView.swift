//
//  LocationChooserView.swift
//  DeceptICONS
//
//  Created by Kai Azim on 2024-11-09.
//

import SwiftUI
import Defaults
import Kingfisher

struct LocationChooserView: View {
    @State private var initialLocation: Location? = nil
    @State private var finalLocation: Location? = nil
    @Default(.account) var me

    var body: some View {
        NavigationView {
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

                Spacer()
                
                NavigationLink("Continue") {
                    if let me, let initialLocation, let finalLocation {
                        MatchFinderView(me: me, startingLocation: initialLocation, finalLocation: finalLocation)
                    }
                }
                .buttonStyle(IntroButtonStyle())
                .disabled(me == nil || initialLocation == nil || finalLocation == nil)
            }
            .padding()
            .modifier(BackgroundMeshModifier())
        }
    }
}

struct LocationSearchView: View {
    @Environment(\.presentationMode) var presentationMode

    let locations = Location.all
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
            return locations
        } else {
            return locations.filter { $0.name.contains(searchText) }
        }
    }
}
