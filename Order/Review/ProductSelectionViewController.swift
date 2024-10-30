import UIKit

class ProductSelectionViewController: UIViewController {
    
    private let tableView = UITableView()
    private let viewModel = ProductSelectionViewModel() 
    
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
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    
    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(ProductCell.self, forCellReuseIdentifier: "ProductCell")
    }
}

extension ProductSelectionViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfProducts
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProductCell", for: indexPath) as! ProductCell

        if let product = viewModel.product(at: indexPath.row) {
            cell.configure(with: product)
        }

        tableView.separatorStyle = .none
        return cell
    }

}

extension ProductSelectionViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let selectedProduct = viewModel.product(at: indexPath.row) {
            let reviewViewController = ProductReviewViewController(product: selectedProduct)
            navigationController?.pushViewController(reviewViewController, animated: true)
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

