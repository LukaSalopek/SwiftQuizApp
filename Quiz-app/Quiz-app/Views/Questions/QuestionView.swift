//
//  QuestionView.swift
//  Quiz-app
//
//  Created by Luka Salopek on 17.08.2025..
//

import SwiftUI
import ComposableArchitecture


struct QuestionView: View {
    let store: StoreOf<QuestionReducer>
    
    var body: some View {
        WithViewStore(store, observe: { $0 }) { viewStore in
            ZStack {
                LinearBackground()
                
                VStack(spacing: 38) {
                    QuestionViewQuestion(
                        question: viewStore.questions[viewStore.currentQuestionIndex],
                        number: viewStore.currentQuestionIndex
                    )
                    .padding(30)
                    .background(
                        RoundedRectangle(cornerRadius: 22)
                            .fill(Color.white.opacity(0.15))
                            .blur(radius: 1.5)
                            .shadow(color: Color.purple.opacity(0.17), radius: 12, x: 0, y: 8)
                    )
                    .padding(.horizontal, 28)
                    
                    VStack(spacing: 22) {
                        ForEach(viewStore.questions[viewStore.currentQuestionIndex].shuffledAnswers, id: \.self) { answer in
                            QuestionViewAnswers(answer: answer)
                                .onTapGesture {
                                    viewStore.send(.answerCheck(answer))
                                }
                        }
                    }
                    
                    Spacer()
                    
                    Button {
                            viewStore.send(.isFinishedEarly(true))
                        
                    } label: {
                        Text("Give up?")
                            .foregroundStyle(.white)
                    }
                }
                .padding(.top, 40)
                .animation(.easeInOut(duration: 0.5), value: viewStore.currentQuestionIndex)
                
                
            }
            .animation(.easeInOut(duration: 0.5), value: viewStore.isFinished)
            .navigationBarBackButtonHidden()

        }
        
    }
}


#Preview {
    QuestionView(
        store: Store(initialState: QuestionReducer.State.init(questions:[ Question(question: "Test", correctAnswer: "Test", incorrectAnswers: ["Test"], difficulty: "Test", category: "Test")], currentQuestion: Question(question: "Test", correctAnswer: "Test", incorrectAnswers: ["Test"], difficulty: "Test", category: "Test"), currentQuestionIndex: 0, score: 1, isFinished: false, goHome: false, quizesPlayed: 1, correctAnswers: 1, longestStreak: 1)){
            QuestionReducer()
        }
    )
}




private struct QuestionViewQuestion : View {
    var question: Question
    var number : Int
    var body: some View{
        VStack(alignment: .leading, spacing: 16) {
            Text("Question \((number) + 1)")
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.system(size: 22, weight: .semibold, design: .rounded))
                .foregroundColor(.white)
            
            Text(String(htmlEncodedString: question.question) ?? "")
                .font(.system(size: 26, weight: .bold, design: .rounded))
                .foregroundColor(.white)
                .lineLimit(nil)
                .multilineTextAlignment(.leading)
        }
    }
}


private struct QuestionViewAnswers : View {
    var answer: String
    
    var body: some View{
        Text(String(htmlEncodedString: answer) ?? "")
            .font(.system(size: 22, weight: .semibold, design: .rounded))
            .foregroundColor(.white)
            .padding(.vertical, 22)
            .frame(maxWidth: .infinity)
            .background(
                LinearGradient(
                    gradient: Gradient(colors: [Color.purple.opacity(0.7), Color.cyan.opacity(0.85)]),
                    startPoint: .leading,
                    endPoint: .trailing
                )
                .cornerRadius(20)
                .shadow(color: Color.black.opacity(0.25), radius: 8, x: 0, y: 4)
            )
            .padding(.horizontal, 40)
    }
}
