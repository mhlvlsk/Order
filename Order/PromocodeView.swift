import SwiftUI

struct PromocodeView: View {
    let promocode: Order.Promocode
    @Binding var isActive: Set<String>

    var body: some View {
        HStack {
            Circle()
                .fill(Color.white)
                .frame(width: 16, height: 16)
                .offset(x: -8)
            Circle()
                .fill(Color.white)
                .frame(width: 16, height: 16)
                .offset(x: 328)

            VStack(alignment: .leading, spacing: 5) {
                HStack {
                    Text(promocode.title)
                        .font(.headline)

                    ZStack {
                        RoundedRectangle(cornerRadius: 12)
                            .fill(Color(uiColor: UIColor(red: 0, green: 0.718, blue: 0.459, alpha: 1)))
                            .frame(width: 50, height: 24)
                        
                        Text("-\(promocode.percent)%")
                            .foregroundColor(.white)
                            .font(.subheadline)
                    }
                    
                    Button(action: {
                    }) {
                        Image(systemName: "info.circle")
                            .foregroundColor(.gray)
                    }
                    
                    Spacer()
                }
                
                Text(promocode.endDate != nil
                     ? "По \(formatDate(promocode.endDate!))"
                     : "Дата истечения не указана")
                    .font(.subheadline)
                    .foregroundColor(.gray)

                Text(promocode.info ?? "")
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            .padding(.horizontal, -30)
            .padding(.vertical, 10)
            Spacer()
            
            Toggle("", isOn: Binding(
                get: { isActive.contains(promocode.title) },
                set: { newValue in
                    if newValue {
                        if isActive.count == 2 {
                            if let firstActivePromocode = isActive.first {
                                isActive.remove(firstActivePromocode)
                            }
                        }
                        isActive.insert(promocode.title)
                    } else {
                        isActive.remove(promocode.title)
                    }
                }
            ))
                .labelsHidden()
                .tint(Color(uiColor: UIColor(red: 1, green: 0.275, blue: 0.067, alpha: 1)))
                .padding(.trailing, 25)
        }
        .background(Color(white: 0.95))
        .cornerRadius(12)
    }
    
    func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ru_RU")
        formatter.dateFormat = "d MMMM"
        return formatter.string(from: date)
    }
}
