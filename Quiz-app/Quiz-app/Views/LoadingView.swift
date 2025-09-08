//
//  LoadingView.swift
//  Quiz-app
//
//  Created by Luka Salopek on 18.08.2025..
//

import SwiftUI
import ComposableArchitecture


struct ActivityIndicatorView: UIViewRepresentable {
    
    func makeUIView(context: Context) -> UIActivityIndicatorView {
        let activityIndicatorView = UIActivityIndicatorView(style: .large)
        activityIndicatorView.color=UIColor.purple
        activityIndicatorView.startAnimating()
        return activityIndicatorView
        
    }
    
    func updateUIView(_ uiView: UIActivityIndicatorView, context: Context) {
    }
}


struct LoadingView: View {
    var store: StoreOf<QuestionReducer>
    var body: some View {
        
        WithViewStore(store, observe: { $0 }) { viewStore in
            ZStack {
                LinearBackground()
                
                VStack{
                    ActivityIndicatorView()
                    Button{
                        viewStore.send(.hideLoadingView)
                    } label: {
                        Text("Return")
                            .foregroundStyle(.white)
                            .frame(alignment: .topLeading)
                    }
                    
                    
                }
            }
        }
    }
}
