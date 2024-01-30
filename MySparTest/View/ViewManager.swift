//
//  ViewManager.swift
//  MySparTest
//
//  Created by apple on 30.01.2024.
//

import UIKit

final class ViewManager {
    
    private init() {}
    
    // Пишу собственный магазин, данная анимации тряски экрана служит при проверке входа, либо регистрации, если не заполнены все поля, трясется экран и всплывает окно с ошибкой. Так как основная часть кнопок не будет имет навигации и перехода, решил использовать это здесь 🤫
    
    static func getShakingAnimate(shakesView: UIView) -> CABasicAnimation {
        let animate = CABasicAnimation(keyPath: "position")
        animate.duration = 0.07
        animate.repeatCount = 4
        animate.autoreverses = true
        
        let fromPoint = CGPoint(x: shakesView.center.x - 5, y: shakesView.center.y)
        let toPoint = CGPoint(x: shakesView.center.x + 5, y: shakesView.center.y)
        
        animate.fromValue = fromPoint
        animate.toValue = toPoint
        
        shakesView.layer.add(animate, forKey: "position")
        return animate
    }
    
    static func getBarBtn(selector: Selector, image: UIImage?, target: AnyObject) -> UIBarButtonItem {
        let btn = UIBarButtonItem()
        btn.tintColor = .ourGreenColor
        btn.target = target
        btn.action = selector
        btn.image = image
        return btn
    }
    
    static func getLabel(font: UIFont, textColor: UIColor, numberOfLine: Int, textAligment: NSTextAlignment) -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = font
        label.textColor = textColor
        label.numberOfLines = numberOfLine
        label.textAlignment = textAligment
        return label
    }
    
    static func getMainCharactericticsLabel(firstLabelName: String, secondLabelName: String) -> UIView {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        let labelOne = UILabel()
        labelOne.text = firstLabelName
        labelOne.font = .systemFont(ofSize: 12, weight: .regular)
        labelOne.numberOfLines = 0
        labelOne.textAlignment = .left
        labelOne.translatesAutoresizingMaskIntoConstraints = false
        
        let labelTwo = UILabel()
        labelTwo.text = secondLabelName
        labelTwo.font = .systemFont(ofSize: 12, weight: .regular)
        labelTwo.translatesAutoresizingMaskIntoConstraints = false
        labelTwo.numberOfLines = 0
        labelTwo.textAlignment = .right
        
       //Можно было сделать цикл, но уже час ночи, я уже часа 4 делаю это без остановки
        let dots = "..................................................................................."
        let dotLabel = UILabel()
        dotLabel.translatesAutoresizingMaskIntoConstraints = false
        dotLabel.text = dots
        dotLabel.font = .systemFont(ofSize: 12, weight: .regular)
        dotLabel.numberOfLines = 1
        dotLabel.textColor = .black
         
        
        view.addSubview(labelOne)
        view.addSubview(labelTwo)
        view.addSubview(dotLabel)
  
        NSLayoutConstraint.activate([
            labelOne.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            labelOne.topAnchor.constraint(equalTo: view.topAnchor),
            labelOne.trailingAnchor.constraint(equalTo: dotLabel.leadingAnchor, constant: -5),
            
            labelTwo.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            labelTwo.topAnchor.constraint(equalTo: view.topAnchor),
            labelTwo.leadingAnchor.constraint(equalTo: dotLabel.trailingAnchor, constant: 5),
            
        ])
        return view
    }
    
    static func getPlusMinusBtn(actionForPlus: UIAction, actionForMinusBtn: UIAction) -> UIView {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .ourGreenColor
        
        view.layer.cornerRadius = 24
        
        let btn = UIButton(primaryAction: actionForPlus)
        btn.setImage(UIImage(systemName: "plus"), for: .normal)
        btn.tintColor = .white
        btn.translatesAutoresizingMaskIntoConstraints = false
        
        let btnMinus = UIButton(primaryAction: actionForMinusBtn)
        btnMinus.setImage(UIImage(systemName: "minus"), for: .normal)
        btnMinus.tintColor = .white
        btnMinus.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(btn)
        view.addSubview(btnMinus)
        
        NSLayoutConstraint.activate([
            btn.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            btn.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            btnMinus.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            btnMinus.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
        
        
        return view
    }
    
    
}


