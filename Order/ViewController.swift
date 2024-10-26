import UIKit

struct Order {
    struct Promocode {
        let title: String
        let percent: Int
        let endDate: Date?
        let info: String?
        var active: Bool
    }
    
    struct Product {
        let price: Double
        let title: String
    }
    
    var screenTitle: String
    var promocodes: [Promocode]
    let products: [Product]
    let paymentDiscount: Double?
    let baseDiscount: Double?
}

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var order: Order?
    var totalPriceLabel: UILabel!
    var totalPriceText: UILabel!
    var baseDiscountLabel: UILabel!
    var baseDiscountText: UILabel!
    var discountLabel: UILabel!
    var discountText: UILabel!
    var paymentLabel: UILabel!
    var paymentText: UILabel!
    var finalPriceLabel: UILabel!
    var finalPriceText: UILabel!
    var applyButton: UIButton!
    var promocodeStackView: UIStackView!
    var errorMessageLabel: UILabel!
    var applyPromocodeButton: UIButton!
    var hidePromocodesLabel: UILabel!
    var promocodes: [UIView] = []
    
    let brickOrange = UIColor(red: 1.0, green: 0.333, blue: 0.0, alpha: 1.0)
    let customGreen = UIColor(red: 0.235, green: 0.765, blue: 0.482, alpha: 1.0)
    let ultraLightOrange = UIColor(red: 1.0, green: 0.894, blue: 0.854, alpha: 1.0)
    
    let viewModel = ViewModel()
    let buttonsClicks = ButtonsClicks()
    
    var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        loadOrderData()
    }
    
    private func loadOrderData() {
        DispatchQueue.global().async { [weak self] in
            guard let self = self else { return }
            self.order = self.viewModel.createExampleOrder()
            DispatchQueue.main.async {
                self.promocodes = self.order?.promocodes.map { self.createStyledPromocodeView(promocode: $0) } ?? []
                self.updateUI()
            }
        }
    }
    
    private func setupTableView() {
        tableView = UITableView(frame: self.view.bounds, style: .plain)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "OrderCell")
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 100
        self.view.addSubview(tableView)
    }
    
    private func updateUI() {
        guard let order = order else { return }
        do {
            try showOrder(order: order)
            tableView.reloadData()
        } catch let error {
            showError(error: error.localizedDescription)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return promocodes.count + 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "OrderCell", for: indexPath)
        
        cell.contentView.subviews.forEach { $0.removeFromSuperview() }
        
        let contentView = UIView()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        cell.contentView.addSubview(contentView)
        
        if indexPath.row == 0 {
            
            let titleLabel = UILabel()
            titleLabel.text = "Оформление заказа"
            titleLabel.font = UIFont.systemFont(ofSize: 14, weight: .medium)
            titleLabel.textAlignment = .center
            titleLabel.numberOfLines = 0
            titleLabel.lineBreakMode = .byWordWrapping
            titleLabel.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview(titleLabel)
            
            NSLayoutConstraint.activate([
                titleLabel.topAnchor.constraint(equalTo:contentView.topAnchor),
                titleLabel.leadingAnchor.constraint(equalTo:contentView.leadingAnchor, constant: 20),
                titleLabel.trailingAnchor.constraint(equalTo:contentView.trailingAnchor, constant: -20),
                titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
                contentView.heightAnchor.constraint(greaterThanOrEqualToConstant: 5)
            ])
        } else if indexPath.row == 1 {
            
            let promocodesTitleLabel = UILabel()
            promocodesTitleLabel.text = "Промокоды"
            promocodesTitleLabel.font = UIFont.systemFont(ofSize: 24, weight: .bold)
            promocodesTitleLabel.textAlignment = .left
            promocodesTitleLabel.numberOfLines = 0
            promocodesTitleLabel.lineBreakMode = .byWordWrapping
            promocodesTitleLabel.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview(promocodesTitleLabel)
            
            let discountMessageLabel = UILabel()
            discountMessageLabel.text = "На один товар можно применить только один промокод"
            discountMessageLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
            discountMessageLabel.textAlignment = .left
            discountMessageLabel.textColor = .gray
            discountMessageLabel.numberOfLines = 0
            discountMessageLabel.lineBreakMode = .byWordWrapping
            discountMessageLabel.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview(discountMessageLabel)
            
            applyPromocodeButton = UIButton(type: .system)
            applyPromocodeButton.setTitle("Применить промокод", for: .normal)
            applyPromocodeButton.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .medium)
            applyPromocodeButton.backgroundColor = ultraLightOrange
            applyPromocodeButton.setTitleColor(brickOrange, for: .normal)
            applyPromocodeButton.layer.cornerRadius = 10
            applyPromocodeButton.clipsToBounds = true
            applyPromocodeButton.translatesAutoresizingMaskIntoConstraints = false
            applyPromocodeButton.addTarget(self, action: #selector(applyPromocodes), for: .touchUpInside)
            contentView.addSubview(applyPromocodeButton)
            
            NSLayoutConstraint.activate([
                promocodesTitleLabel.topAnchor.constraint(equalTo:contentView.topAnchor, constant: 10),
                promocodesTitleLabel.leadingAnchor.constraint(equalTo:contentView.leadingAnchor, constant: 20),
                promocodesTitleLabel.trailingAnchor.constraint(equalTo:contentView.trailingAnchor, constant: -20),
                discountMessageLabel.topAnchor.constraint(equalTo: promocodesTitleLabel.bottomAnchor, constant: 10),
                discountMessageLabel.leadingAnchor.constraint(equalTo:contentView.leadingAnchor, constant: 20),
                discountMessageLabel.trailingAnchor.constraint(equalTo:contentView.trailingAnchor, constant: -20),
                applyPromocodeButton.topAnchor.constraint(equalTo: discountMessageLabel.bottomAnchor, constant: 20),
                applyPromocodeButton.centerXAnchor.constraint(equalTo:contentView.centerXAnchor),
                applyPromocodeButton.leadingAnchor.constraint(equalTo:contentView.leadingAnchor, constant: 20),
                applyPromocodeButton.trailingAnchor.constraint(equalTo:contentView.trailingAnchor, constant: -20),
                applyPromocodeButton.heightAnchor.constraint(equalToConstant: 52),
                //applyPromocodeButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
                contentView.heightAnchor.constraint(greaterThanOrEqualToConstant: 155)
            ])
        } else if indexPath.row >= 2 && indexPath.row < 2 + promocodes.count {
            
            let promocodeStackView = UIStackView()
            promocodeStackView.axis = .vertical
            promocodeStackView.spacing = 15
            promocodeStackView.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview(promocodeStackView)
            
            let i = indexPath.row - 2
            
            addPromocode(to: promocodeStackView, from: promocodes, at: i)
            
            NSLayoutConstraint.activate([
                promocodeStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
                promocodeStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
                promocodeStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
                contentView.heightAnchor.constraint(greaterThanOrEqualToConstant: 100)
            ])
        } else if indexPath.row == 2 + promocodes.count {
            
            hidePromocodesLabel = UILabel()
            hidePromocodesLabel.text = "Скрыть промокоды"
            hidePromocodesLabel.textColor = brickOrange
            hidePromocodesLabel.font = UIFont.systemFont(ofSize: 16, weight: .medium)
            hidePromocodesLabel.textAlignment = .left
            hidePromocodesLabel.isUserInteractionEnabled = true
            hidePromocodesLabel.translatesAutoresizingMaskIntoConstraints = false
            hidePromocodesLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(hidePromocodesTapped)))
            contentView.addSubview(hidePromocodesLabel)
            
            NSLayoutConstraint.activate([
                hidePromocodesLabel.topAnchor.constraint(equalTo:contentView.topAnchor, constant: 10),
                hidePromocodesLabel.leadingAnchor.constraint(equalTo:contentView.leadingAnchor, constant: 20),
                hidePromocodesLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
            ])
        } else if indexPath.row == 3 + promocodes.count {
            
            totalPriceLabel = UILabel()
            totalPriceLabel.textAlignment = .right
            totalPriceLabel.font = UIFont.systemFont(ofSize: 15, weight: .medium)
            totalPriceLabel.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview(totalPriceLabel)
            
            baseDiscountLabel = UILabel()
            baseDiscountLabel.textAlignment = .right
            baseDiscountLabel.font = UIFont.systemFont(ofSize: 15, weight: .medium)
            baseDiscountLabel.textColor = brickOrange
            baseDiscountLabel.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview(baseDiscountLabel)
            
            discountLabel = UILabel()
            discountLabel.textAlignment = .right
            discountLabel.font = UIFont.systemFont(ofSize: 15, weight: .medium)
            discountLabel.textColor = customGreen
            discountLabel.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview(discountLabel)
            
            finalPriceLabel = UILabel()
            finalPriceLabel.textAlignment = .right
            finalPriceLabel.font = UIFont.systemFont(ofSize: 20, weight: .medium)
            finalPriceLabel.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview(finalPriceLabel)
            
            paymentLabel = UILabel()
            paymentLabel.textAlignment = .right
            paymentLabel.font = UIFont.systemFont(ofSize: 15, weight: .medium)
            paymentLabel.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview(paymentLabel)
            
            totalPriceText = UILabel()
            totalPriceText.font = UIFont.systemFont(ofSize: 15, weight: .medium)
            totalPriceText.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview(totalPriceText)
            
            baseDiscountText = UILabel()
            baseDiscountText.font = UIFont.systemFont(ofSize: 15, weight: .medium)
            baseDiscountText.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview(baseDiscountText)
            
            discountText = UILabel()
            discountText.font = UIFont.systemFont(ofSize: 15, weight: .medium)
            discountText.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview(discountText)
            
            paymentText = UILabel()
            paymentText.font = UIFont.systemFont(ofSize: 15, weight: .medium)
            paymentText.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview(paymentText)
            
            finalPriceText = UILabel()
            finalPriceText.font = UIFont.systemFont(ofSize: 20, weight: .medium)
            finalPriceText.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview(finalPriceText)
            
            errorMessageLabel = UILabel()
            errorMessageLabel.textAlignment = .center
            errorMessageLabel.font = UIFont.systemFont(ofSize: 16, weight: .medium)
            errorMessageLabel.textColor = .red
            errorMessageLabel.numberOfLines = 0
            errorMessageLabel.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview(errorMessageLabel)
            
            applyButton = UIButton(type: .system)
            applyButton.setTitle("Оформить заказ", for: .normal)
            applyButton.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .medium)
            applyButton.backgroundColor = brickOrange
            applyButton.setTitleColor(.white, for: .normal)
            applyButton.layer.cornerRadius = 10
            applyButton.clipsToBounds = true
            applyButton.translatesAutoresizingMaskIntoConstraints = false
            applyButton.addTarget(self, action: #selector(applyOrder), for: .touchUpInside)
            contentView.addSubview(applyButton)
            
            let agreementText = UILabel()
            agreementText.text = "Нажимая кнопку «Оформить заказ»,\nВы соглашаетесь с Условиями оферты"
            agreementText.font = UIFont.systemFont(ofSize: 11, weight: .regular)
            agreementText.textAlignment = .center
            agreementText.textColor = .gray
            agreementText.numberOfLines = 0
            agreementText.lineBreakMode = .byWordWrapping
            agreementText.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview(agreementText)
            
            NSLayoutConstraint.activate([
                totalPriceLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
                totalPriceLabel.leadingAnchor.constraint(equalTo:contentView.leadingAnchor, constant: 20),
                totalPriceLabel.trailingAnchor.constraint(equalTo:contentView.trailingAnchor, constant: -20),
                baseDiscountLabel.topAnchor.constraint(equalTo: totalPriceLabel.bottomAnchor, constant: 10),
                baseDiscountLabel.leadingAnchor.constraint(equalTo:contentView.leadingAnchor, constant: 20),
                baseDiscountLabel.trailingAnchor.constraint(equalTo:contentView.trailingAnchor, constant: -20),
                discountLabel.topAnchor.constraint(equalTo: baseDiscountLabel.bottomAnchor, constant: 10),
                discountLabel.leadingAnchor.constraint(equalTo:contentView.leadingAnchor, constant: 20),
                discountLabel.trailingAnchor.constraint(equalTo:contentView.trailingAnchor, constant: -20),
                paymentLabel.topAnchor.constraint(equalTo: discountLabel.bottomAnchor, constant: 10),
                paymentLabel.leadingAnchor.constraint(equalTo:contentView.leadingAnchor, constant: 20),
                paymentLabel.trailingAnchor.constraint(equalTo:contentView.trailingAnchor, constant: -20),
                finalPriceLabel.topAnchor.constraint(equalTo: paymentLabel.bottomAnchor, constant: 20),
                finalPriceLabel.leadingAnchor.constraint(equalTo:contentView.leadingAnchor, constant: 20),
                finalPriceLabel.trailingAnchor.constraint(equalTo:contentView.trailingAnchor, constant: -20),
                totalPriceText.leadingAnchor.constraint(equalTo:contentView.leadingAnchor, constant: 20),
                totalPriceText.centerYAnchor.constraint(equalTo: totalPriceLabel.centerYAnchor),
                finalPriceText.leadingAnchor.constraint(equalTo:contentView.leadingAnchor, constant: 20),
                finalPriceText.centerYAnchor.constraint(equalTo: finalPriceLabel.centerYAnchor),
                applyButton.topAnchor.constraint(equalTo: finalPriceLabel.bottomAnchor, constant: 10),
                applyButton.centerXAnchor.constraint(equalTo:contentView.centerXAnchor),
                applyButton.widthAnchor.constraint(equalToConstant: 300),
                applyButton.heightAnchor.constraint(equalToConstant: 55),
                baseDiscountText.leadingAnchor.constraint(equalTo:contentView.leadingAnchor, constant: 20),
                baseDiscountText.centerYAnchor.constraint(equalTo: baseDiscountLabel.centerYAnchor),
                discountText.leadingAnchor.constraint(equalTo:contentView.leadingAnchor, constant: 20),
                discountText.centerYAnchor.constraint(equalTo: discountLabel.centerYAnchor),
                paymentText.leadingAnchor.constraint(equalTo:contentView.leadingAnchor, constant: 20),
                paymentText.centerYAnchor.constraint(equalTo: paymentLabel.centerYAnchor),
                errorMessageLabel.topAnchor.constraint(equalTo: finalPriceLabel.bottomAnchor, constant: 10),
                errorMessageLabel.centerXAnchor.constraint(equalTo:contentView.centerXAnchor),
                errorMessageLabel.leadingAnchor.constraint(equalTo:contentView.leadingAnchor, constant: 20),
                errorMessageLabel.trailingAnchor.constraint(equalTo:contentView.trailingAnchor, constant: -20),
                agreementText.topAnchor.constraint(equalTo: applyButton.bottomAnchor, constant: 10),
                agreementText.leadingAnchor.constraint(equalTo:contentView.leadingAnchor, constant: 20),
                agreementText.trailingAnchor.constraint(equalTo:contentView.trailingAnchor, constant: -20),
                //agreementText.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
                contentView.heightAnchor.constraint(greaterThanOrEqualToConstant: 270)
            ])
        }
        
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: cell.contentView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: cell.contentView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: cell.contentView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: cell.contentView.bottomAnchor),
        ])
        
        if indexPath.row == 3 + promocodes.count {
            cell.backgroundColor = UIColor(white: 0.95, alpha: 1)
        } else {
            cell.backgroundColor = UIColor.white
        }
        
        tableView.separatorStyle = .none
        cell.selectionStyle = .none
        
        return cell
    }
    
    
    func showOrder(order: Order) throws {
        errorMessageLabel.text = ""
        
        guard !order.products.isEmpty else {
            throw NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Нет продуктов в заказе."])
        }
        
        let totalProductsPrice = order.products.reduce(0) { $0 + $1.price }
        let productCount = order.products.count
        totalPriceText.text = "Цена за \(productCount) \(viewModel.changePurchases(count: productCount)) ₽"
        totalPriceLabel.text = viewModel.formatCurrency(totalProductsPrice)
        
        let activePromocodes = order.promocodes.filter { $0.active }.prefix(2)
        let promocodeDiscount = activePromocodes.reduce(0) { $0 + Double($1.percent) * totalProductsPrice / 100 }
        let totalDiscount = (order.baseDiscount ?? 0) + (order.paymentDiscount ?? 0) + promocodeDiscount
        
        guard totalDiscount <= totalProductsPrice else {
            throw NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Сумма текущей скидки не может быть больше суммы заказа."])
        }
        
        baseDiscountText.text = "Скидки"
        baseDiscountLabel.text = "-\(viewModel.formatCurrency(order.baseDiscount ?? 0)) ₽"
        
        discountText.text = "Промокоды"
        discountLabel.text = "-\(viewModel.formatCurrency(promocodeDiscount)) ₽"
        
        paymentText.text = "Способ оплаты"
        paymentLabel.text = "-\(viewModel.formatCurrency(order.paymentDiscount ?? 0)) ₽"
        
        let finalPrice = totalProductsPrice - totalDiscount
        finalPriceText.text = "Итого"
        finalPriceLabel.text = "\(viewModel.formatCurrency(finalPrice)) ₽"
    }
    
    func createStyledPromocodeView(promocode: Order.Promocode) -> UIView {
        let container = UIView()
        container.layer.cornerRadius = 12
        container.backgroundColor = UIColor(white: 0.95, alpha: 1)
        container.translatesAutoresizingMaskIntoConstraints = false
        
        container.heightAnchor.constraint(equalToConstant: 80).isActive = true
        
        let leftCircle = UIView()
        leftCircle.backgroundColor = .white
        leftCircle.layer.cornerRadius = 8
        leftCircle.translatesAutoresizingMaskIntoConstraints = false
        container.addSubview(leftCircle)
        
        let rightCircle = UIView()
        rightCircle.backgroundColor = .white
        rightCircle.layer.cornerRadius = 8
        rightCircle.translatesAutoresizingMaskIntoConstraints = false
        container.addSubview(rightCircle)
        
        let titleLabel = UILabel()
        titleLabel.text = promocode.title
        titleLabel.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        container.addSubview(titleLabel)
        
        let discountBackgroundView = UIView()
        discountBackgroundView.backgroundColor = customGreen
        discountBackgroundView.layer.cornerRadius = 12
        discountBackgroundView.translatesAutoresizingMaskIntoConstraints = false
        container.addSubview(discountBackgroundView)
        
        let discountLabel = UILabel()
        discountLabel.text = "\(promocode.percent)%"
        discountLabel.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        discountLabel.textColor = .white
        discountLabel.translatesAutoresizingMaskIntoConstraints = false
        discountBackgroundView.addSubview(discountLabel)
        
        let infoButton = UIButton(type: .infoLight)
        infoButton.translatesAutoresizingMaskIntoConstraints = false
        infoButton.addTarget(self, action: #selector(infoButtonTapped), for: .touchUpInside)
        container.addSubview(infoButton)
        
        let expirationLabel = UILabel()
        if let endDate = promocode.endDate {
            expirationLabel.text = "По \(viewModel.formatDate(date: endDate))"
        } else {
            expirationLabel.text = "Дата истечения не указана"
        }
        expirationLabel.font = UIFont.systemFont(ofSize: 14, weight: .light)
        expirationLabel.textColor = .gray
        expirationLabel.translatesAutoresizingMaskIntoConstraints = false
        container.addSubview(expirationLabel)
        
        let infoLabel = UILabel()
        infoLabel.text = promocode.info ?? "Не указано"
        infoLabel.font = UIFont.systemFont(ofSize: 14, weight: .light)
        infoLabel.textColor = .gray
        infoLabel.translatesAutoresizingMaskIntoConstraints = false
        container.addSubview(infoLabel)
        
        let switchControl = UISwitch()
        switchControl.isOn = promocode.active
        switchControl.onTintColor = brickOrange
        switchControl.addTarget(self, action: #selector(promocodeSwitchChanged(_:)), for: .valueChanged)
        switchControl.translatesAutoresizingMaskIntoConstraints = false
        container.addSubview(switchControl)
        
        NSLayoutConstraint.activate([
            leftCircle.widthAnchor.constraint(equalToConstant: 16),
            leftCircle.heightAnchor.constraint(equalTo: leftCircle.widthAnchor),
            leftCircle.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: -8),
            leftCircle.centerYAnchor.constraint(equalTo: container.centerYAnchor),
            
            rightCircle.widthAnchor.constraint(equalToConstant: 16),
            rightCircle.heightAnchor.constraint(equalTo: rightCircle.widthAnchor),
            rightCircle.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: 8),
            rightCircle.centerYAnchor.constraint(equalTo: container.centerYAnchor),
            
            titleLabel.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 17),
            titleLabel.topAnchor.constraint(equalTo: container.topAnchor, constant: 10),
            
            discountBackgroundView.leadingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: 5),
            discountBackgroundView.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor),
            discountBackgroundView.heightAnchor.constraint(equalToConstant: 24),
            discountBackgroundView.widthAnchor.constraint(equalToConstant: 50),
            
            discountLabel.centerXAnchor.constraint(equalTo: discountBackgroundView.centerXAnchor),
            discountLabel.centerYAnchor.constraint(equalTo: discountBackgroundView.centerYAnchor),
            
            infoButton.leadingAnchor.constraint(equalTo: discountBackgroundView.trailingAnchor, constant: 5),
            infoButton.centerYAnchor.constraint(equalTo: discountBackgroundView.centerYAnchor),
            infoButton.widthAnchor.constraint(equalToConstant: 24),
            infoButton.heightAnchor.constraint(equalToConstant: 24),
            
            expirationLabel.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 17),
            expirationLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5),
            
            infoLabel.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 17),
            infoLabel.topAnchor.constraint(equalTo: expirationLabel.bottomAnchor, constant: 5),
            
            switchControl.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -17),
            switchControl.centerYAnchor.constraint(equalTo: container.centerYAnchor)
        ])
        
        return container
    }
    
    func addPromocode(to stackView: UIStackView, from promocodes: [UIView], at index: Int) {
        if promocodes.indices.contains(index) {
            let promocode = promocodes[index]
            stackView.addArrangedSubview(promocode)
        } else {
            print("Нет доступного промокода на позиции \(index)")
        }
    }
    
    @objc func infoButtonTapped() {
        buttonsClicks.infoTap()
    }
    
    @objc func hidePromocodesTapped() {
        buttonsClicks.textTapAnimate(text: hidePromocodesLabel)
    }
    
    @objc func promocodeSwitchChanged(_ sender: UISwitch) {
        if let index = promocodes.firstIndex(where: { ($0.subviews.last as? UISwitch) == sender }) {
            let isActive = sender.isOn
            
            let activeCount = order?.promocodes.filter { $0.active }.count ?? 0
            
            if isActive && activeCount >= 2 {
                if let firstActiveIndex = order?.promocodes.firstIndex(where: { $0.active }) {
                    order?.promocodes[firstActiveIndex].active = false
                    if let switchView = promocodes[firstActiveIndex].subviews.last as? UISwitch {
                        switchView.setOn(false, animated: true)
                    }
                }
            }
            order?.promocodes[index].active = isActive
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                if let order = self.order {
                    do {
                        try self.showOrder(order: order)
                    } catch let error {
                        self.showError(error: error.localizedDescription)
                    }
                }
            }
        }
    }
    
    @objc func applyPromocodes() {
        buttonsClicks.buttonAnimate(button: applyPromocodeButton)
    }
    
    @objc func applyOrder() {
        buttonsClicks.buttonAnimate(button:applyButton)
    }
    
    func showError(error: String) {
        errorMessageLabel.text = error
        totalPriceLabel.text = ""
        discountLabel.text = ""
        finalPriceLabel.text = ""
    }
}

