//
//  QuizPageView.swift
//  Quiz-app
//
//  Created by Luka Salopek on 16.08.2025..
//

import SwiftUI
import ComposableArchitecture

struct QuizPageView: View {
    let store: StoreOf<Quiz>
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        ZStack {
            WithViewStore(store, observe: { $0 }) { viewStore in
                ZStack {
                    LinearBackground()
                        .ignoresSafeArea()
                    
                    ScrollView {
                        VStack(spacing: 16) {
                            HeaderView(store: store, bool: viewStore.showQuiz)
                            
                            ForEach(viewStore.categories) { category in
                                CategoryButton(
                                    category: category,
                                    action: { viewStore.send(.categorySelected(category.id))
                                    }
                                )
                            }
                        }
                        .padding(.horizontal)
                    }
                }
                .ignoresSafeArea()
                .onAppear {
                    viewStore.send(.loadCategories)
                }
                .onChange(of: viewStore.goHome){ value, newvalue in
                    dismiss()
                    
                }
                if viewStore.showQuiz {
                    IfLetStore(
                        store.scope(state: \.$question, action: \.question)
                    ) { questionStore in
                        QuestionManagerView(questionStore: questionStore)
                    }
                }
                
            }
        }
    }
    
}

private struct HeaderView: View {
    let store: StoreOf<Quiz>
    var bool: Bool
    
    var body: some View {
        WithViewStore(store, observe: { $0 }) { viewStore in
            ZStack {
                RoundedRectangle(cornerRadius: 28)
                    .fill(Color.white.opacity(0.22))
                    .blur(radius: 6)
                    .frame(height: 100)
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
                
                HStack(spacing: 8) {
                    Image(systemName: "sparkles")
                        .foregroundColor(Color.cyan.opacity(0.6))
                        .font(.system(size: 30))
                    Text("Pick Your Quiz Category")
                        .font(.system(size: 36, weight: .black, design: .rounded))
                        .foregroundColor(.white)
                        .shadow(color: Color.purple.opacity(0.7), radius: 8, x: 0, y: 4)
                }
                .padding()
            }
            .padding(.top, 90)
            .navigationBarBackButtonHidden()
            .toolbar{
                ToolbarItem(placement: .navigationBarLeading) {
                    if !bool {
                        Button{
                            viewStore.send(.goToCategoryList)
                        } label: {
                            Text("Back")
                                .font(.body)
                                .foregroundColor(.white)
                        }
                        .padding()
                    }
                }
            }
        }
    }
}
private struct CategoryButton: View {
    let category: Categories
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(category.name)
                .frame(maxWidth: .infinity)
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 16)
                        .fill(Color.white.opacity(0.2))
                        .overlay(
                            RoundedRectangle(cornerRadius: 16)
                                .stroke(
                                    LinearGradient(
                                        gradient: Gradient(colors: [Color.purple, Color.cyan]),
                                        startPoint: .top,
                                        endPoint: .bottom
                                    ),
                                    lineWidth: 2
                                )
                        )
                )
                .foregroundColor(.white)
                .font(.title2)
        }
        .buttonStyle(PlainButtonStyle())
    }
}
#Preview {
    QuizPageView(store: Store(initialState: Quiz.State()){
        Quiz()
    }
    )
}
