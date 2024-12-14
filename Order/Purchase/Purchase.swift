import SwiftUI

struct Purchase: View {
    
    @State private var selectedPaymentIndex: Int? = nil
    @State private var activePromocodes: Set<String> = []
    @State private var isPaymentPresented = false
    
    let screens: [AnyView] = [
        AnyView(PaymentFailed()),
        AnyView(SomethingWentWrong()),
        AnyView(TyForOrder()),
        AnyView(TyForUnpaidOrder())
    ]
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                Text("Состав заказа")
                    .font(.title2)
                    .bold()
                
                Text("Вы можете изменить параметры и состав заказа в ")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                + Text("корзине")
                    .font(.subheadline)
                    .foregroundColor(Color(uiColor: UIColor(red: 1, green: 0.275, blue: 0.067, alpha: 1)))
                
                ForEach(order2.products, id: \.title) { product in
                    HStack {
                        AsyncImage(url: URL(string: product.imageURL)) { image in
                            image.resizable()
                                .scaledToFit()
                                .frame(width: 80, height: 80)
                        } placeholder: {
                            Color.gray.frame(width: 80, height: 80)
                        }
                        
                        VStack(alignment: .leading) {
                            Text(product.title)
                                .font(.subheadline)
                            if let size = product.size {
                                Text("\(Int(product.quantity)) шт. • Размер: \(size)")
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                            }
                            HStack {
                                Text("\(formattedNumber((product.price * product.quantity))) ₽")
                                    .font(.subheadline)
                                    .strikethrough()
                                    .fontWeight(.light)
                                
                                ZStack {
                                    RoundedRectangle(cornerRadius: 8)
                                        .fill(Color(uiColor: UIColor(red: 1, green: 0.275, blue: 0.067, alpha: 0.1)))
                                        .frame(width: 33, height: 18)
                                    
                                    Text("-\(product.discount)%")
                                        .foregroundColor(Color(uiColor: UIColor(red: 1, green: 0.275, blue: 0.067, alpha: 1)))
                                        .font(.caption2)
                                        .bold()
                                }
                            }
                            
                            Text("\(formattedNumber((Double(product.price) * Double(product.quantity)) * (1 - Double(product.discount) / 100))) ₽")
                                .font(.subheadline)
                                .bold()
                        }
                        Spacer()
                    }
                }
                
                Text("Способ оплаты")
                    .font(.title2)
                    .bold()
                
                ForEach(order2.paymentMethods.indices, id: \.self) { index in
                    let method = order2.paymentMethods[index]
                    HStack {
                        method.iconImage
                            .resizable()
                            .scaledToFit()
                            .frame(width: 24, height: 24)
                        VStack(alignment: .leading) {
                            HStack {
                                Text(method.name)
                                    .font(.subheadline)
                                ZStack {
                                    if (method.paymentDiscount > 0){
                                        RoundedRectangle(cornerRadius: 12)
                                            .fill(Color(.black))
                                            .frame(width: 35, height: 20)
                                        
                                        Text("-\(method.paymentDiscount)%")
                                            .foregroundColor(.white)
                                            .font(.footnote)
                                    }
                                }
                            }
                            Text(method.description)
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                        Spacer()
                        ZStack {
                            Image(systemName: "circle")
                                .resizable()
                                .frame(width: 18, height: 18)
                                .foregroundColor(.gray)
                            if selectedPaymentIndex == index {
                                Image(systemName: "circle")
                                    .resizable()
                                    .frame(width: 18, height: 18)
                                    .foregroundColor(Color(uiColor: UIColor(red: 1, green: 0.275, blue: 0.067, alpha: 1)))
                                Image(systemName: "circle.fill")
                                    .resizable()
                                    .frame(width: 8, height: 8)
                                    .foregroundColor(Color(uiColor: UIColor(red: 1, green: 0.275, blue: 0.067, alpha: 1)))
                            }
                        }
                        .onTapGesture {
                            selectedPaymentIndex = selectedPaymentIndex == index ? nil : index
                        }
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(8)
                }
                
                Text("Промокоды")
                    .font(.title2)
                    .bold()
                
                Text("На один товар можно применить только один промокод")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                
                Button (action: {
                }) {
                    Text("Применить промокод")
                        .font(.headline)
                        .foregroundColor(Color(uiColor: UIColor(red: 1, green: 0.275, blue: 0.067, alpha: 1)))
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 15)
                        .background(Color(uiColor: UIColor(red: 1, green: 0.275, blue: 0.067, alpha: 0.1)))
                        .cornerRadius(8)
                }
                
                ForEach(promocodes, id: \.title) { promocode in
                    PromocodeView(promocode: promocode, isActive: $activePromocodes)
                }
                
                Button (action: {
                }) {
                    Text("Скрыть промокоды")
                        .font(.subheadline)
                        .foregroundColor(Color(uiColor: UIColor(red: 1, green: 0.275, blue: 0.067, alpha: 1)))
                }
            }
            .padding()
            
