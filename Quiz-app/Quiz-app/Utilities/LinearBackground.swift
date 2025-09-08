//
//  LinearBackground.swift
//  Quiz-app
//
//  Created by Luka Salopek on 16.08.2025..
//

import Foundation
import SwiftUI


struct LinearBackground: View {
    var body: some View {
        LinearGradient(colors: [.purple, .mint], startPoint: .topLeading, endPoint: .bottomTrailing)
            .ignoresSafeArea()
    }
}
