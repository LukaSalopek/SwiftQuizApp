//
//  Categories.swift
//  Quiz-app
//
//  Created by Luka Salopek on 17.08.2025..
//

import Foundation


struct Categories: Identifiable, Codable, Equatable {
    var id : Int
    var name: String
}


struct CategoriesData: Codable, Equatable {
    var triviaCategories: [Categories]
}
