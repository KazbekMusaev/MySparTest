//
//  ReviewsCell.swift
//  MySparTest
//
//  Created by apple on 31.01.2024.
//

import UIKit

final class ReviewsCell: UICollectionViewCell {
    static let reuseId = "ReviewsCell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layer.cornerRadius = 20
        backgroundColor = #colorLiteral(red: 0.9394722581, green: 0.9097610116, blue: 0.9323667288, alpha: 1)
        settupCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func settupCell(){
        addSubview(nameUser)
        addSubview(dateReview)
        addSubview(textRevies)
        
        NSLayoutConstraint.activate([
            nameUser.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            nameUser.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            
            dateReview.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            dateReview.topAnchor.constraint(equalTo: nameUser.bottomAnchor, constant: 8),
            
            textRevies.leadingAnchor.constraint(equalTo: leadingAnchor,constant: 10),
            textRevies.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            textRevies.topAnchor.constraint(equalTo: dateReview.bottomAnchor, constant: 20),
        ])
    }
    
    private lazy var nameUser: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.textColor = .black
        $0.font = .boldSystemFont(ofSize: 16)
        return $0
    }(UILabel())
    
    private lazy var dateReview: UILabel = {
        $0.textColor = .lightGray
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.font = .systemFont(ofSize: 14)
        return $0
    }(UILabel())
    
    private lazy var textRevies: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.numberOfLines = 0
        $0.font = .systemFont(ofSize: 12)
        $0.textColor = .black
        return $0
    }(UILabel())
    
    func configCell(review: Reviews) {
        dateReview.text = review.date.formatted(date: .numeric, time: .standard)
        nameUser.text = review.nameUser
        textRevies.text = review.textForReview
    }
}
