//
//  ContentView.swift
//  Quiz-app
//
//  Created by Luka Salopek on 16.08.2025..
//

import SwiftUI
import ComposableArchitecture

struct StartPageView: View {
    var store: StoreOf<Quiz>
    var body: some View {
        NavigationStack {
            ZStack {
                LinearBackground()
                
                VStack {
                    Image("580b585b2edbce24c47b2a0c")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 300, height: 300)
                    Text("Quiz Time!")
                        .font(.system(size: 36, weight: .black, design: .rounded))
                        .foregroundColor(.white)
                        .shadow(color: Color.purple.opacity(0.7), radius: 8, x: 0, y: 4)
                    
                    Spacer()
                    
                    VStack(spacing: 20) {
                        Button {
                            store.send(.goToCategoryList)
                        } label: {
                            ZStack {
                                RoundedRectangle(cornerRadius: 28)
                                    .fill(Color.white.opacity(0.22))
                                    .blur(radius: 6)
                                    .frame(width: 300, height: 86)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 28)
                                            .stroke(LinearGradient(colors: [Color.purple, Color.cyan], startPoint: .leading, endPoint: .trailing), lineWidth: 4)
                                    )
                                Text("Get started")
                                    .font(.system(size: 36, weight: .black, design: .rounded))
                                    .foregroundColor(.white)
                                    .shadow(color: Color.purple.opacity(0.7), radius: 8, x: 0, y: 4)
                                    .shadow(color: Color.cyan.opacity(0.4), radius: 16, x: 0, y: 4)
                                    .scaledToFit()
                                    .minimumScaleFactor(0.5)
                                    .padding()
                            }
                        }
                        
                        NavigationLink {
                            IfLetStore(
                                    store.scope(state: \.$question, action: \.question)
                                ) { questionStore in
                                    StatisticsView(store: questionStore)  
                                } else: {
                                    StatisticsView(
                                        store: Store(
                                            initialState: QuestionReducer.State()
                                        ) {
                                            QuestionReducer()
                                        }
                                    )
                                }
                        } label: {
                            ZStack {
                                RoundedRectangle(cornerRadius: 28)
                                    .fill(Color.white.opacity(0.22))
                                    .blur(radius: 6)
                                    .frame(width: 220, height: 86)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 28)
                                            .stroke(LinearGradient(colors: [Color.purple, Color.red], startPoint: .leading, endPoint: .trailing), lineWidth: 4)
                                    )
                                
                                Text("My Stats")
                                    .font(.system(size: 26, weight: .black, design: .rounded))
                                    .foregroundColor(.white)
                                    .shadow(color: Color.purple.opacity(0.7), radius: 8, x: 0, y: 4)
                                    .shadow(color: Color.cyan.opacity(0.4), radius: 16, x: 0, y: 4)
                                    .scaledToFit()
                                    .minimumScaleFactor(0.5)
                                    .padding()
                            }
                        }
                    }
                    
                    Spacer()
                }
                if store.showCategoryList {
                    QuizPageView(store: store)
                }
                
            }
            
            
            
        }
        .navigationBarBackButtonHidden()
    }
}

#Preview {
    StartPageView(store: Store(initialState: Quiz.State()){
        Quiz()
    })
}
