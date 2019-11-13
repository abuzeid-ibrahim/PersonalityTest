//
//  QuestionsViewModel.swift
//  PersonalityTest
//
//  Created by abuzeid on 11/10/19.
//  Copyright © 2019 abuzeid. All rights reserved.
//

import Foundation
import RxOptional
import RxSwift

protocol QuestionsViewModel {
    var showProgress: Observable<Bool> { get }
    var questions: Observable<[QuestionSectionModel]> { get }
    var error: Observable<Error> { get }
    var conditionalQuestion: Observable<TableViewEditingCommand> { get }
    var hideQuestion: Observable<TableViewEditingCommand> { get }
    func answerQuestions(of index:IndexPath)
    func removeAnswer(of: IndexPath)
    func loadData()
    func submitAll(sender: Any)
}

final class QuestionsListViewModel: QuestionsViewModel {
    // MARK: private state

    private let disposeBag = DisposeBag()
    private let dataRepository: QuestionsRepo
    private let _questions = PublishSubject<[QuestionSectionModel]>()
    private let _showProgress = PublishSubject<Bool>()
    private let _error = PublishSubject<Error>()
    private var category: Category
    private let _hideQuestion = PublishSubject<TableViewEditingCommand>()
    private let _showQuestion = PublishSubject<TableViewEditingCommand>()

    private var questionsBuffer: [QuestionSectionModel] = []

    // MARK: Observers

    var showProgress: Observable<Bool> {
        return _showProgress.asObservable()
    }

    var questions: Observable<[QuestionSectionModel]> {
        return _questions.asObservable()
    }

    var error: Observable<Error> {
        return _error.asObservable()
    }

    var conditionalQuestion: Observable<TableViewEditingCommand> {
        _showQuestion.asObservable()
    }

    var hideQuestion: Observable<TableViewEditingCommand> {
        _hideQuestion.asObservable()
    }

    init(repo: QuestionsRepo = QuestionsRepo(), category: Category) {
        self.dataRepository = repo
        self.category = category
    }

    func loadData() {
        questionsBuffer = getQuestions(of: category)
        _questions.onNext(questionsBuffer)
    }

    func answerQuestions(of index: IndexPath) {
//        guard let type = questionsBuffer[of.section].type else { return }
        guard let rowCommand = showSubmitCell(index: index) else { return }
//        _showQuestion.onNext(rowCommand)
//        switch type {
//        case .singleChoice:
//            questionsBuffer[of.section].answer = [questionsBuffer[of.section].items[of.row]]
//        case .singleChoiceConditional:
//            questionsBuffer[of.section].answer = [questionsBuffer[of.section].items[of.row]]
//            guard let rowCommand = showConditionalCell(questionsBuffer[of.section], index: of) else { return }
//            _showQuestion.onNext(rowCommand)
//        case .numberRange:
//            print("TODO")
//        }
    }

    func removeAnswer(of: IndexPath) {
        guard let type = questionsBuffer[of.section].type else { return }
        switch type {
        case .singleChoice:
            questionsBuffer[of.section].answer = []

        case .singleChoiceConditional:
            questionsBuffer[of.section].answer = []
            _hideQuestion.onNext(TableViewEditingCommand.DeleteItem(of))
        case .numberRange:
            print("TODO")
        }
    }

    func submitAll(sender: Any) {}

    func submitAnswers(of question: QuestionSectionModel, answer: String...) {
        ///todo
    }
}

// MARK: QuestionsListViewModel (Private)

private extension QuestionsListViewModel {
    func getQuestions(of cat: Category) -> [QuestionSectionModel] {
        return dataRepository.loadQuestions()
            .filter { $0.category == Optional<Category>.some(cat) }
            .map { $0.toSectionalModel() }
    }

//    private func showConditionalCell(_ model: QuestionSectionModel, index: IndexPath) -> TableViewEditingCommand? {
////        guard let obj = model.condition?.ifPositive else { return .none }
//        let cellData = AnswerCellData(option: "XXX", isSelected: false)
//        return TableViewEditingCommand.AppendItem(item: cellData, index: index)
//    }
    private func showSubmitCell(index: IndexPath) -> TableViewEditingCommand? {
        let cellData = AnswerCellData(option: "Submit", cellType: .submitCell(state: false))
          return TableViewEditingCommand.AppendItem(item: cellData, index: index)
      }
}

extension Question {
    func toSectionalModel() -> QuestionSectionModel {
        let options = questionType?.options?.compactMap { AnswerCellData(option: $0) }
        return QuestionSectionModel(question: question ?? "", items: options ?? [], condition: questionType?.condition, type: questionType?.type)
    }
}
