//
//  Quiz_appApp.swift
//  Quiz-app
//
//  Created by Luka Salopek on 16.08.2025..
//

import SwiftUI
import ComposableArchitecture

@main
struct Quiz_appApp: App {
    var body: some Scene {
        WindowGroup {
            StartPageView(store: Store(initialState: Quiz.State()){
                Quiz()
            })
        }
    }
}
