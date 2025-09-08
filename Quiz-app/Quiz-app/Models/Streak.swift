//
//  Streak.swift
//  Quiz-app
//
//  Created by Luka Salopek on 19.08.2025..
//

import Foundation
import Dependencies


struct StreakClient{
    var getLongestStreak:() -> Int
    var setLongestStreak:(Int) -> ()
    var getCorrectAnswersCount:() -> Int
    var setCorrectAnswersCount:(Int) -> ()
    var getTotalQuizCount:() -> Int
    var setTotalQuizCount:(Int) -> ()
    var getCurrentStreak:() -> Int
    var setCurrentStreak:(Int) -> ()
    var setQuestionsAnsweredCount:(Int) -> ()
    var getQuestionsAnsweredCount:() -> Int
}


struct StreakClientKeyed: DependencyKey {
    static let liveValue: StreakClient = StreakClient(
        getLongestStreak: {
            UserDefaults.standard.integer(forKey: "streak")
        },
        setLongestStreak: { streak in
            UserDefaults.standard.set(streak, forKey: "streak")
        },
        getCorrectAnswersCount: {
            UserDefaults.standard.integer(forKey: "correctAnswersCount")
        },
        setCorrectAnswersCount: { count in
            UserDefaults.standard.set(count, forKey: "correctAnswersCount")
        },
        getTotalQuizCount: {
            UserDefaults.standard.integer(forKey: "totalQuizCount")
        },
        setTotalQuizCount: { count in
            UserDefaults.standard.set(count, forKey: "totalQuizCount")
        },
        getCurrentStreak: {
            UserDefaults.standard.integer(forKey: "currentStreak")
        },
        setCurrentStreak: { streak in
            UserDefaults.standard.set(streak, forKey: "currentStreak")
        },
        setQuestionsAnsweredCount: { count in
            UserDefaults.standard.set(count, forKey: "questionsAnweredCount")
        },
        getQuestionsAnsweredCount: {
            UserDefaults.standard.integer(forKey: "questionsAnweredCount")
        }
    )
}

extension DependencyValues{
    var streakClient : StreakClient {
        get {
            self[StreakClientKeyed.self]
        } set {
            self[StreakClientKeyed.self] = newValue
        }
    }
}

