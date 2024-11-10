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
    @ObservedObject var model: AppModel = .shared

    var body: some View {
        model.currentPage.view()
            .environmentObject(model)
            .sheet(isPresented: .constant(firebase.currentlyInPromenade || firebase.isReviewingPromenade)) {
                ActivePromenadeView()
                    .interactiveDismissDisabled(true)
            }
    }
}
