//
//  BusinessViewModel.swift
//  NewsApp
//
//  Created by Elizaveta Potapova on 11/15/24.
//
import Foundation


protocol BusinessViewModelProtocol {
    var reloadData: (() -> Void)? { get set}
    var showError: ((String) -> Void)? { get set }
    var reloadCell: ((Int) -> Void)? { get set }
    
    var numberOfCells: Int { get }
    func loadData()
    
    
    
    func getArticle(for row: Int) -> ArticleCellViewModel
}

final class BusinessViewModel: BusinessViewModelProtocol {
    var reloadData: (() -> Void)?
    var showError: ((String) -> Void)?
    var reloadCell: ((Int) -> Void)?
    
    // MARK: Properties
    var numberOfCells: Int {
        articles.count
    }
    private var articles: [ArticleCellViewModel] = [] {
        didSet {
            DispatchQueue.main.async {
                self.reloadData?()
            }
            
            
        }
    }
    
    init(loadDataOnInit: Bool = true) {
        if loadDataOnInit {
            loadData()
        }
    }
    
    
    func getArticle(for row: Int) -> ArticleCellViewModel {
        return articles[row]
        
    }
    
    func loadData() {
        
        ApiManager.getNews(from: .business) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let articles):
                print("Successfully fetched articles: \(articles.count)")
                self.articles = self.convertToCellViewModel(articles)
                self.loadImage()
            case .failure(let error):
                print("Failed to fetch articles: \(error.localizedDescription)")
                DispatchQueue.main.async {
                    self.showError?(error.localizedDescription)
                }
            }
        }
        
    }
    
    private func loadImage() {
        for (index, article) in articles.enumerated() {
            print("Fetching image for article at index \(index): \(article.imageUrl)")
            ApiManager.getImageData(url: article.imageUrl)
            { [weak self] result in
                
                DispatchQueue.main.async{
                    switch result {
                    case .success(let data):
                        print("Successfully fetched image data for index \(index)")
                        self?.articles[index].imageData = data
                        self?.reloadCell?(index)
                    case .failure(let error):
                        print("Failed to fetch image for index \(index): \(error.localizedDescription)")
                        self?.showError?(error.localizedDescription)
                    }
                }
                
            }
        }
        
        
    }
    
    private func convertToCellViewModel(_ articles: [ArticleResponseObject]) -> [ArticleCellViewModel] {
        print("Converting \(articles.count) articles to cell view models")
        return articles.map { ArticleCellViewModel(article: $0) }
        
    }
    private func setupMockObjects() {
        articles = [
            ArticleCellViewModel(article: ArticleResponseObject(title: "First object title", description: "First object description in the mock object", urlToImage: "...", date: "25.12.2017"))
        ]
    }
    
    
    
}

