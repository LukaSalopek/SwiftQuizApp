//
//  QuizEnd.swift
//  Quiz-app
//
//  Created by Luka Salopek on 18.08.2025..
//

import SwiftUI
import ComposableArchitecture


struct QuizEnd: View {
    var store: StoreOf<QuestionReducer>
    @Environment(\.dismiss) private var dismiss
    var body: some View {
        WithViewStore(store, observe: { $0 }){ viewstore in
            NavigationStack{
                ZStack{
                    LinearBackground()
                    
                    VStack{
                        Text("Quiz Results")
                            .font(.system(size: 36, weight: .black, design: .rounded))
                            .foregroundColor(.white)
                            .shadow(color: Color.purple.opacity(0.7), radius: 8, x: 0, y: 4)
                        
                        ZStack{
                            Circle()
                                .stroke(LinearGradient(
                                    colors: [Color.purple, Color.cyan],
                                    startPoint: .leading,
                                    endPoint: .trailing), lineWidth: 8)
                                .frame(width: 300)
                                .overlay(
                                    Circle()
                                        .opacity(0.2)
                                        .foregroundColor(.white)
                                )
                            
                            Text("\(viewstore.score)/\(viewstore.currentQuestionIndex + 1)")
                                .font(.system(size: 50, weight: .black, design: .rounded))
                                .foregroundStyle(.white)
                        }
                        
                        Text("\(viewstore.summaryMessage.summary[viewstore.score])")
                            .font(.system(size: 20, weight: .bold, design: .rounded))
                                                            .foregroundColor(.white)
                                                            .multilineTextAlignment(.center)
                                                            .padding()
                        
                        Button{
                            viewstore.send(.showQuiz)
                            viewstore.send(.isFinished(true))
                        } label: {
                            ZStack{
                                RoundedRectangle(cornerRadius: 28)
                                    .fill(Color.white.opacity(0.22))
                                    .blur(radius: 6)
                                    .frame(width: 200,height: 70)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 28)
                                            .stroke(
                                                LinearGradient(
                                                    colors: [Color.purple, Color.cyan],
                                                    startPoint: .leading,
                                                    endPoint: .trailing
                                                ),
                                                lineWidth: 4
                                            )
                                    )
                                Text("Let's try again!")
                                    .font(.system(size: 20, weight: .bold, design: .rounded))
                                    .foregroundStyle(.white)
                            }
                            
                        }
                        
                        Button{
                            viewstore.send(.showQuiz)
                            viewstore.send(.goToCategoryList)
                            dismiss()
                            
                        } label: {
                            ZStack{
                                RoundedRectangle(cornerRadius: 28)
                                    .fill(Color.white.opacity(0.22))
                                    .blur(radius: 6)
                                    .frame(width: 150,height: 70)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 28)
                                            .stroke(
                                                LinearGradient(
                                                    colors: [Color.purple, Color.cyan],
                                                    startPoint: .leading,
                                                    endPoint: .trailing
                                                ),
                                                lineWidth: 4
                                            )
                                    )
                                Text("Return to Home")
                                    .font(.system(size: 16, weight: .bold, design: .rounded))
                                    .foregroundStyle(.white)
                            }
                        }
                    }
                }
            }
        }
        
        
    }
}

#Preview {
    QuizEnd(store: Store(initialState: QuestionReducer.State()) {
        QuestionReducer()
    })
}
