import SwiftUI

struct SomethingWentWrong: View {
    
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        NavigationView {
            VStack {
                Spacer()
                
                Image("PaymentError")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 72, height: 72)
                
                Text("Что-то пошло не так...")
                    .font(.title)
                    .fontWeight(.bold)
                    .padding()
                
                Text("К сожалению, ваш заказ не был создан")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                    .padding(.bottom, 20)
                    .multilineTextAlignment(.center)
                
                Button(action: {
                }) {
                    Text("На главную")
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
