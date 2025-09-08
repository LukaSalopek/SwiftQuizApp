//
//  QuestionReducer.swift
//  Quiz-app
//
//  Created by Luka Salopek on 17.08.2025..
//



import Foundation
import ComposableArchitecture
import Dependencies

@Reducer
struct QuestionReducer {
    @ObservationStateIgnored
    @Dependency(\.streakClient) private var streakClient

    @ObservableState
    struct State: Equatable {
        var questions: [Question] = []
        var currentQuestion: Question = Question(question: "", correctAnswer: "", incorrectAnswers: [], difficulty: "", category: "")
        var currentQuestionIndex: Int = 0
        var score: Int = 0
        var isFinished: Bool = false
        var goHome: Bool = false
        var quizesPlayed: Int = 0
        var correctAnswers: Int = 0
        var longestStreak: Int = 0
        var loadingView: Bool = false
        var currentQuestionCount: Int = 0
        var summaryMessage : SummaryMessage = SummaryMessage()
    }

    enum Action {
        case loadQuestions(Int)
        case loadQuestions2([Question])
        case answerCheck(String)
        case isFinished(Bool)
        case isFinishedEarly(Bool)
        case goHome(Bool)
        case refreshData
        case showQuiz
        case goToCategoryList
        case showLoadingView
        case hideLoadingView
        
    }

    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {

            case .answerCheck(let answer):
                let isCorrect = answer == state.questions[state.currentQuestionIndex].correctAnswer

                if isCorrect {
                    state.score += 1
                    let currentStreak = streakClient.getCurrentStreak()
                    streakClient.setCurrentStreak(currentStreak + 1)
                    if currentStreak + 1 > streakClient.getLongestStreak() {
                        streakClient.setLongestStreak(currentStreak + 1)
                    }
                } else {
                    streakClient.setCurrentStreak(0)
                }

                if state.currentQuestionIndex >= state.questions.count - 1 {
                    streakClient.setCorrectAnswersCount(streakClient.getCorrectAnswersCount() + state.score)
                    streakClient.setTotalQuizCount(streakClient.getTotalQuizCount() + 1)
                    let currentAnswerCount=streakClient.getQuestionsAnsweredCount()
                    streakClient.setQuestionsAnsweredCount(currentAnswerCount+state.currentQuestionIndex+1)
                    state.isFinished = true
                } else {
                    state.currentQuestionIndex += 1
                    state.currentQuestion = state.questions[state.currentQuestionIndex]
                }

                return .none

            case .loadQuestions(let id):
                return .run { send in
                    do {
                        let (data, _) = try await URLSession.shared.data(from: URL(string: "https://opentdb.com/api.php?amount=10&category=\(id)")!)
                        let decoder = JSONDecoder()
                        decoder.keyDecodingStrategy = .convertFromSnakeCase
                        let questionsData = try decoder.decode(questionResponse.self, from: data)
                        guard let results = questionsData.results else { throw NSError(domain: "API Error", code: 0, userInfo: nil) }
                        await send(.loadQuestions2(results))
                    } catch {
                        print("Error: \(error)")
                    }
                }

            case .loadQuestions2(let questionResponse):
                state.questions = questionResponse
                state.currentQuestion = questionResponse.first!
                state.currentQuestionIndex = 0
                state.loadingView=false
                return .none

            case .isFinished(let finished):
                state.isFinished = finished
                return .none
                
            case .isFinishedEarly(let finishedEarly):
                let currentAnswerCount=streakClient.getQuestionsAnsweredCount()
                streakClient.setQuestionsAnsweredCount(currentAnswerCount+state.currentQuestionIndex+1)
                streakClient.setCorrectAnswersCount(streakClient.getCorrectAnswersCount() + state.score)
                streakClient.setTotalQuizCount(streakClient.getTotalQuizCount() + 1)
                state.isFinished=finishedEarly
            
                return .none

            case .goHome(_):
                state.goHome = true
                return .none

            case .refreshData:
                state.longestStreak = streakClient.getLongestStreak()
                state.quizesPlayed = streakClient.getTotalQuizCount()
                state.correctAnswers = streakClient.getCorrectAnswersCount()
                state.currentQuestionCount=streakClient.getQuestionsAnsweredCount()
                return .none
            case .showQuiz:
                return .none
                
            case .goToCategoryList:
                return .none
                
            case .showLoadingView:
                state.loadingView=true
                return .none
            case .hideLoadingView:
                state.loadingView=false
                return .none
                
                
            }

        }
    }
}
