import SwiftUI

struct OrderCancel: View {
    
    let reasons = [
        "Не подходит дата получения",
        "Часть товаров из заказа была отменена",
        "Не получилось применить скидку или промокод",
        "Хочу изменить заказ и оформить заново",
        "Нашелся товар дешевле",
        "Другое"
    ]
    
    @State private var selectedIndex: Int? = nil
    @State private var otherReason: String = ""
    @State private var showRefundMessage = false
    @State private var showErrorMessage = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            
            if showErrorMessage {
                HStack {
                    Text("Пожалуйста, выберите причину")
                        .foregroundColor(.red)
                        .padding(.leading)
                    Spacer()
                }
                .frame(maxWidth: .infinity, minHeight: 50)
                .background(Color.red.opacity(0.1))
                .cornerRadius(10)
            }
            
            ForEach(reasons.indices, id: \.self) { index in
                HStack {
                    Image(systemName: selectedIndex == index ? "checkmark.square.fill" : "square")
                        .resizable()
                        .frame(width: 24, height: 24)
                        .foregroundColor(selectedIndex == index ? Color(uiColor: UIColor(red: 1, green: 0.275, blue: 0.067, alpha: 1)) : .gray)
                        .onTapGesture {
                            if selectedIndex == index {
                                selectedIndex = nil
                            } else {
                                selectedIndex = index
                            }
                        }
                    
                    Text(reasons[index])
                        .font(.subheadline)
                        .padding(.leading, 10)
                    
                    Spacer()
                }
                .padding(.horizontal)
            }
            
            if selectedIndex == reasons.firstIndex(of: "Другое") {
                HStack {
                    TextField("Опишите проблему", text: $otherReason)
                        .padding()
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(10)
                        .frame(maxWidth: .infinity, minHeight: 60)
                }
                .frame(maxWidth: .infinity)
            }
            
            if showRefundMessage {
                HStack {
                    Text("Обычно деньги сразу возвращаются на карту. В некоторых случаях это может занять до 3 рабочих дней.")
                        .padding(.horizontal, 15)
                        .padding(.vertical, 15)
                    Spacer()
                }
                .frame(maxWidth: .infinity, minHeight: 50)
                .background(Color.yellow.opacity(0.1))
                .cornerRadius(10)
            }
            
            HStack {
                Button(action: {
                    if selectedIndex != nil {
                        showRefundMessage.toggle()
                        showErrorMessage = false
                    } else {
                        showErrorMessage = true
                        showRefundMessage = false
                    }
                }) {
                    Text("Отменить заказ")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 15)
                        .background(Color(uiColor: UIColor(red: 1, green: 0.275, blue: 0.067, alpha: 1)))
                        .cornerRadius(8)
                }
            }
            .frame(maxWidth: .infinity)
            
            Spacer()
        }
        .padding()
        .navigationTitle("Укажите причину отмены")
        .navigationBarTitleDisplayMode(.inline)
    }
}
