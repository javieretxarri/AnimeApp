//
//  AnimeAppApp.swift
//  AnimeApp
//
//  Created by Javier Etxarri on 5/4/23.
//

import SwiftUI

@main
struct AnimeAppApp: App {
    @StateObject var vm = AnimesVM()

    var body: some Scene {
        WindowGroup {
            StateAppView()
                .environmentObject(vm)
                .onAppear {
                    print(URL.documentsDirectory)
                }
        }
    }
}
