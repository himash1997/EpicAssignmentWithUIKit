//
//  CastService.swift
//  EpicAssignmentWithUiKit
//
//  Created by Himash Nadeeshan on 2021-11-11.
//

import Foundation
import Combine

protocol CastService {
    var networkManager: APIService {get}
    func getCastList(limit: Int) -> AnyPublisher<[Cast], APIError>
}

extension CastService {
    func getCastList(limit: Int) -> AnyPublisher<[Cast], APIError> {
        return networkManager.request(with: CastEndPoint.castList(limit))
            .eraseToAnyPublisher()
    }
}
