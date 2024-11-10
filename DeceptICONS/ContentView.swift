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
            .onAppear {
                let users = Location.all

                // encode to JSON array
                let encoder = JSONEncoder()
                encoder.outputFormatting = .prettyPrinted
                let data = try! encoder.encode(users)
                let jsonString = String(data: data, encoding: .utf8)!

                print(jsonString)
            }
    }
}

#Preview {
    AccountCreationView()
        .environmentObject(AppModel())
}
