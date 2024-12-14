import SwiftUI

struct TyForUnpaidOrder: View {
    
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        NavigationView {
            VStack {
                Spacer()
                
                Image("BagSuccess")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 72, height: 72)
                
                Text("Спасибо за заказ!")
                    .font(.title)
                    .fontWeight(.bold)
                    .padding()
                
                Text("Обратите внимание, что у неоплаченных заказов ограниченный срок хрнения")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                    .padding(.bottom, 20)
                    .multilineTextAlignment(.center)
                
                Button(action: {
                }) {
                    Text("Продолжить покупки")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 15)
                        .background(Color(uiColor: UIColor(red: 1, green: 0.275, blue: 0.067, alpha: 1)))
                        .cornerRadius(8)
                }
                .padding()
                
                Button(action: {
                }) {
                    Text("Статус заказа")
                        .font(.headline)
                        .foregroundColor(Color(uiColor: UIColor(red: 1, green: 0.275, blue: 0.067, alpha: 1)))
                }
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
