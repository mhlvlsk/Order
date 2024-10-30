import UIKit

class ProductReviewViewController: UIViewController {
    
    private let product: Product
    private let tableView = UITableView(frame: .zero, style: .plain)
    
    init(product: Product) {
        self.product = product
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupTableView()
        
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationController?.navigationBar.tintColor = UIColor(red: 1, green: 0.275, blue: 0.067, alpha: 1)
    }
    
    private func setupUI() {
        title = "Напишите отзыв"
        view.backgroundColor = .white
        
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(ProductReviewCell.self, forCellReuseIdentifier: "ProductReviewCell")
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "ReviewCell")
        tableView.register(RatingCell.self, forCellReuseIdentifier: "RatingCell")
        tableView.register(InputCell.self, forCellReuseIdentifier: "InputCell")
        tableView.register(SendReviewCell.self, forCellReuseIdentifier: "SendReviewCell")
    }
}

extension ProductReviewViewController: UITableViewDataSource, UITableViewDelegate, InputCellDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 7
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        view.endEditing(true)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "ProductReviewCell", for: indexPath) as! ProductReviewCell
            cell.configure(with: product)
            tableView.separatorStyle = .none
            cell.selectionStyle = .none
            return cell
            
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "RatingCell", for: indexPath) as! RatingCell
            tableView.separatorStyle = .none
            cell.selectionStyle = .none
            return cell
            
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "ReviewCell", for: indexPath)
            cell.textLabel?.text = "Review 2"
            tableView.separatorStyle = .none
            cell.selectionStyle = .none
            return cell
            
        case 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: "InputCell", for: indexPath) as! InputCell
            cell.configure(with: "Достоинства", indexPath: indexPath, returnKeyType: .next)
            cell.delegate = self
            tableView.separatorStyle = .none
            cell.selectionStyle = .none
            return cell
            
        case 4:
            let cell = tableView.dequeueReusableCell(withIdentifier: "InputCell", for: indexPath) as! InputCell
            cell.configure(with: "Недостатки", indexPath: indexPath, returnKeyType: .next)
            cell.delegate = self
            tableView.separatorStyle = .none
            cell.selectionStyle = .none
            return cell
            
        case 5:
            let cell = tableView.dequeueReusableCell(withIdentifier: "InputCell", for: indexPath) as! InputCell
            cell.configure(with: "Комментарий", indexPath: indexPath, returnKeyType: .done)
            cell.delegate = self
            tableView.separatorStyle = .none
            cell.selectionStyle = .none
            return cell
            
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "SendReviewCell", for: indexPath) as! SendReviewCell
            tableView.separatorStyle = .none
            cell.selectionStyle = .none
            return cell
        }
    }
    
    func didPressReturn(in indexPath: IndexPath) {
        let nextRow = indexPath.row + 1
        if nextRow < tableView.numberOfRows(inSection: indexPath.section),
           let nextCell = tableView.cellForRow(at: IndexPath(row: nextRow, section: indexPath.section)) as? InputCell {
            nextCell.becomeTextFieldFirstResponder() 
        } else {
            view.endEditing(true)
        }
    }
}
