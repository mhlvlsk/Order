import UIKit

class SendReviewCell: UITableViewCell {

    private let checkboxButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "checkboxE"), for: .normal)
        button.setImage(UIImage(named: "checkboxF"), for: .selected)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let anonymousLabel: UILabel = {
        let label = UILabel()
        label.text = "Оставить отзыв анонимно"
        label.font = UIFont.systemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let submitButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Отправить", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        button.backgroundColor = UIColor(red: 1, green: 0.275, blue: 0.067, alpha: 1)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let rulesLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0

        let text = "Перед отправкой отзыва, пожажуйста,\nознакомьтесь с "
        let boldText = "правилами публикации"
        
        let attributedString = NSMutableAttributedString(string: text, attributes: [
            .font: UIFont.systemFont(ofSize: 11, weight: .regular),
            .foregroundColor: UIColor.gray
        ])
        
        let boldAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 11, weight: .regular),
            .foregroundColor: UIColor(red: 1, green: 0.275, blue: 0.067, alpha: 1)
        ]
        
        attributedString.append(NSAttributedString(string: boldText, attributes: boldAttributes))
        label.attributedText = attributedString
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        contentView.addSubview(checkboxButton)
        contentView.addSubview(anonymousLabel)
        contentView.addSubview(submitButton)
        contentView.addSubview(rulesLabel)
                
        NSLayoutConstraint.activate([
            checkboxButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            checkboxButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 30),
            
            anonymousLabel.leadingAnchor.constraint(equalTo: checkboxButton.trailingAnchor, constant: 10),
            anonymousLabel.centerYAnchor.constraint(equalTo: checkboxButton.centerYAnchor),
            
            submitButton.topAnchor.constraint(equalTo: anonymousLabel.bottomAnchor, constant: 20),
            submitButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            submitButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            submitButton.centerXAnchor.constraint(equalTo:contentView.centerXAnchor),
            submitButton.widthAnchor.constraint(equalToConstant: 343),
            submitButton.heightAnchor.constraint(equalToConstant: 54),
            
            rulesLabel.topAnchor.constraint(equalTo: submitButton.bottomAnchor, constant: 10),
            rulesLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            rulesLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
        ])
        
        submitButton.addTarget(self, action: #selector(submitButtonTapped), for: .touchUpInside)
        checkboxButton.addTarget(self, action: #selector(checkboxTapped), for: .touchUpInside)
    }
    
    @objc private func submitButtonTapped() {
        let buttonsClicks = ButtonsClicks()
        buttonsClicks.buttonAnimate(button:submitButton)
    }
    
    @objc private func checkboxTapped() {
        checkboxButton.isSelected.toggle()
    }
}

