//
//  APIService.swift
//  EpicAssignmentWithUiKit
//
//  Created by Himash Nadeeshan on 2021-11-11.
//

import Foundation
import Combine

protocol APIService {
    func request<T: Decodable>(with builder: RequestBuilder) -> AnyPublisher<T, APIError>
}
