import UIKit

protocol AddPromocodeViewControllerDelegate: AnyObject {
    func newSelectPromocode(_ promocode: Order.Promocode)
}

class AddPromocodeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var order: Order?
    var enteredText: String = ""
    private let textField = UITextField()
    private var promoPool: [Order.Promocode] = []
    private let tableView = UITableView()
    
    let mainVC = ViewController()
    
    weak var delegate: AddPromocodeViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        promoPool = order?.promocodesPool ?? []
        
        setupUI()
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        
        let backButton = UIButton(type: .system)
        let backImage = UIImage(systemName: "chevron.left")
        backButton.setImage(backImage, for: .normal)
        backButton.tintColor = mainVC.brickOrange
        backButton.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        backButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(backButton)
        
        let titleLabel = UILabel()
        titleLabel.text = "Применить промокод"
        titleLabel.font = UIFont.systemFont(ofSize: 17, weight: .medium)
        titleLabel.textAlignment = .center
        titleLabel.numberOfLines = 0
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(titleLabel)
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        
        let applyButton = UIButton(type: .system)
        applyButton.setTitle("Применить", for: .normal)
        applyButton.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        applyButton.backgroundColor = mainVC.brickOrange
        applyButton.setTitleColor(.white, for: .normal)
        applyButton.layer.cornerRadius = 10
        applyButton.clipsToBounds = true
        applyButton.translatesAutoresizingMaskIntoConstraints = false
        applyButton.addTarget(self, action: #selector(applyPromoButton), for: .touchUpInside)
        applyButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(applyButton)
   
        textField.placeholder = "Введите промокод"
        textField.borderStyle = .roundedRect
        textField.layer.cornerRadius = 10
        textField.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(textField)
        
        NSLayoutConstraint.activate([
            
            backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            backButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 5),

            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 5),
            titleLabel.centerXAnchor.constraint(equalTo:view.centerXAnchor),
            titleLabel.leadingAnchor.constraint(equalTo:view.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo:view.trailingAnchor, constant: -20),

            textField.topAnchor.constraint(equalTo: titleLabel.safeAreaLayoutGuide.bottomAnchor, constant: 20),
            textField.centerXAnchor.constraint(equalTo:view.centerXAnchor),
            textField.leadingAnchor.constraint(equalTo:view.leadingAnchor, constant: 20),
            textField.trailingAnchor.constraint(equalTo:view.trailingAnchor, constant: -20),
            textField.heightAnchor.constraint(equalToConstant: 52),
            
            applyButton.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 20),
            applyButton.centerXAnchor.constraint(equalTo:view.centerXAnchor),
            applyButton.leadingAnchor.constraint(equalTo:view.leadingAnchor, constant: 20),
            applyButton.trailingAnchor.constraint(equalTo:view.trailingAnchor, constant: -20),
            applyButton.heightAnchor.constraint(equalToConstant: 52),
            
            tableView.topAnchor.constraint(equalTo: applyButton.bottomAnchor, constant: 20),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    @objc private func backButtonTapped() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func applyPromoButton() {
        enteredText = textField.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""

        if let matchedPromocode = promoPool.first(where: { $0.title.lowercased() == enteredText.lowercased() }) {
            if let mainVC = self.delegate as? ViewController {
                if mainVC.order?.promocodes.contains(where: { $0.title.lowercased() == matchedPromocode.title.lowercased() }) == true {
                    let alert = UIAlertController(title: "Ошибка", message: "Промокод уже добавлен", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    present(alert, animated: true, completion: nil)
                } else {
                    delegate?.newSelectPromocode(matchedPromocode)
                    self.dismiss(animated: true, completion: nil)
                }
            }
        } else {
            let alert = UIAlertController(title: "Ошибка", message: "Промокод не найден", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PromocodeCell") ?? UITableViewCell(style: .default, reuseIdentifier: "PromocodeCell")
        
        tableView.separatorStyle = .none
        cell.selectionStyle = .none
        
        return cell
    }
}
