//
//  APIError.swift
//  EpicAssignmentWithUiKit
//
//  Created by Himash Nadeeshan on 2021-11-11.
//

import Foundation

enum APIError: Error {
    case decodingError
    case httpError(Int)
    case unknown
}
