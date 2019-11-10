//
//  CategoriesViewModel.swift
//  PersonalityTest
//
//  Created by abuzeid on 11/10/19.
//  Copyright © 2019 abuzeid. All rights reserved.
//

import Foundation
import RxOptional
import RxSwift

protocol CategoriesViewModel {
    var showProgress: Observable<Bool> { get }
    var categories: Observable<[Category]> { get }
    var error: Observable<Error> { get }
    func showQuestionsList(of category: Category)
    func loadData()
}

final class CategoriesListViewModel: CategoriesViewModel {
    // MARK: private state

    private let disposeBag = DisposeBag()
    private let dataRepository: QuestionsRepo
    private let _categories = PublishSubject<[Category]>()
    private let _showProgress = PublishSubject<Bool>()
    private let _error = PublishSubject<Error>()
    private var currentCategory: Category?

    // MARK: Observers

    var showProgress: Observable<Bool> {
        return _showProgress.asObservable()
    }

    var categories: Observable<[Category]> {
        return _categories.asObservable()
    }

    var error: Observable<Error> {
        return _error.asObservable()
    }

    /// initializier
    /// - Parameter apiClient: network handler
    init(repo: QuestionsRepo = QuestionsRepo()) {
        self.dataRepository = repo
    }

    func loadData() {
        _categories.onNext(dataRepository.loadQuestions())
    }

    func showQuestionsList(of category: Category) {
        try? AppNavigator().push(.questions(category))
    }
}

// MARK: AlbumsListViewModel (Private)

private extension CategoriesListViewModel {
    func loadOnlineData(_ showLoader: Bool) {
//        showLoader ? showProgress.onNext(true) : ()
//        let result: Observable<AlbumsResponse?> = apiClient.getData(of: AlbumsApi.albumsFor(artist: currentArtist?.name ?? ""))
//        result.subscribe(onNext: { [unowned self] value in
//            showLoader ? self.showProgress.onNext(false) : ()
//            self.updateUIWithArtists(value?.topalbums?.album ?? [])
//        }, onError: { [unowned self] err in
//            self.error.onNext(err)
//        }).disposed(by: disposeBag)
    }
}