//
//  ArticleCellViewModel.swift
//  NewsApp
//
//  Created by Elizaveta Potapova on 11/13/24.
//

import Foundation

struct ArticleCellViewModel {
    let title: String
    let description: String
    let date: String
    let imageUrl: String
    var imageData: Data?
    
    
    init(article: ArticleResponseObject) {
        title = article.title
        description = article.description ?? ""
        date = article.date
        imageUrl = article.urlToImage ?? "" 
    }
}
