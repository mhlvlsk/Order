import UIKit

class InputCell: UITableViewCell, UITextFieldDelegate {

    private let textField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .none
        textField.backgroundColor = .clear
        textField.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private let container: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 12
        view.backgroundColor = UIColor(white: 0.95, alpha: 1)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    weak var delegate: InputCellDelegate?
    var indexPath: IndexPath?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        contentView.addSubview(container)
        container.addSubview(textField)

        NSLayoutConstraint.activate([
            container.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            container.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            container.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            container.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            container.heightAnchor.constraint(equalToConstant: 54),

            textField.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 16),
            textField.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -16),
            textField.topAnchor.constraint(equalTo: container.topAnchor, constant: 12),
            textField.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -12)
        ])
    }
    
    func configure(with placeholder: String, indexPath: IndexPath, returnKeyType: UIReturnKeyType) {
        textField.placeholder = placeholder
        textField.returnKeyType = returnKeyType
        textField.delegate = self
        self.indexPath = indexPath
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let indexPath = indexPath {
            delegate?.didPressReturn(in: indexPath)
        }
        return false 
    }
    
    func becomeTextFieldFirstResponder() {
        textField.becomeFirstResponder() 
    }
}

protocol InputCellDelegate: AnyObject {
    func didPressReturn(in indexPath: IndexPath)
}
