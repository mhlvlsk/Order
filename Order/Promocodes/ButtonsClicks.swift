import UIKit

class ButtonsClicks: UIViewController {
    func buttonAnimate(button: UIButton!){
        UIView.animate(withDuration: 0.1, animations: {
            button.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
            button.alpha = 0.7
        }) { _ in
            UIView.animate(withDuration: 0.4,
                           delay: 0,
                           usingSpringWithDamping: 0.4,
                           initialSpringVelocity: 6.0,
                           options: .allowUserInteraction,
                           animations: {
                button.transform = CGAffineTransform.identity
                button.alpha = 1.0
            }, completion: nil)
        }
    }
    
    func textTapAnimate(text: UILabel!){
        UIView.animate(withDuration: 0.1, animations: {
            text.alpha = 0.5
            }) { _ in
            UIView.animate(withDuration: 0.1, animations: {
                text.alpha = 1.0
            })
        }
    }
    
    func infoTap(){
        let alert = UIAlertController(title: "Внимание", message: "Одновременно можно использовать не более двух промокодов.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))

        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
        let window = windowScene.windows.first(where: { $0.isKeyWindow }),
        let topController = window.rootViewController {
            topController.present(alert, animated: true, completion: nil)
        }
    }
}
