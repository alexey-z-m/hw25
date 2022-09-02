//
//  TableViewCell.swift
//  hw25
//
//  Created by Panda on 04.08.2022.
//

import UIKit

class TableViewCell: UITableViewCell {
    static let identifier = "TableViewCell"
    
    private let typeCard: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        return label
    }()
    
    private let nameCard: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        return label
    }()
    
    private let cardImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    var card: Card? {
        didSet {
            typeCard.text = card?.type
            nameCard.text = card?.nameCard
            setImage(cardImage, source: card?.imageUrl)
        }
    }
    
    func setImage(_ imageUI: UIImageView, source: String?) {
        let queue = DispatchQueue(label: "loadImages", qos: .background)
        queue.async {
            guard let imagePath = source,
                  let imageURL = URL(string: imagePath),
                  let imageData = try? Data(contentsOf: imageURL)
            else {
                DispatchQueue.main.async {
                    imageUI.image = UIImage(systemName: "photo")
                }
                return
            }
            DispatchQueue.main.async {
                imageUI.image = UIImage(data: imageData)
            }
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupHierarchy()
        setupLayout()
    }
    
    func setupHierarchy() {
        contentView.addSubview(typeCard)
        contentView.addSubview(nameCard)
        contentView.addSubview(cardImage)
    }
    
    func setupLayout() {
        nameCard.snp.makeConstraints { make in
            make.left.top.equalToSuperview().offset(10)
        }
        cardImage.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.width.equalTo(40)
            make.right.equalToSuperview().offset(-35)
        }
        typeCard.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-10)
            make.left.equalToSuperview().offset(10)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
