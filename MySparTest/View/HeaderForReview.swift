//
//  HeaderForReview.swift
//  MySparTest
//
//  Created by apple on 31.01.2024.
//

import UIKit


final class HeaderForReview: UICollectionReusableView {
    static let reuseId = "HeaderForReview"
    
    var delegate: ViewControllerDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(reviewLabel)
        addSubview(btnSeeAll)
        NSLayoutConstraint.activate([
            reviewLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            reviewLabel.topAnchor.constraint(equalTo: topAnchor),
            
            btnSeeAll.topAnchor.constraint(equalTo: topAnchor),
            btnSeeAll.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var reviewLabel: UILabel = {
        $0.text = "Отзывы"
        $0.font = .boldSystemFont(ofSize: 24)
        $0.textColor = .black
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UILabel())
    
    private lazy var btnSeeAll: UIButton = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.setTitle("Показать все", for: .normal)
        $0.setTitleColor(.ourGreenColor, for: .normal)
        return $0
    }(UIButton(primaryAction: action))
    
    private lazy var action = UIAction { _ in
        self.delegate?.touchSeeAllBtn()
    }
    
}
