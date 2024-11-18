//
//  DetailsCollectionViewCell.swift
//  NewsApp
//
//  Created by Elizaveta Potapova on 11/13/24.
//

//import UIKit
//import SnapKit
//
//final class DetailsCollectionViewCell: UICollectionViewCell {
//
//    // MARK: GUI Variables
//    private lazy var imageView: UIImageView = {
//        let view = UIImageView()
//        view.image = UIImage(named: "image")
//        view.contentMode = .scaleAspectFill
//        view.layer.masksToBounds = true
//        return view
//    }()
//
//    private lazy var titleLabel: UILabel = {
//        let label = UILabel()
//        label.font = .boldSystemFont(ofSize: 16)
//        label.textColor = .black
//        label.text = "Title here"
//        label.numberOfLines = 2
//        return label
//    }()
//    
//    private lazy var dateLabel: UILabel = {
//        let label = UILabel()
//        label.font = .systemFont(ofSize: 12)
//        label.textColor = .darkGray
//        label.numberOfLines = 0
//        return label
//    }()
//
//
//    private lazy var descriptionLabel: UILabel = {
//        let label = UILabel()
//
//        label.font = .systemFont(ofSize: 14)
//        label.textColor = .gray
//        label.text = "Description for the news should be here. Please, remove this mock text"
//        label.numberOfLines = 0
//        return label
//    }()
//
//    // MARK: Init
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        setupUI()
//        setupConstraints()
//    }
//
//
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//
//    // MARK: Methods
//    
//    func configure(with viewModel: ArticleCellViewModel) {
//        titleLabel.text = viewModel.title
//        dateLabel.text = viewModel.date
//        descriptionLabel.text = viewModel.description
//        if let imageData = viewModel.imageData {
//            imageView.image = UIImage(data: imageData)
//        } else {
//            imageView.image = UIImage(named: "placeholder")
//        }
//    }
//
//    private func setupUI() {
//        addSubview(imageView)
//        addSubview(titleLabel)
//        addSubview(descriptionLabel)
//
//        setupConstraints()
//    }
//    private func setupConstraints() {
//        imageView.snp.makeConstraints { make in
//            make.width.height.equalTo(self.frame.height)
//            make.top.leading.bottom.equalToSuperview()
//
//        }
//
//
//        titleLabel.snp.makeConstraints { make in
//            make.top.trailing.equalToSuperview()
//            make.leading.equalTo(imageView.snp.trailing).offset(5)
//        }
//        
//        dateLabel.snp.makeConstraints { make in
//            make.top.equalTo(titleLabel.snp.bottom).offset(4)
//            make.leading.equalTo(imageView.snp.trailing).offset(8)
//            make.trailing.equalToSuperview().inset(8)
//        }
//
//        descriptionLabel.snp.makeConstraints { make in
//            make.top.equalTo(titleLabel.snp.bottom).offset(5)
//            make.leading.bottom.equalToSuperview()
//            make.trailing.equalToSuperview()
//        }
//    }
//
//}


import UIKit
import SnapKit

final class DetailsCollectionViewCell: UICollectionViewCell {
    // MARK: GUI Variables
    private lazy var imageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.layer.masksToBounds = true
        return view
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 16)
        label.textColor = .black
        label.numberOfLines = 2
        return label
    }()
    
    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12)
        label.textColor = .gray
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.textColor = .darkGray
        label.numberOfLines = 0
        return label
    }()
    
    // MARK: Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupConstraints() 
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Methods
    func configure(with viewModel: ArticleCellViewModel) {
        titleLabel.text = viewModel.title
        descriptionLabel.text = viewModel.description
        dateLabel.text = viewModel.date
        
        if let imageData = viewModel.imageData {
            imageView.image = UIImage(data: imageData)
        } else {
            imageView.image = UIImage(named: "placeholder")
        }
    }
    
    private func setupUI() {
        contentView.addSubview(imageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(dateLabel)
        contentView.addSubview(descriptionLabel)
    }
    
    private func setupConstraints() {
        imageView.snp.makeConstraints { make in
            make.top.leading.bottom.equalToSuperview()
            make.width.equalTo(self.frame.height)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(8)
            make.leading.equalTo(imageView.snp.trailing).offset(8)
            make.trailing.equalToSuperview().inset(8)
        }
        
        dateLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(4)
            make.leading.equalTo(imageView.snp.trailing).offset(8)
            make.trailing.equalToSuperview().inset(8)
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(dateLabel.snp.bottom).offset(4)
            make.leading.equalTo(imageView.snp.trailing).offset(8)
            make.trailing.bottom.equalToSuperview().inset(8)
        }
    }
}
