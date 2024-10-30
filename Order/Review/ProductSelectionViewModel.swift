import Foundation

class ProductSelectionViewModel {
    private var products: [Product] = [
        Product(name: "Золотое плоское обручальное кольцо 4 мм", size: "17", imageName: "ring1"),
        Product(name: "Золотое плоское обручальное кольцо 4 мм", size: "17", imageName: "ring2"),
        Product(name: "Золотое плоское обручальное кольцо 4 мм", size: "17", imageName: "ring3"),
        Product(name: "Золотое плоское обручальное кольцо 4 мм", size: "17", imageName: "ring1"),
    ]
    
    var numberOfProducts: Int {
        return products.count
    }
    
    func product(at index: Int) -> Product? {
        guard index >= 0 && index < products.count else { return nil }
        return products[index]
    }
}

