import UIKit

class RatingCell: UITableViewCell {
    
    private let ratingLabel: UILabel = {
        let label = UILabel()
        label.text = "Ваша оценка"
        label.textColor = .gray
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var starButtons: [UIButton] = []
    private let starCount = 5
    private var selectedRating: Int = 0 {
        didSet {
            updateRatingUI()
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        let container = UIView()
        container.layer.cornerRadius = 12
        container.backgroundColor = UIColor(white: 0.95, alpha: 1)
        container.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(container)

        NSLayoutConstraint.activate([
            container.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            container.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            container.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            container.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            container.heightAnchor.constraint(equalToConstant: 54)
        ])

        container.addSubview(ratingLabel)
        
        for i in 0..<starCount {
            let button = UIButton(type: .custom)
            button.setImage(UIImage(named: "customStarE"), for: .normal)
            button.tag = i + 1
            button.addTarget(self, action: #selector(starTapped(_:)), for: .touchUpInside)
            button.translatesAutoresizingMaskIntoConstraints = false
            starButtons.append(button)
            container.addSubview(button)
        }
        
        NSLayoutConstraint.activate([
            ratingLabel.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 20),
            ratingLabel.centerYAnchor.constraint(equalTo: container.centerYAnchor),
            
            starButtons[4].trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -20),
            starButtons[0].centerYAnchor.constraint(equalTo: container.centerYAnchor),
        ])
        
        for i in 1..<starCount {
            NSLayoutConstraint.activate([
                starButtons[i].leadingAnchor.constraint(equalTo: starButtons[i - 1].trailingAnchor, constant: 5),
                starButtons[i].centerYAnchor.constraint(equalTo: container.centerYAnchor)
            ])
        }
    }
    
    @objc private func starTapped(_ sender: UIButton) {
        selectedRating = sender.tag
    }
    
    private func updateRatingUI() {
        for i in 0..<starCount {
            if i < selectedRating {
                starButtons[i].setImage(UIImage(named: "customStarF"), for: .normal)
            } else {
                starButtons[i].setImage(UIImage(named: "customStarE"), for: .normal)
            }
        }
        
        switch selectedRating {
        case 1:
            ratingLabel.text = "Ужасно"
        case 2:
            ratingLabel.text = "Плохо"
        case 3:
            ratingLabel.text = "Нормально"
        case 4:
            ratingLabel.text = "Хорошо"
        case 5:
            ratingLabel.text = "Отлично"
        default:
            ratingLabel.text = "Ваша оценка"
            ratingLabel.textColor = .gray
            return
        }
        ratingLabel.textColor = .black
    }
}
