import Foundation

struct OrderCalculations {
    
    static func totalPrice(for products: [Order.Product]) -> Double {
        return products.reduce(0) { $0 + $1.price * $1.quantity }
    }
    
    static func totalProductCount(for products: [Order.Product]) -> Int {
        return Int(products.reduce(0) { $0 + $1.quantity })
    }
    
    static func totalProductDiscount(for products: [Order.Product]) -> Double {
        return products.reduce(0) { $0 + ($1.price * Double($1.discount) / 100) * $1.quantity }
    }
    
    static func promocodeDiscount(for products: [Order.Product], activePromocodes: Set<String>, promocodes: [Order.Promocode]) -> Double {
        return products.reduce(0) { total, product in
            let applicableDiscount = activePromocodes.reduce(0) { (currentDiscount, promocode) in
                if let promo = promocodes.first(where: { $0.title == promocode }) {
                    return currentDiscount + (product.price * Double(promo.percent) / 100) * product.quantity
                }
                return currentDiscount
            }
            return total + applicableDiscount
        }
    }
    
    static func paymentMethodDiscount(for products: [Order.Product], selectedPaymentIndex: Int?, paymentMethods: [Order.PaymentMethod]) -> Double {
        guard let selectedIndex = selectedPaymentIndex else { return 0 }
        let selectedMethod = paymentMethods[selectedIndex]
        return products.reduce(0) { total, product in
            total + (product.price * Double(selectedMethod.paymentDiscount) / 100) * product.quantity
        }
    }
    
    static func totalAmount(for products: [Order.Product], activePromocodes: Set<String>, promocodes: [Order.Promocode], selectedPaymentIndex: Int?, paymentMethods: [Order.PaymentMethod]) -> Double {
        let totalPrice = self.totalPrice(for: products)
        let totalProductDiscount = self.totalProductDiscount(for: products)
        let promocodeDiscount = self.promocodeDiscount(for: products, activePromocodes: activePromocodes, promocodes: promocodes)
        let paymentMethodDiscount = self.paymentMethodDiscount(for: products, selectedPaymentIndex: selectedPaymentIndex, paymentMethods: paymentMethods)
        
        return totalPrice - totalProductDiscount - promocodeDiscount - paymentMethodDiscount
    }
    
    static func productCountText(for count: Int) -> String {
        let lastDigit = count % 10
        let lastTwoDigits = count % 100
        
        if lastDigit == 1 && lastTwoDigits != 11 {
            return "товар"
        } else if (lastDigit >= 2 && lastDigit <= 4) && !(lastTwoDigits >= 12 && lastTwoDigits <= 14) {
            return "товара"
        } else {
            return "товаров"
        }
    }
}
