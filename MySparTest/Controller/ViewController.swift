//
//  ViewController.swift
//  MySparTest
//
//  Created by apple on 30.01.2024.
//

import UIKit
import AudioToolbox

// По идее, это все должно быть ячейкой, т.е классом UICollectionViewCell() , так как открываться она будет из коллекции продуктов, в которую уже будут передоваться данные. Передам сюда данные из viewDidLoad()

final class ViewController: UIViewController {
    
    private let modelData = ModelData.getData()
   

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .ourWhiteColor
        navigationItem.leftBarButtonItem = btnBack
        navigationItem.rightBarButtonItems = [addToFavotires , sharedBtn, btnList]
        view.addSubview(scrollView)
        view.addSubview(addToBasketView)
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            addToBasketView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -80),
            addToBasketView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            addToBasketView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
        
        settupView(data: modelData)
        
    }
    
    //MARK: Коллекция
    
    private lazy var collection: UICollectionView = {
        $0.register(ReviewsCell.self, forCellWithReuseIdentifier: ReviewsCell.reuseId)
        $0.register(HeaderForReview.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HeaderForReview.reuseId)
        $0.dataSource = self
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.heightAnchor.constraint(equalToConstant: 250).isActive = true
        return $0
    }(UICollectionView(frame: .zero, collectionViewLayout: layout))
    
    
    //Тут бы я сделал CompositionLayout и сделал бы свойство .groupPaging, но это затянуло бы мой код еще на час
    private lazy var layout: UICollectionViewFlowLayout = {
        $0.scrollDirection = .horizontal
        $0.headerReferenceSize = CGSize(width: view.frame.width, height: 20)
        $0.sectionHeadersPinToVisibleBounds = true
        $0.itemSize = CGSize(width: view.frame.width - 100, height: 200)
        $0.sectionInset = UIEdgeInsets(top: 20, left: -375, bottom: 0, right: 0)
        return $0
    }(UICollectionViewFlowLayout())
    
    //MARK: Все эллементы View
    private lazy var btnBack = ViewManager.getBarBtn(selector: #selector(actionForBarBtn(sender: )), image: UIImage(systemName: "arrow.backward"), target: self)
    //Я так и не понял, что это за значек листа газеты, и за что он может отвечать
    private lazy var btnList = ViewManager.getBarBtn(selector: #selector(actionForBarBtn(sender: )), image: UIImage(systemName: "newspaper"), target: self)
    private lazy var sharedBtn = ViewManager.getBarBtn(selector: #selector(actionForBarBtn(sender: )), image: UIImage(systemName: "square.and.arrow.up"), target: self)
    private lazy var addToFavotires = ViewManager.getBarBtn(selector: #selector(actionForBarBtn(sender: )), image: UIImage(systemName: "heart"), target: self)

    private lazy var productImage: UIImageView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.contentMode = .center
        $0.heightAnchor.constraint(equalToConstant: 380).isActive = true
        $0.clipsToBounds = true
        return $0
    }(UIImageView())
    
    private lazy var scrollView: UIScrollView = {
        $0.addSubview(contentView)
        $0.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: $0.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: $0.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: $0.trailingAnchor),
            contentView.widthAnchor.constraint(equalTo: $0.widthAnchor),
            contentView.bottomAnchor.constraint(equalTo: $0.bottomAnchor, constant: -10)
        ])
        return $0
    }(UIScrollView())
    
    private lazy var contentView: UIView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = .ourWhiteColor
        return $0
    }(UIView())
    
    private lazy var nameLabel = ViewManager.getLabel(font: .boldSystemFont(ofSize: 32),
                                                      textColor: .black,
                                                      numberOfLine: 0,
                                                      textAligment: .left)
    
    private lazy var countryLabel = ViewManager.getLabel(font: .systemFont(ofSize: 14, weight: .regular),
                                                         textColor: .black,
                                                         numberOfLine: 0,
                                                         textAligment: .left)
    
    private lazy var descriptionLabel = ViewManager.getLabel(font: .boldSystemFont(ofSize: 18),
                                                             textColor: .black,
                                                             numberOfLine: 0, 
                                                             textAligment: .left)
    
    private lazy var descriptionTextLabel = ViewManager.getLabel(font: .systemFont(ofSize: 14, weight: .regular),
                                                                 textColor: .black,
                                                                 numberOfLine: 0,
                                                                 textAligment: .center)
    
    private lazy var mainCharactersLabel = ViewManager.getLabel(font: .boldSystemFont(ofSize: 18),
                                                                textColor: .black,
                                                                numberOfLine: 0,
                                                                textAligment: .left)
    
    
    private lazy var productedLabel = ViewManager.getMainCharactericticsLabel(firstLabelName: "Производство", secondLabelName: modelData.productСharacteristics.madeIn ?? "Нет данных")
    
    private lazy var energyValueLabel = ViewManager.getMainCharactericticsLabel(firstLabelName: "Энергетическая ценность", secondLabelName: modelData.productСharacteristics.energyValue ?? "Нет данных")
    
    private lazy var fatsLabel: UIView = {
        var view = UIView()
        if let fatsFloat = modelData.productСharacteristics.fats {
           view = ViewManager.getMainCharactericticsLabel(firstLabelName: "Жиры/100г", secondLabelName: String(fatsFloat) + "г")
        }
        return view
    }()
    
    private lazy var proteinLabel: UIView = {
       var view = UIView()
        if let proteinsFloat = modelData.productСharacteristics.proteins {
            view = ViewManager.getMainCharactericticsLabel(firstLabelName: "Белки/100г", secondLabelName: String(proteinsFloat) + "г")
        }
        return view
    }()
    
    private lazy var carbsLabel: UIView = {
        var view = UIView()
        if let carbsFloat = modelData.productСharacteristics.carb {
            view = ViewManager.getMainCharactericticsLabel(firstLabelName: "Углеводы/100г", secondLabelName: String(carbsFloat) + "г")
        }
        return view
    }()
    
    private lazy var btnCreateReview: UIButton = {
        $0.layer.cornerRadius = 20
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.heightAnchor.constraint(equalToConstant: 60).isActive = true
        $0.backgroundColor = .ourWhiteColor
        $0.layer.borderColor = UIColor.ourGreenColor.cgColor
        $0.layer.borderWidth = 2
        $0.setTitle("Оставить отзыв", for: .normal)
        $0.setTitleColor(.ourGreenColor, for: .normal)
        return $0
    }(UIButton(primaryAction: actionForBtn))
    
    
    //В экшен бы добавил анимацию, и чтобы раскрывались новые поля, а кнопка сама менялась на "скрыть"
    private lazy var btnAllCharacters: UIButton = {
        $0.setTitle("Все характеристики", for: .normal)
        $0.setTitleColor(.ourGreenColor, for: .normal)
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIButton(primaryAction: actionForBtn))
    
    private lazy var priceLabel: UILabel = {
        $0.textColor = .black
        $0.font = .boldSystemFont(ofSize: 16)
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UILabel())
    
    private lazy var segment: UISegmentedControl = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.insertSegment(withTitle: "Шт", at: 0, animated: true)
        $0.insertSegment(withTitle: "Кг", at: 1, animated: true)
        $0.selectedSegmentIndex = 1
        $0.heightAnchor.constraint(equalToConstant: 30).isActive = true
        $0.addTarget(self, action: #selector(actionForChangeSegment(sender: )), for: .valueChanged)
        return $0
    }(UISegmentedControl())
    
    private lazy var btnMinusPlus = ViewManager.getPlusMinusBtn(actionForPlus: actionForPlusBtn, actionForMinusBtn: actionForMinusBtn)
    
    private lazy var countLabel = ViewManager.getLabel(font: .boldSystemFont(ofSize: 16),
                                                       textColor: .white,
                                                       numberOfLine: 1,
                                                       textAligment: .center)
    
    private lazy var finalyPrice = ViewManager.getLabel(font: .boldSystemFont(ofSize: 16),
                                                        textColor: .white,
                                                        numberOfLine: 1,
                                                        textAligment: .center)
    
    
    private lazy var actionForPlusBtn = UIAction { _ in
        if self.segment.selectedSegmentIndex == 1 {
            var count = 0
            if let value = Int(self.countLabel.text ?? "0") {
                count = value + 1
                self.countLabel.text = String(count)
                let price = Int(self.modelData.price)
                self.finalyPrice.text = String(count * price) + "р"
            }
        } else {
            if let value = Int(self.countLabel.text ?? "0") {
                self.countLabel.text = String(value + 1)
                let plusOne = value + 1
                let price = 11.18 * Double(plusOne)
                self.finalyPrice.text = String(price) + "р"
            }
        }
        
    }
    
    private lazy var actionForMinusBtn = UIAction { _ in
        if self.segment.selectedSegmentIndex == 1 {
            var count = 0
            if let value = Int(self.countLabel.text ?? "0") {
                count = value - 1
                self.countLabel.text = String(count)
                let price = Int(self.modelData.price)
                self.finalyPrice.text = String(count * price) + "р"
            }
        } else {
            if let value = Int(self.countLabel.text ?? "0") {
                self.countLabel.text = String(value - 1)
                let minusOne = value - 1
                let price = 11.18 * Double(minusOne)
                self.finalyPrice.text = String(price) + "р"
            }
        }
        
    }
    
    private lazy var addToBasketView: UIView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.heightAnchor.constraint(equalToConstant: 100).isActive = true
        $0.backgroundColor = .ourWhiteColor
        $0.addSubview(segment)
        let price = String(modelData.price)
        priceLabel.text = price + " Р/кг"
        $0.addSubview(priceLabel)
        
        $0.addSubview(btnMinusPlus)
        
        btnMinusPlus.addSubview(countLabel)
        btnMinusPlus.addSubview(finalyPrice)
        
        countLabel.text = "1"
        finalyPrice.text = "55р"
        
        NSLayoutConstraint.activate([
            segment.leadingAnchor.constraint(equalTo: $0.leadingAnchor, constant: 20),
            segment.trailingAnchor.constraint(equalTo: $0.trailingAnchor, constant: -20),
            segment.topAnchor.constraint(equalTo: $0.topAnchor),
            
            priceLabel.leadingAnchor.constraint(equalTo: $0.leadingAnchor, constant: 20),
            priceLabel.topAnchor.constraint(equalTo: segment.bottomAnchor, constant: 30),
            
            btnMinusPlus.topAnchor.constraint(equalTo: segment.bottomAnchor, constant: 10),
            btnMinusPlus.trailingAnchor.constraint(equalTo: $0.trailingAnchor, constant: -20),
            btnMinusPlus.heightAnchor.constraint(equalToConstant: 50),
            btnMinusPlus.widthAnchor.constraint(equalToConstant: 150),
            
            countLabel.topAnchor.constraint(equalTo: btnMinusPlus.topAnchor, constant: 5),
            countLabel.centerXAnchor.constraint(equalTo: btnMinusPlus.centerXAnchor),
            
            finalyPrice.centerXAnchor.constraint(equalTo: btnMinusPlus.centerXAnchor),
            finalyPrice.bottomAnchor.constraint(equalTo: btnMinusPlus.bottomAnchor, constant: -5),
            
        ])
       return $0
    }(UIView())
    
    //MARK: Функции
    //Приблизительно вот такая функция будет выполняться, т.е мы получим объект из базы данных и будем его разворачивать
    private func settupView(data: ModelData) {
        productImage.image = UIImage(named: data.image)
        nameLabel.text = data.name
        countryLabel.text = data.country
        descriptionLabel.text = "Описание"
        descriptionTextLabel.text = data.description
        mainCharactersLabel.text = "Основные характеристики"
        
        
        contentView.addSubview(productImage)
        contentView.addSubview(nameLabel)
        contentView.addSubview(countryLabel)
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(descriptionTextLabel)
        contentView.addSubview(mainCharactersLabel)
        contentView.addSubview(productedLabel)
        contentView.addSubview(energyValueLabel)
        contentView.addSubview(fatsLabel)
        contentView.addSubview(proteinLabel)
        contentView.addSubview(carbsLabel)
        contentView.addSubview(btnAllCharacters)
        contentView.addSubview(collection)
        contentView.addSubview(btnCreateReview)
        

        NSLayoutConstraint.activate([
            productImage.topAnchor.constraint(equalTo: contentView.topAnchor),
            productImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 50),
            productImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -50),
            
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            nameLabel.topAnchor.constraint(equalTo: productImage.bottomAnchor, constant: 40),
            
            countryLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            countryLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            countryLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 30),
            
            descriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            descriptionLabel.topAnchor.constraint(equalTo: countryLabel.bottomAnchor, constant: 20),
            
            descriptionTextLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            descriptionTextLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            descriptionTextLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 10),
            
            mainCharactersLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            mainCharactersLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            mainCharactersLabel.topAnchor.constraint(equalTo: descriptionTextLabel.bottomAnchor, constant: 20),
           
            productedLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            productedLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            productedLabel.topAnchor.constraint(equalTo: mainCharactersLabel.bottomAnchor, constant: 10),
            
            energyValueLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            energyValueLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            energyValueLabel.topAnchor.constraint(equalTo: productedLabel.bottomAnchor, constant: 20),
            
            fatsLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            fatsLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            fatsLabel.topAnchor.constraint(equalTo: energyValueLabel.bottomAnchor, constant: 20),
            
            proteinLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            proteinLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            proteinLabel.topAnchor.constraint(equalTo: fatsLabel.bottomAnchor, constant: 20),
            
            carbsLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            carbsLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            carbsLabel.topAnchor.constraint(equalTo: proteinLabel.bottomAnchor, constant: 20),
            
            btnAllCharacters.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            btnAllCharacters.topAnchor.constraint(equalTo: carbsLabel.bottomAnchor, constant: 30),
            
            collection.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            collection.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            collection.topAnchor.constraint(equalTo: btnAllCharacters.bottomAnchor, constant: 30),
            
            btnCreateReview.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            btnCreateReview.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            btnCreateReview.topAnchor.constraint(equalTo: collection.bottomAnchor, constant: 20),
            btnCreateReview.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -100)
            
            
            
        ])
    }
    
    
    // MARK: Обработка нажатии
    @objc
    func actionForBarBtn(sender: UIBarButtonItem) {
        view.layer.add(ViewManager.getShakingAnimate(shakesView: view), forKey: "position")
        AudioServicesPlaySystemSound(SystemSoundID(1165))
    }
    
    private lazy var actionForBtn = UIAction { [weak self] _ in
        guard let self = self else { return }
        self.view.layer.add(ViewManager.getShakingAnimate(shakesView: self.view), forKey: "position")
        AudioServicesPlaySystemSound(SystemSoundID(1165))
    }
    
    @objc
    func actionForChangeSegment(sender: UISegmentedControl){
        switch sender.selectedSegmentIndex {
        case 0:
            let onePrice = modelData.price * 0.2
            priceLabel.text = String(onePrice) + " Р/шт"
            countLabel.text = "1"
            finalyPrice.text = "11.18р"
        default:
            let price = String(modelData.price)
            priceLabel.text = price + " Р/кг"
            countLabel.text = "1"
            finalyPrice.text = "55р"
        }
    }
    
}


extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        modelData.currentProductReviwes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collection.dequeueReusableCell(withReuseIdentifier: ReviewsCell.reuseId, for: indexPath) as? ReviewsCell else { return UICollectionViewCell() }
        cell.configCell(review: modelData.currentProductReviwes[indexPath.item])
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let header = collection.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: HeaderForReview.reuseId, for: indexPath) as? HeaderForReview else { return UICollectionReusableView() }
        header.delegate = self
        return header
    }
}


protocol ViewControllerDelegate {
    func touchSeeAllBtn()
}

extension ViewController: ViewControllerDelegate {
    func touchSeeAllBtn() {
        view.layer.add(ViewManager.getShakingAnimate(shakesView: view), forKey: "position")
        AudioServicesPlaySystemSound(SystemSoundID(1165))
    }
}
