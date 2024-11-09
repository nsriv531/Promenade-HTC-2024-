//
//  ContentView.swift
//  DeceptICONS
//
//  Created by Kai Azim on 2024-11-09.
//

import Defaults
import SwiftUI

struct ContentView: View {
    @StateObject var model = AppModel()

    var body: some View {
        model.currentPage.view()
            .environmentObject(model)
    }
}

#Preview {
    AccountCreationView()
        .environmentObject(AppModel())
}
