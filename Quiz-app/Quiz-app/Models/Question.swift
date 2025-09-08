//
//  Question.swift
//  Quiz-app
//
//  Created by Luka Salopek on 17.08.2025..
//

import Foundation


struct Question: Codable, Equatable{
    var question: String
    var correctAnswer: String
    var incorrectAnswers: [String]
    var difficulty: String
    var category: String
    var allAnswers: [String] {
        return [correctAnswer] + incorrectAnswers
    }
    
    var shuffledAnswers: [String] {
        var shuffledAnswers = allAnswers
        shuffledAnswers.shuffle()
        return shuffledAnswers
    }
    
}
struct questionResponse: Codable {
    var results: [Question]?
    var responseCode: Int
}
