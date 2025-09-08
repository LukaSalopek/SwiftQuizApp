//
//  Quiz.swift
//  Quiz-app
//
//  Created by Luka Salopek on 17.08.2025..
//

import Foundation
import ComposableArchitecture
import Dependencies

@Reducer
struct Quiz{
    
    @ObservableState
    struct State : Equatable{
        
        var category: String? = nil
        var categories: [Categories] = []
        @Presents var question: QuestionReducer.State?
        var goHome: Bool = false
        var showQuiz: Bool = false
        var showCategoryList: Bool = false
    }
    enum Action{
        case loadCategories
        case loadCategories2([Categories])
        case categorySelected(Int)
        case question(PresentationAction<QuestionReducer.Action>)
        case showQuiz
        case goToCategoryList
    }
    
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .loadCategories:
                return .run { send in
                    let(data, _) = try await URLSession.shared.data(from: URL(string: "https://opentdb.com/api_category.php")!)
                    let jsonDecorder = JSONDecoder()
                    jsonDecorder.keyDecodingStrategy = .convertFromSnakeCase
                    let categories = try! jsonDecorder.decode(CategoriesData.self, from: data)
                    await send(.loadCategories2(categories.triviaCategories))
                    
                }
                
            case .loadCategories2(let categories):
                state.categories = categories
                return .none
                
                
            case .categorySelected(let categoryId):
                state.question = QuestionReducer.State()
                state.showQuiz = true
                return .run { send in
                    await send(.question(.presented(.loadQuestions(categoryId))))
                }
                
                
                
                    
            case .question(.presented(.isFinished(_))):
                state.question = nil
                return .none

                
            case .question(.presented(.goHome(_))):
                state.goHome.toggle()
                return .none
            case .question(.presented(.showQuiz)):
                return .send(.showQuiz)
                
            case .question(.presented(.goToCategoryList)):
                return .send(.goToCategoryList)
                
            case .showQuiz:
                state.showQuiz.toggle()
                return .none
                
            case .goToCategoryList:
                state.showCategoryList.toggle()
                return .none
            case .question:
                return .none
            }
        
            
            
        }
        
        .ifLet(\.$question, action: \.question){
            QuestionReducer()
        }
    }
}
