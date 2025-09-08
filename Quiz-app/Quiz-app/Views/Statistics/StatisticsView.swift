//
//  StatisticsView.swift
//  Quiz-app
//
//  Created by Luka Salopek on 18.08.2025..
//

import SwiftUI
import ComposableArchitecture
import Dependencies

struct StatisticsView: View {
    var store: StoreOf<QuestionReducer>
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        WithViewStore(store, observe: { $0 }) { viewstore in
            ZStack {
                LinearBackground()
                
                VStack {
                    Text("Statistics")
                        .font(.system(size: 36, weight: .black, design: .rounded))
                        .foregroundColor(.white)
                        .shadow(color: Color.purple.opacity(0.7), radius: 8, x: 0, y: 4)
                        .padding(.bottom, 100)
                    
                    Text("Total quizes played: \(viewstore.quizesPlayed)")
                        .font(.system(size: 26, weight: .black, design: .rounded))
                        .foregroundColor(.white)
                        .shadow(color: Color.purple.opacity(0.7), radius: 8, x: 0, y: 4)
                    
                    Text("Correct answers: \(viewstore.correctAnswers) / \(viewstore.currentQuestionCount)")
                        .font(.system(size: 26, weight: .black, design: .rounded))
                        .foregroundColor(.white)
                        .shadow(color: Color.purple.opacity(0.7), radius: 8, x: 0, y: 4)
                    
                    Text("Longest correct streak: \(viewstore.longestStreak)")
                        .font(.system(size: 26, weight: .black, design: .rounded))
                        .foregroundColor(.white)
                        .shadow(color: Color.purple.opacity(0.7), radius: 8, x: 0, y: 4)
                }
            }
            .navigationBarBackButtonHidden()
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        dismiss()
                    } label: {
                        Text("Back")
                            .font(.body)
                            .foregroundColor(.white)
                    }
                    .padding()
                }
            }
            .id(viewstore.quizesPlayed)
            .task {
                viewstore.send(.refreshData)
            }
        }
    }
}
#Preview {
    StatisticsView(store: Store(initialState: QuestionReducer.State()){
        QuestionReducer()
    })
}
