//
//  RecentBookRepositoryProtocol.swift
//  AdvanceProject0509
//
//  Created by tlswo on 5/14/25.
//

import RxSwift

// MARK: - LocalRecentBookRepositoryProtocol

protocol LocalRecentBookRepositoryProtocol {
    func load() -> Single<[BookItem]>
    func save(_ book: BookItem) -> Completable
}
