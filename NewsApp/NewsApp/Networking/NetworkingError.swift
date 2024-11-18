//
//  NetworkingError.swift
//  NewsApp
//
//  Created by Elizaveta Potapova on 11/13/24.
//

import Foundation

enum NetworkingError: Error {
    case networkingError(_ error: Error)
    case unknown
}
