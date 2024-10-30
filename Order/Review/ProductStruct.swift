import UIKit

struct Product {
    let name: String
    let size: String
    let image: UIImage?
    
    init(name: String, size: String, imageName: String) {
        self.name = name
        self.size = size
        self.image = UIImage(named: imageName)
    }
}
