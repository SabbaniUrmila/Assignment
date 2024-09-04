//
//  AssignmentApp.swift
//  Assignment
//
//  Created by Urmila on 03/09/24.
//

import SwiftUI

@main
struct AssignmentApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
struct HomeViewControllerWrapper: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> HomeViewController {
        return HomeViewController()
    }
    
    func updateUIViewController(_ uiViewController: HomeViewController, context: Context) {
    }
}
