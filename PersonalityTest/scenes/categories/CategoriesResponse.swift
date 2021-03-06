//
//  CategoriesResponse.swift
//  PersonalityTest
//
//  Created by abuzeid on 11/10/19.
//  Copyright © 2019 abuzeid. All rights reserved.
//

import Foundation

// MARK: - CategoriesResponse

struct CategoriesResponse: Codable {
    let categories: [QCategory]?
    let questions: [Question]?
}

enum QCategory: String, Codable, CaseIterable {
    case hardFact = "hard_fact"
    case introversion
    case lifestyle
    case passion
}

// MARK: - Question

struct Question: Codable {
    let question: String?
    let category: QCategory?
    var answered = false
    let answers: QuestionOptions?

    enum CodingKeys: String, CodingKey {
        case question
        case category
        case answers = "question_type"
    }

    mutating func setAnswered(_ ans: Bool) {
        answered = ans
    }
}

extension Question: Equatable {
    static func == (lhs: Question, rhs: Question) -> Bool {
        return lhs.question == rhs.question
    }
}

// MARK: - QuestionQuestionType

struct QuestionOptions: Codable {
    let type: QTypeEnum?
    let options: [String]?
    let condition: Condition?
}

// MARK: - Condition

struct Condition: Codable {
    let predicate: Predicate?
    let ifPositive: IfPositive?
    enum CodingKeys: String, CodingKey {
        case predicate
        case ifPositive = "if_positive"
    }
}

// MARK: - IfPositive

struct IfPositive: Codable {
    let question: String?
    let category: QCategory?
    let questionType: IfPositiveQuestionType?

    enum CodingKeys: String, CodingKey {
        case question
        case category
        case questionType = "question_type"
    }
}

// MARK: - IfPositiveQuestionType

struct IfPositiveQuestionType: Codable {
    let type: QTypeEnum?
    let range: Range?
}

// MARK: - Range

struct Range: Codable {
    let from: Int?
    let to: Int?
}

// MARK: - Predicate

struct Predicate: Codable {
    let exactEquals: [String]?
}

enum QTypeEnum: String, Codable, Equatable {
    case singleChoice = "single_choice"
    case singleChoiceConditional = "single_choice_conditional"
    case numberRange = "number_range"
}
