//
//  NewsResponseObject.swift
//  NewsApp
//
//  Created by Elizaveta Potapova on 11/13/24.
//

import Foundation

struct NewsResponseObject: Codable {
    let totalResults: Int
    let articles: [ArticleResponseObject]

    enum CodingKeys: CodingKey {
        case totalResults
        case articles
    }
}