            VStack(spacing: 10) {
                
                HStack {
                    Text("Цена за \(OrderCalculations.totalProductCount(for: order2.products)) \(OrderCalculations.productCountText(for: OrderCalculations.totalProductCount(for: order2.products)))")
                        .font(.subheadline)
                    Spacer()
                    Text("\(formattedNumber(OrderCalculations.totalPrice(for: order2.products))) ₽")
                        .font(.subheadline)
                }
                
                HStack {
                    Text("Скидки")
                        .font(.subheadline)
                    Spacer()
                    Text("-\(formattedNumber(OrderCalculations.totalProductDiscount(for: order2.products))) ₽")
                        .font(.subheadline)
                        .foregroundColor(Color(uiColor: UIColor(red: 1, green: 0.275, blue: 0.067, alpha: 1)))
                }
                
                if !activePromocodes.isEmpty {
                    HStack {
                        Text("Промокоды")
                            .font(.subheadline)
                        Button(action: {
                        }) {
                            Image(systemName: "info.circle")
                                .foregroundColor(.gray)
                        }
                        Spacer()
                        Text("-\(formattedNumber(OrderCalculations.promocodeDiscount(for: order2.products, activePromocodes: activePromocodes, promocodes: promocodes))) ₽")
                            .font(.subheadline)
                            .foregroundColor(Color(uiColor: UIColor(red: 0, green: 0.718, blue: 0.459, alpha: 1)))
                    }
                }
                
                if selectedPaymentIndex != nil {
                    HStack {
                        Text("Способ оплаты")
                            .font(.subheadline)
                        Spacer()
                        Text("-\(formattedNumber(OrderCalculations.paymentMethodDiscount(for: order2.products, selectedPaymentIndex: selectedPaymentIndex, paymentMethods: order2.paymentMethods))) ₽")
                            .font(.subheadline)
                    }
                }
                
                Divider()
                    .frame(height: 0.1)
                    .background(Color.gray)
                
                HStack {
                    Text("Итого:")
                        .font(.title2)
                        .bold()
                    Spacer()
                    Text("\(formattedNumber(OrderCalculations.totalAmount(for: order2.products, activePromocodes: activePromocodes, promocodes: promocodes, selectedPaymentIndex: selectedPaymentIndex, paymentMethods: order2.paymentMethods))) ₽")
                        .font(.title2)
                        .bold()
                }
                
                Button {
                    isPaymentPresented.toggle()
                } label: {
                    Text("Оплатить")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 15)
                        .background(Color(uiColor: UIColor(red: 1, green: 0.275, blue: 0.067, alpha: 1)))
                        .cornerRadius(8)
                }
                .sheet(isPresented: $isPaymentPresented) {
                    screens.randomElement()
                }
                
                VStack {
                    Text("Нажимая на кнопку «Оформить заказ»,\nВы соглашаетесь с ")
                        .font(.caption2)
                        .foregroundColor(.gray)
                    + Text("Условиями оферты")
                        .font(.caption2)
                        .foregroundColor(.black)
                }
                .multilineTextAlignment(.center)
            }
            .padding(30)
            .background(Color(white: 0.95))
            .frame(maxWidth: .infinity)
        }
        .navigationTitle(order2.screenTitle)
        .navigationBarTitleDisplayMode(.inline)
    }
}
