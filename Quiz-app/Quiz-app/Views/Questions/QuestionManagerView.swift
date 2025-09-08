//
//  QuestionManagerView.swift
//  Quiz-app
//
//  Created by Luka Salopek on 17.08.2025..
//

import SwiftUI
import ComposableArchitecture

struct QuestionManagerView: View {
    var questionStore: StoreOf<QuestionReducer>

    var body: some View {
        WithViewStore(questionStore, observe: { $0 }) { viewStore in
            ZStack {
                if viewStore.isFinished {
                    QuizEnd(store: questionStore)
                        .transition(.scale.combined(with: .opacity))
                        .zIndex(1)
                } else if !viewStore.questions.isEmpty {
                    QuestionView(store: questionStore)
                }
                if viewStore.loadingView{
                    LoadingView(store: questionStore)
                }
            }
            .onAppear {
                if viewStore.questions.isEmpty {
                    viewStore.send(.showLoadingView)
                }
            }
        }
    }
}

#Preview {
    QuestionManagerView(questionStore: Store(initialState: QuestionReducer.State()) {
        QuestionReducer()
    })
}
