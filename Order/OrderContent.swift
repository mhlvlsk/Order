import Foundation
import SwiftUI

let order2 = Order(
    screenTitle: "Оформление заказа",
    promocodes: [],
    availableForActive: [],
    products: [
        Order.Product(
            imageURL: "https://s3-alpha-sig.figma.com/img/0107/0af6/3297f40e81f4a6e2f72d2ce876867dac?Expires=1734912000&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=egIYaCrnirIMW0xs776XVqu7dM8uTUMJNW~~HdhAQrXa~2Cdiiveu~39PC3vmrFBNzJ003vXeGxrRVhNU2T-yqmJdQ-REQiw53NIhl-eYO7CKssTHJT7hrcUwTUL-Ji7Wv6Mriv6sH9cxEAXygurZoUUUoWNl~UmtW1Hsq7f~rvodRBbskjKXdUWx6ub9oUtyOo7CCPI6V2z~sVQfAcsD3T02EOSpumKSa~8XmvttdpaWgS07vdaR6JX6mWReXhX0xhhPbvQRRV9EQ3YDw57bNgGTSrggovoe3qmNuHh~YkObodoMw-iui1dlkxzl~QmRR9nIrIf8x0DrPPc5zc7CQ__",
            title: "Золотое плоское обручальное кольцо 4 мм",
            quantity: 1,
            size: 17,
            price: 12000,
            discount: 10
        ),
        Order.Product(
            imageURL: "https://s3-alpha-sig.figma.com/img/0107/0af6/3297f40e81f4a6e2f72d2ce876867dac?Expires=1734912000&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=egIYaCrnirIMW0xs776XVqu7dM8uTUMJNW~~HdhAQrXa~2Cdiiveu~39PC3vmrFBNzJ003vXeGxrRVhNU2T-yqmJdQ-REQiw53NIhl-eYO7CKssTHJT7hrcUwTUL-Ji7Wv6Mriv6sH9cxEAXygurZoUUUoWNl~UmtW1Hsq7f~rvodRBbskjKXdUWx6ub9oUtyOo7CCPI6V2z~sVQfAcsD3T02EOSpumKSa~8XmvttdpaWgS07vdaR6JX6mWReXhX0xhhPbvQRRV9EQ3YDw57bNgGTSrggovoe3qmNuHh~YkObodoMw-iui1dlkxzl~QmRR9nIrIf8x0DrPPc5zc7CQ__",
            title: "Золотое плоское обручальное кольцо 5 мм",
            quantity: 2,
            size: 17,
            price: 13000,
            discount: 20
        )
    ], 
    pDiscount: nil,
    baseDiscount: nil,
    paymentMethods: [
        Order.PaymentMethod(name: "SberPay", description: "Через приложение СберБанк" , iconImage: Image("sber"), paymentDiscount: 5),
        Order.PaymentMethod(name: "Банковской картой", description: "Visa, Master Card, МИР" , iconImage: Image("card"), paymentDiscount: 5),
        Order.PaymentMethod(name: "Яндекс Пэй со Сплитом", description: "Оплата частями" , iconImage: Image("yapay"), paymentDiscount: 5),
        Order.PaymentMethod(name: "Рассрочка Тинькофф", description: "На 3 месяца без переплат" , iconImage: Image("tink"), paymentDiscount: 5),
        Order.PaymentMethod(name: "Tinkoff Pay", description: "Через приложение Тинькофф" , iconImage: Image("tpay"), paymentDiscount: 5),
        Order.PaymentMethod(name: "Оплатить при получении", description: "Наличными или картой" , iconImage: Image("cash"), paymentDiscount: 0),
    ]
)

var promocodes: [Order.Promocode] = [
    Order.Promocode(title: "SECRETCODE", percent: 5, endDate: Date(), info: nil, active: true),
    Order.Promocode(title: "HELLO", percent: 5, endDate: Date(), info: "Промокод действует на первый заказ в приложении", active: false),
    Order.Promocode(title: "VESNA23", percent: 5, endDate: Date(), info: "Промокод действует для заказов от 30000 Р", active: false),
    Order.Promocode(title: "4300162112534", percent: 5, endDate: Date(), info: nil, active: false),
    Order.Promocode(title: "4300162312534", percent: 5, endDate: Date(), info: nil, active: false),
    Order.Promocode(title: "4300162116534", percent: 5, endDate: Date(), info: nil, active: false)
]

func formattedNumber(_ number: Double) -> String {
    let formatter = NumberFormatter()
    formatter.numberStyle = .decimal
    formatter.locale = Locale(identifier: "ru_RU")
    formatter.minimumFractionDigits = 0
    formatter.maximumFractionDigits = 0
    return formatter.string(from: NSNumber(value: number)) ?? "\(number)"
}
