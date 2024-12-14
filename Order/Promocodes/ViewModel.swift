import Foundation
import SwiftUI

class ViewModel {
    func changePurchases(count: Int) -> String {
        let remainder10 = count % 10
        let remainder100 = count % 100
        
        if remainder100 >= 11 && remainder100 <= 19 {
            return "товаров"
        }
        
        switch remainder10 {
        case 1:
            return "товар"
        case 2, 3, 4:
            return "товара"
        default:
            return "товаров"
        }
    }
    
    func createExampleOrder() -> Order {
        
        let product1 = Order.Product(imageURL: "",
                                     title: "Товар 1",
                                     quantity: 1,
                                     size: 17,
                                     price: 1500,
                                     discount: 10)
        
        let product2 = Order.Product(imageURL: "",
                                     title: "Товар 2",
                                     quantity: 2,
                                     size: nil,
                                     price: 2500,
                                     discount: 15)
        
        let product3 = Order.Product(imageURL: "",
                                     title: "Товар 3",
                                     quantity: 3,
                                     size: 17,
                                     price: 100,
                                     discount: 5)
        
        let product4 = Order.Product(imageURL: "",
                                     title: "Товар 4",
                                     quantity: 1,
                                     size: 17,
                                     price: 300,
                                     discount: 7)
        
        let product5 = Order.Product(imageURL: "",
                                     title: "Товар 5",
                                     quantity: 1,
                                     size: nil,
                                     price: 500,
                                     discount: 20)

        var components = DateComponents()
        components.year = 2024
        components.month = 12
        components.day = 31

        let calendar = Calendar.current
        guard let endDate = calendar.date(from: components) else {
            fatalError("Не удалось создать дату")
        }

        let promocode1 = Order.Promocode(title: "HELLO", percent: 10, endDate: endDate, info: "На все товары", active: false)
        let promocode2 = Order.Promocode(title: "DRANDULET", percent: 15, endDate: endDate, info: "На автотовары", active: false)
        let promocode3 = Order.Promocode(title: "ARBUZ", percent: 35, endDate: endDate, info: "На арбузы", active: false)
        let promocode4 = Order.Promocode(title: "PROMO", percent: 20, endDate: endDate, info: "Тестовый", active: true)
        let promocode5 = Order.Promocode(title: "FRIDAY", percent: 11, endDate: endDate, info: "Тестовый", active: true)

        let paymentMethod1 = Order.PaymentMethod(name: "Карта", description: "Visa, MC", iconImage: Image ("card"), paymentDiscount: 5)

        return Order(
            screenTitle: "Оформление заказа",
            promocodes: [promocode1, promocode2, promocode3],
            availableForActive: [promocode4, promocode5],
            products: [product1, product2, product3, product4, product5],
            pDiscount: 100,
            baseDiscount: 200,
            paymentMethods: [paymentMethod1]
        )
    }
    
    func formatDate(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ru_RU")
        dateFormatter.dateFormat = "d MMMM"
        
        return dateFormatter.string(from: date)
    }
    
    func formatCurrency(_ amount: Double) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 2
        formatter.minimumFractionDigits = 0
        formatter.groupingSeparator = " "
        formatter.groupingSize = 3
        return formatter.string(from: NSNumber(value: amount)) ?? "\(amount)"
    }
}

