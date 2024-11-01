import UIKit

class PhotoCollectionCell: UITableViewCell, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var images: [UIImage] = [] {
        didSet {
            collectionView.reloadData()
        }
    }
        
    private let maxImages = 7
    private let itemsPerRow: CGFloat = 4
    private let itemSpacing: CGFloat = 8
    private var deletedImages: [UIImage] = []
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 8
        layout.minimumLineSpacing = 8
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .clear
        return collectionView
    }()
    
    private let addImageButton: UIButton = {
        let button = UIButton(type: .custom)
        
        let cloudImage = UIImage(named: "cloud")
        
        var configuration = UIButton.Configuration.filled()
        configuration.image = cloudImage
        configuration.imagePlacement = .leading
        configuration.imagePadding = 15
        configuration.baseBackgroundColor = UIColor(white: 0.95, alpha: 1)
        
        var title = AttributedString("Добавьте фото или видео")
        title.foregroundColor = UIColor(.black)
        title.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        
        var subtitle = AttributedString("Нажмите, чтобы выбирать файлы")
        subtitle.foregroundColor = UIColor(.gray)
        subtitle.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        
        configuration.attributedTitle = title
        configuration.attributedSubtitle = subtitle
        
        button.configuration = configuration
        button.layer.cornerRadius = 10
        button.translatesAutoresizingMaskIntoConstraints = false
        
        button.contentHorizontalAlignment = .left
        
        return button
    }()
    
    private let smallAddImageButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "cloud"), for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        button.backgroundColor = UIColor(white: 0.95, alpha: 1)
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCollectionView()
        setupAddImageButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupCollectionView() {
        contentView.addSubview(collectionView)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "ImageCell")
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            collectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            collectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            collectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            collectionView.heightAnchor.constraint(equalToConstant: 100)
        ])
    }
    
    private func setupAddImageButton() {
        contentView.addSubview(addImageButton)
        addImageButton.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            addImageButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            addImageButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            addImageButton.widthAnchor.constraint(equalToConstant: 350),
            addImageButton.heightAnchor.constraint(equalToConstant: 80),
        ])
        
        addImageButton.isHidden = !images.isEmpty
    }
    
    @objc private func addButtonTapped() {
        if !deletedImages.isEmpty {
            let newImage = deletedImages.removeFirst()
            addImage(newImage)
        } else if images.count < maxImages {
            let newImage = UIImage(named: "photo\(images.count + 1)")!
            addImage(newImage)
        }
        
        addImageButton.isHidden = true
    }
    
    private func addImage(_ image: UIImage) {
        images.append(image)
        
        collectionView.reloadData()
        
        if let tableView = self.superview as? UITableView {
            tableView.beginUpdates()
            tableView.endUpdates()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count < maxImages ? images.count + 1 : maxImages
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCell", for: indexPath)
        
        cell.contentView.subviews.forEach { $0.removeFromSuperview() }
        
        if indexPath.item < images.count {
            let imageView = UIImageView(image: images[indexPath.item])
            imageView.contentMode = .scaleAspectFill
            imageView.layer.cornerRadius = 8
            imageView.clipsToBounds = true
            imageView.translatesAutoresizingMaskIntoConstraints = false
            cell.contentView.addSubview(imageView)
            
            NSLayoutConstraint.activate([
                imageView.topAnchor.constraint(equalTo: cell.contentView.topAnchor),
                imageView.leadingAnchor.constraint(equalTo: cell.contentView.leadingAnchor),
                imageView.trailingAnchor.constraint(equalTo: cell.contentView.trailingAnchor),
                imageView.bottomAnchor.constraint(equalTo: cell.contentView.bottomAnchor)
            ])
            
            let deleteButton = UIButton(type: .custom)
            deleteButton.setImage(UIImage(systemName: "xmark"), for: .normal)
            deleteButton.tintColor = .white
            deleteButton.translatesAutoresizingMaskIntoConstraints = false
            
            cell.contentView.addSubview(deleteButton)
            deleteButton.addTarget(self, action: #selector(deleteImageTapped(_:)), for: .touchUpInside)
            deleteButton.tag = indexPath.item
            
            NSLayoutConstraint.activate([
                deleteButton.trailingAnchor.constraint(equalTo: cell.contentView.trailingAnchor, constant: -1),
                deleteButton.topAnchor.constraint(equalTo: cell.contentView.topAnchor, constant: 1),
                deleteButton.widthAnchor.constraint(equalToConstant: 30),
                deleteButton.heightAnchor.constraint(equalToConstant: 30)
            ])
            
        } else if images.count < maxImages {
            smallAddImageButton.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
            cell.contentView.addSubview(smallAddImageButton)
            NSLayoutConstraint.activate([
                smallAddImageButton.centerXAnchor.constraint(equalTo: cell.contentView.centerXAnchor),
                smallAddImageButton.centerYAnchor.constraint(equalTo: cell.contentView.centerYAnchor),
                smallAddImageButton.widthAnchor.constraint(equalToConstant: 80),
                smallAddImageButton.heightAnchor.constraint(equalToConstant: 80)
            ])
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.item == images.count {
            addButtonTapped()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let totalSpacing = (itemsPerRow - 1) * itemSpacing
        let itemWidth = (collectionView.bounds.width - totalSpacing) / itemsPerRow
        return CGSize(width: itemWidth, height: 80)
    }
    
    @objc private func deleteImageTapped(_ sender: UIButton) {
        let index = sender.tag
        let deletedImage = images.remove(at: index)
        deletedImages.append(deletedImage)
        collectionView.reloadData()
        
        if images.isEmpty {
            addImageButton.isHidden = false
        } else {
            addImageButton.isHidden = true
        }
        
        if let tableView = self.superview as? UITableView {
            tableView.beginUpdates()
            tableView.endUpdates()
        }
    }
}
