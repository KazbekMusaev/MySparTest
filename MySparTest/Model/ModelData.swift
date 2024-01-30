//
//  ModelData.swift
//  MySparTest
//
//  Created by apple on 30.01.2024.
//

import Foundation

// По идее все эти данные будут приходить с базы данных

struct ModelData{
    let id = UUID().uuidString
    let name: String
    let image: String //Тут должна быть ссылка на фотку, и вытаскиваться будет она с Базы Дынных. Но в данный момент, я загружу ее с Assets
    let weight: Int
    let price: Float
    let country: String
    let description: String
    let productСharacteristics: Сharacteristics
    let reviewsCount: Int?
    let grade: Float?
    let discount: Int?
    let havePriceByCard: Bool
    let haveDiscount: Bool
    let currentProductReviwes: [Reviews]
    
    //При запросе в базу данных, т.е когда мы будем открывать в коллекции данный элемент, из нашей базы данных придут вот такие вот значения
    
    static func getData() -> ModelData {
        let reviews = [
            Reviews(nameUser: "Александр В.", date: Date(), grade: 4, textForReview: "Хорошая добавка, мне очень понравилась! Хочу, чтобы все добавки были такими!"),
            Reviews(nameUser: "Александр В.", date: Date(), grade: 4, textForReview: "Хорошая добавка, мне очень понравилась! Хочу, чтобы все добавки были такими!"),
            Reviews(nameUser: "Александр В.", date: Date(), grade: 4, textForReview: "Хорошая добавка, мне очень понравилась! Хочу, чтобы все добавки были такими!"),
            Reviews(nameUser: "Александр В.", date: Date(), grade: 4, textForReview: "Хорошая добавка, мне очень понравилась! Хочу, чтобы все добавки были такими!")
        ]
        let productCharacteristics = Сharacteristics(madeIn: "Россия, Краснодарский край", energyValue: "25 ккал, 105 кДж", fats: 0.1, proteins: 1.3, carb: 3.3)
        
        let productData = ModelData(name: "Добавка \"Липа\" к чаю 200г", image: "productImg", weight: 200, price: 55.9, country: "🇪🇸 Испания, Риоха", description: "Флановоиды липового цвета обладают противопосполительным действием, способствуют укреплению стенки сосудов", productСharacteristics: productCharacteristics, reviewsCount: reviews.count, grade: 4.1, discount: 5, havePriceByCard: true, haveDiscount: true, currentProductReviwes: reviews)
        
        return productData
    }
}

struct Сharacteristics {
    let madeIn: String?
    let energyValue: String?
    let fats: Float?
    let proteins: Float?
    let carb: Float?
}

struct Reviews {
    let id = UUID().uuidString
    let nameUser: String
    let date: Date
    let grade: Int
    let textForReview: String
}


