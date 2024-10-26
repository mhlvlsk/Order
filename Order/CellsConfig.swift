//import UIKit
//
//class CellsConfig: UIViewController {
//    
//    var applyPromocodeButton: UIButton!
//    var hidePromocodesLabel: UILabel!
//    var totalPriceLabel: UILabel!
//    var totalPriceText: UILabel!
//    var baseDiscountLabel: UILabel!
//    var baseDiscountText: UILabel!
//    var discountLabel: UILabel!
//    var discountText: UILabel!
//    var paymentLabel: UILabel!
//    var paymentText: UILabel!
//    var finalPriceLabel: UILabel!
//    var finalPriceText: UILabel!
//    var applyButton: UIButton!
//    var promocodeStackView: UIStackView!
//    var errorMessageLabel: UILabel!
//    
//    let mainVC = ViewController()
//
//    func cellsConfig(forRow row: Int, in contentView: UIView) {
//        contentView.subviews.forEach { $0.removeFromSuperview() }
//        
//        switch row {
//        case 0:
//            let titleLabel = UILabel()
//            titleLabel.text = "Оформление заказа"
//            titleLabel.font = UIFont.systemFont(ofSize: 17, weight: .medium)
//            titleLabel.textAlignment = .center
//            titleLabel.numberOfLines = 0
//            titleLabel.translatesAutoresizingMaskIntoConstraints = false
//            contentView.addSubview(titleLabel)
//            
//            NSLayoutConstraint.activate([
//                titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
//                titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
//                titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
//                titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
//                contentView.heightAnchor.constraint(greaterThanOrEqualToConstant: 5)
//            ])
//            
//        case 1:
//            let promocodesTitleLabel = UILabel()
//            promocodesTitleLabel.text = "Промокоды"
//            promocodesTitleLabel.font = UIFont.systemFont(ofSize: 24, weight: .bold)
//            promocodesTitleLabel.textAlignment = .left
//            promocodesTitleLabel.numberOfLines = 0
//            promocodesTitleLabel.lineBreakMode = .byWordWrapping
//            promocodesTitleLabel.translatesAutoresizingMaskIntoConstraints = false
//            contentView.addSubview(promocodesTitleLabel)
//            
//            let discountMessageLabel = UILabel()
//            discountMessageLabel.text = "На один товар можно применить только один промокод"
//            discountMessageLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
//            discountMessageLabel.textAlignment = .left
//            discountMessageLabel.textColor = .gray
//            discountMessageLabel.numberOfLines = 0
//            discountMessageLabel.lineBreakMode = .byWordWrapping
//            discountMessageLabel.translatesAutoresizingMaskIntoConstraints = false
//            contentView.addSubview(discountMessageLabel)
//            
//            applyPromocodeButton = UIButton(type: .system)
//            applyPromocodeButton.setTitle("Применить промокод", for: .normal)
//            applyPromocodeButton.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .medium)
//            applyPromocodeButton.backgroundColor = mainVC.ultraLightOrange
//            applyPromocodeButton.setTitleColor(mainVC.brickOrange, for: .normal)
//            applyPromocodeButton.layer.cornerRadius = 10
//            applyPromocodeButton.clipsToBounds = true
//            applyPromocodeButton.translatesAutoresizingMaskIntoConstraints = false
//            applyPromocodeButton.addTarget(self, action: #selector(mainVC.applyPromocodes), for: .touchUpInside)
//            contentView.addSubview(applyPromocodeButton)
//            
//            NSLayoutConstraint.activate([
//                promocodesTitleLabel.topAnchor.constraint(equalTo:contentView.topAnchor, constant: 10),
//                promocodesTitleLabel.leadingAnchor.constraint(equalTo:contentView.leadingAnchor, constant: 20),
//                promocodesTitleLabel.trailingAnchor.constraint(equalTo:contentView.trailingAnchor, constant: -20),
//                discountMessageLabel.topAnchor.constraint(equalTo: promocodesTitleLabel.bottomAnchor, constant: 10),
//                discountMessageLabel.leadingAnchor.constraint(equalTo:contentView.leadingAnchor, constant: 20),
//                discountMessageLabel.trailingAnchor.constraint(equalTo:contentView.trailingAnchor, constant: -20),
//                applyPromocodeButton.topAnchor.constraint(equalTo: discountMessageLabel.bottomAnchor, constant: 20),
//                applyPromocodeButton.centerXAnchor.constraint(equalTo:contentView.centerXAnchor),
//                applyPromocodeButton.leadingAnchor.constraint(equalTo:contentView.leadingAnchor, constant: 20),
//                applyPromocodeButton.trailingAnchor.constraint(equalTo:contentView.trailingAnchor, constant: -20),
//                applyPromocodeButton.heightAnchor.constraint(equalToConstant: 52),
//                //applyPromocodeButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
//                contentView.heightAnchor.constraint(greaterThanOrEqualToConstant: 155)
//            ])
//            
//        case 2..<2 + mainVC.promocodes.count:
//            let promocodeStackView = UIStackView()
//            promocodeStackView.axis = .vertical
//            promocodeStackView.spacing = 15
//            promocodeStackView.translatesAutoresizingMaskIntoConstraints = false
//            contentView.addSubview(promocodeStackView)
//            
//            let i = row - 2
//            mainVC.addPromocode(to: promocodeStackView, from: mainVC.promocodes, at: i)
//            
//            NSLayoutConstraint.activate([
//                promocodeStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
//                promocodeStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
//                promocodeStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
//                contentView.heightAnchor.constraint(greaterThanOrEqualToConstant: 100)
//            ])
//            
//        case 2 + mainVC.promocodes.count:
//            hidePromocodesLabel = UILabel()
//            //hidePromocodesLabel.text = arePromocodesHidden ? "Показать все промокоды" : "Скрыть промокоды"
//            hidePromocodesLabel.text = "Скрыть промокоды"
//            hidePromocodesLabel.textColor = mainVC.brickOrange
//            hidePromocodesLabel.font = UIFont.systemFont(ofSize: 16, weight: .medium)
//            hidePromocodesLabel.textAlignment = .left
//            hidePromocodesLabel.isUserInteractionEnabled = true
//            hidePromocodesLabel.translatesAutoresizingMaskIntoConstraints = false
//            hidePromocodesLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(mainVC.hidePromocodesTapped)))
//            contentView.addSubview(hidePromocodesLabel)
//            
//            NSLayoutConstraint.activate([
//                hidePromocodesLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
//                hidePromocodesLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
//                hidePromocodesLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
//            ])
//        case 3 + mainVC.promocodes.count:
//            totalPriceLabel = UILabel()
//            totalPriceLabel.textAlignment = .right
//            totalPriceLabel.font = UIFont.systemFont(ofSize: 15, weight: .medium)
//            totalPriceLabel.translatesAutoresizingMaskIntoConstraints = false
//            contentView.addSubview(totalPriceLabel)
//            
//            baseDiscountLabel = UILabel()
//            baseDiscountLabel.textAlignment = .right
//            baseDiscountLabel.font = UIFont.systemFont(ofSize: 15, weight: .medium)
//            baseDiscountLabel.textColor = mainVC.brickOrange
//            baseDiscountLabel.translatesAutoresizingMaskIntoConstraints = false
//            contentView.addSubview(baseDiscountLabel)
//            
//            discountLabel = UILabel()
//            discountLabel.textAlignment = .right
//            discountLabel.font = UIFont.systemFont(ofSize: 15, weight: .medium)
//            discountLabel.textColor = mainVC.customGreen
//            discountLabel.translatesAutoresizingMaskIntoConstraints = false
//            contentView.addSubview(discountLabel)
//            
//            finalPriceLabel = UILabel()
//            finalPriceLabel.textAlignment = .right
//            finalPriceLabel.font = UIFont.systemFont(ofSize: 20, weight: .medium)
//            finalPriceLabel.translatesAutoresizingMaskIntoConstraints = false
//            contentView.addSubview(finalPriceLabel)
//            
//            paymentLabel = UILabel()
//            paymentLabel.textAlignment = .right
//            paymentLabel.font = UIFont.systemFont(ofSize: 15, weight: .medium)
//            paymentLabel.translatesAutoresizingMaskIntoConstraints = false
//            contentView.addSubview(paymentLabel)
//            
//            totalPriceText = UILabel()
//            totalPriceText.font = UIFont.systemFont(ofSize: 15, weight: .medium)
//            totalPriceText.translatesAutoresizingMaskIntoConstraints = false
//            contentView.addSubview(totalPriceText)
//            
//            baseDiscountText = UILabel()
//            baseDiscountText.font = UIFont.systemFont(ofSize: 15, weight: .medium)
//            baseDiscountText.translatesAutoresizingMaskIntoConstraints = false
//            contentView.addSubview(baseDiscountText)
//            
//            discountText = UILabel()
//            discountText.font = UIFont.systemFont(ofSize: 15, weight: .medium)
//            discountText.translatesAutoresizingMaskIntoConstraints = false
//            contentView.addSubview(discountText)
//            
//            paymentText = UILabel()
//            paymentText.font = UIFont.systemFont(ofSize: 15, weight: .medium)
//            paymentText.translatesAutoresizingMaskIntoConstraints = false
//            contentView.addSubview(paymentText)
//            
//            let separator = UILabel()
//            separator.backgroundColor = UIColor.lightGray
//            separator.translatesAutoresizingMaskIntoConstraints = false
//            contentView.addSubview(separator)
//            
//            finalPriceText = UILabel()
//            finalPriceText.font = UIFont.systemFont(ofSize: 20, weight: .medium)
//            finalPriceText.translatesAutoresizingMaskIntoConstraints = false
//            contentView.addSubview(finalPriceText)
//            
//            errorMessageLabel = UILabel()
//            errorMessageLabel.textAlignment = .center
//            errorMessageLabel.font = UIFont.systemFont(ofSize: 16, weight: .medium)
//            errorMessageLabel.textColor = .red
//            errorMessageLabel.numberOfLines = 0
//            errorMessageLabel.translatesAutoresizingMaskIntoConstraints = false
//            contentView.addSubview(errorMessageLabel)
//            
//            applyButton = UIButton(type: .system)
//            applyButton.setTitle("Оформить заказ", for: .normal)
//            applyButton.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .medium)
//            applyButton.backgroundColor = mainVC.brickOrange
//            applyButton.setTitleColor(.white, for: .normal)
//            applyButton.layer.cornerRadius = 10
//            applyButton.clipsToBounds = true
//            applyButton.translatesAutoresizingMaskIntoConstraints = false
//            applyButton.addTarget(self, action: #selector(mainVC.applyOrder), for: .touchUpInside)
//            contentView.addSubview(applyButton)
//            
//            let agreementText = UILabel()
//            let text = "Нажимая кнопку «Оформить заказ»,\nВы соглашаетесь с "
//            let boldText = "Условиями оферты"
//            let attributedString = NSMutableAttributedString(string: text, attributes: [
//                .font: UIFont.systemFont(ofSize: 11, weight: .regular),
//                .foregroundColor: UIColor.gray
//            ])
//            let boldAttributes: [NSAttributedString.Key: Any] = [
//                .font: UIFont.systemFont(ofSize: 11, weight: .regular),
//                .foregroundColor: UIColor.black
//            ]
//            attributedString.append(NSAttributedString(string: boldText, attributes: boldAttributes))
//            agreementText.attributedText = attributedString
//            agreementText.textAlignment = .center
//            agreementText.numberOfLines = 0
//            agreementText.lineBreakMode = .byWordWrapping
//            agreementText.translatesAutoresizingMaskIntoConstraints = false
//            contentView.addSubview(agreementText)
//
//        
//            NSLayoutConstraint.activate([
//                totalPriceLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
//                totalPriceLabel.leadingAnchor.constraint(equalTo:contentView.leadingAnchor, constant: 20),
//                totalPriceLabel.trailingAnchor.constraint(equalTo:contentView.trailingAnchor, constant: -20),
//                baseDiscountLabel.topAnchor.constraint(equalTo: totalPriceLabel.bottomAnchor, constant: 10),
//                baseDiscountLabel.leadingAnchor.constraint(equalTo:contentView.leadingAnchor, constant: 20),
//                baseDiscountLabel.trailingAnchor.constraint(equalTo:contentView.trailingAnchor, constant: -20),
//                discountLabel.topAnchor.constraint(equalTo: baseDiscountLabel.bottomAnchor, constant: 10),
//                discountLabel.leadingAnchor.constraint(equalTo:contentView.leadingAnchor, constant: 20),
//                discountLabel.trailingAnchor.constraint(equalTo:contentView.trailingAnchor, constant: -20),
//                paymentLabel.topAnchor.constraint(equalTo: discountLabel.bottomAnchor, constant: 10),
//                paymentLabel.leadingAnchor.constraint(equalTo:contentView.leadingAnchor, constant: 20),
//                paymentLabel.trailingAnchor.constraint(equalTo:contentView.trailingAnchor, constant: -20),
//                separator.heightAnchor.constraint(equalToConstant: 1),
//                separator.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
//                separator.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
//                separator.bottomAnchor.constraint(equalTo: contentView.topAnchor, constant: 124),
//                finalPriceLabel.topAnchor.constraint(equalTo: paymentLabel.bottomAnchor, constant: 20),
//                finalPriceLabel.leadingAnchor.constraint(equalTo:contentView.leadingAnchor, constant: 20),
//                finalPriceLabel.trailingAnchor.constraint(equalTo:contentView.trailingAnchor, constant: -20),
//                totalPriceText.leadingAnchor.constraint(equalTo:contentView.leadingAnchor, constant: 20),
//                totalPriceText.centerYAnchor.constraint(equalTo: totalPriceLabel.centerYAnchor),
//                finalPriceText.leadingAnchor.constraint(equalTo:contentView.leadingAnchor, constant: 20),
//                finalPriceText.centerYAnchor.constraint(equalTo: finalPriceLabel.centerYAnchor),
//                applyButton.topAnchor.constraint(equalTo: finalPriceLabel.bottomAnchor, constant: 10),
//                applyButton.centerXAnchor.constraint(equalTo:contentView.centerXAnchor),
//                applyButton.widthAnchor.constraint(equalToConstant: 300),
//                applyButton.heightAnchor.constraint(equalToConstant: 55),
//                baseDiscountText.leadingAnchor.constraint(equalTo:contentView.leadingAnchor, constant: 20),
//                baseDiscountText.centerYAnchor.constraint(equalTo: baseDiscountLabel.centerYAnchor),
//                discountText.leadingAnchor.constraint(equalTo:contentView.leadingAnchor, constant: 20),
//                discountText.centerYAnchor.constraint(equalTo: discountLabel.centerYAnchor),
//                paymentText.leadingAnchor.constraint(equalTo:contentView.leadingAnchor, constant: 20),
//                paymentText.centerYAnchor.constraint(equalTo: paymentLabel.centerYAnchor),
//                errorMessageLabel.topAnchor.constraint(equalTo: finalPriceLabel.bottomAnchor, constant: 10),
//                errorMessageLabel.centerXAnchor.constraint(equalTo:contentView.centerXAnchor),
//                errorMessageLabel.leadingAnchor.constraint(equalTo:contentView.leadingAnchor, constant: 20),
//                errorMessageLabel.trailingAnchor.constraint(equalTo:contentView.trailingAnchor, constant: -20),
//                agreementText.topAnchor.constraint(equalTo: applyButton.bottomAnchor, constant: 10),
//                agreementText.leadingAnchor.constraint(equalTo:contentView.leadingAnchor, constant: 20),
//                agreementText.trailingAnchor.constraint(equalTo:contentView.trailingAnchor, constant: -20),
//                //agreementText.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
//                contentView.heightAnchor.constraint(greaterThanOrEqualToConstant: 270)
//            ])
//            
//        default:
//            break
//        }
//    }
//}
