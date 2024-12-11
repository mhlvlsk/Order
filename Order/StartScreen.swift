import SwiftUI
import UIKit

struct ProductSelectionView: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> ProductSelectionViewController {
        return ProductSelectionViewController()
    }
    
    func updateUIViewController(_ uiViewController: ProductSelectionViewController, context: Context) {
    }
}

struct Promocodes: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> ViewController {
        return ViewController()
    }
    
    func updateUIViewController(_ uiViewController: ViewController, context: Context) {
    }
}

struct MainView: View {
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                NavigationLink("Review Screen", destination: Screen1())
                NavigationLink("Promocodes Screen", destination: Screen2())
                NavigationLink("Order cancel", destination: Screen3())
                NavigationLink("Экран 4", destination: Screen4())
            }
            .navigationTitle("")
            .padding()
        }
    }
}

struct Screen1: View {
    var body: some View {
        ProductSelectionView()
            .edgesIgnoringSafeArea(.all)
    }
}

struct Screen2: View {
    var body: some View {
        Promocodes()
            .edgesIgnoringSafeArea(.all)
    }
}

struct Screen3: View {
    var body: some View {
        OrderCancel()
    }
}

struct Screen4: View {
    var body: some View {
        Text("Это экран 4")
            .font(.largeTitle)
            .padding()
    }
}
