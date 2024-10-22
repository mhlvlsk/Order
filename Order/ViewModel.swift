import Foundation

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
        let product1 = Order.Product(price: 1500, title: "Товар 1")
        let product2 = Order.Product(price: 2500, title: "Товар 2")
        let product3 = Order.Product(price: 100, title: "Товар 3")
        let product4 = Order.Product(price: 300, title: "Товар 4")
        let product5 = Order.Product(price: 500, title: "Товар 5")

        var components = DateComponents()
            components.year = 2024
            components.month = 12
            components.day = 31

            let calendar = Calendar.current
            guard let endDate = calendar.date(from: components) else {
                fatalError("Не удалось создать дату")
            }
        
        let promocode1 = Order.Promocode(title: "HELLO", percent: 10, endDate: endDate, info: "На все товары", active: true)
        let promocode2 = Order.Promocode(title: "DRANDULET", percent: 15, endDate: endDate, info: "На автотовары", active: false)
        let promocode3 = Order.Promocode(title: "ARBUZ", percent: 35, endDate: endDate, info: "На арбузы", active: false)

        return Order(screenTitle: "Оформление заказа", promocodes: [promocode1, promocode2, promocode3], products: [product1, product2, product3, product4, product5], paymentDiscount: 100, baseDiscount: 200)
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

