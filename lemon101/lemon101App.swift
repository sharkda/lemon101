//
//  lemon101App.swift
//  lemon101
//
//  Created by Jim Hsu on 2021/12/29.
//

import SwiftUI
import Firebase

@main
struct lemon101App: App {
    
    var viewModel:LemonObservable
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(viewModel)
        }
    }
    
    init(){
        FirebaseApp.configure()
        viewModel = LemonObservable.shared
    }
}
