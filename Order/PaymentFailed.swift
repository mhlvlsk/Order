import SwiftUI

struct PaymentFailed: View {
    
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        NavigationView {
            VStack {
                Spacer()
                
                Image("PaymentError")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 72, height: 72)
                
                Text("Оплата не прошла")
                    .font(.title)
                    .fontWeight(.bold)
                    .padding()
                
                Text("Возможно, были введены неверные данные или произошла ошибка на стороне платежной системы")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                    .padding(.bottom, 20)
                    .multilineTextAlignment(.center)
                
                Button(action: {
                }) {
                    Text("Попробовать еще раз")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color(uiColor: UIColor(red: 1, green: 0.275, blue: 0.067, alpha: 1)))
                        .cornerRadius(8)
                }
                .padding()
                
                Spacer()
            }
            .padding()
            .background(Color.white)
            .cornerRadius(10)
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(leading: Button(action: {
                presentationMode.wrappedValue.dismiss()
            }) {
                Image(systemName: "xmark")
                    .foregroundColor(.black)
                    .imageScale(.large)
            })
        }
    }
}
