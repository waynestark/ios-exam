//
//  PeopleViewModel.swift
//  RandomMe
//
//  Created by Marwin Carino on 7/26/22.
//

import Foundation

import RxRelay
import RxSwift

class PeopleViewModel {
  // MARK: - Properties

  let state = PublishSubject<ContentState>()

  private var page = 1

  private(set) var gender: Gender
  private(set) var people: [People] = []

  private let peopleService: PeopleServiceProtocol
  private let disposeBag = DisposeBag()

  init(
    gender: Gender,
    peopleService: PeopleServiceProtocol = App.shared.peopleService
  ) {
    self.gender = gender
    self.peopleService = peopleService
  }
}

// MARK: - Methods

private extension PeopleViewModel {
  func loadPeople(
    gender: Gender,
    page: Int? = nil,
    completion: @escaping (Result<[People], Error>) -> Void
  ) {
    peopleService.loadPeople(
      gender: gender,
      page: page,
      onSuccess: { people in
        completion(.success(people))
      },
      onError: { error in
        completion(.failure(error))
      }
    )
  }

  func loadNextPeople(
    gender: Gender,
    page: Int,
    completion: @escaping (Result<[People], Error>) -> Void
  ) {
    peopleService.loadPeople(
      gender: gender,
      page: page,
      onSuccess: { people in
        completion(.success(people))
      },
      onError: { error in
        completion(.failure(error))
      }
    )
  }

  func updateState() {
    if people.isEmpty {
      state.onNext(.empty)
    } else {
      state.onNext(.ready)
    }
  }
}

// MARK: - Handlers

private extension PeopleViewModel {
  func handleLoadPoepleSuccess(_ people: [People]) {
    self.people = people
    updateState()
  }

  func handleLoadNextPoepleSuccess(_ people: [People]) {
    self.people.append(contentsOf: people)
    state.onNext(.ready)
  }

  func handleLoadPoepleError(_ error: Error) {
    state.onNext(.error)
  }
}

// MARK: - Helpers

extension PeopleViewModel {
  func selectGender(at index: Int) {
    guard index < genders.count else {
      preconditionFailure("Expected index to be less than the count of genders")
    }

    gender = genders[index]
  }

  func load() {
    page = 1

    state.onNext(.loading)

    loadPeople(
      gender: gender,
      page: page
    ) { result in
      switch result {
      case let .success(people):
        self.handleLoadPoepleSuccess(people)
      case let .failure(error):
        self.handleLoadPoepleError(error)
      }
    }
  }

  func loadNextPage() {
    page += 1

    loadPeople(
      gender: gender,
      page: page
    ) { result in
      switch result {
      case let .success(people):
        self.handleLoadNextPoepleSuccess(people)
      case .failure(_):
        return
      }
    }
  }

  func refresh() {
    loadPeople(
      gender: gender
    ) { result in
      switch result {
      case let .success(people):
        self.handleLoadPoepleSuccess(people)
      case let .failure(error):
        self.handleLoadPoepleError(error)
      }
    }
  }

  func createPeopleTableCellVM(for indexPath: IndexPath) -> PeopleTableCellViewModel {
    let people = people[indexPath.row]

    let vm = PeopleTableCellViewModel(
      thumbnail: people.picture.thumbnail ?? "",
      name: people.name,
      phone: people.phone,
      email: people.email,
      location: people.location
    )

    return vm
  }
    
    func createPeopleDetailsCellVM(for indexPath: IndexPath) -> PeopleDetailsViewModel {
      let people = people[indexPath.row]

      let vm = PeopleDetailsViewModel(people: people)

      return vm
    }
}

// MARK: - Getters

extension PeopleViewModel {
  var genders: [Gender] { Gender.allCases }
}

// MARK: - Enums

enum Gender: String, CaseIterable {
  case male
  case female
}

enum ContentState: Equatable {
  case empty
  case ready
  case loading
  case error
}
