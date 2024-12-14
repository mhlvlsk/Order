import Foundation
import SwiftUI

struct Order {
    struct Promocode {
        let title: String
        let percent: Int
        let endDate: Date?
        let info: String?
        var active: Bool
    }
    
    struct Product {
        let imageURL: String
        let title: String
        let quantity: Double
        let size: Int?
        let price: Double
        let discount: Int
    }
    
    struct PaymentMethod {
        let name: String
        let description: String
        let iconImage: Image
        let paymentDiscount: Int
    }

    var screenTitle: String
    var promocodes: [Promocode]
    var availableForActive: [Promocode]
    let products: [Product]
    let pDiscount: Double?
    let baseDiscount: Double?
    let paymentMethods: [PaymentMethod]
}
