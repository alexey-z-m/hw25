//
//  TableViewCell.swift
//  hw25
//
//  Created by Panda on 04.08.2022.
//

import UIKit

class TableViewCell: UITableViewCell {
    static let identifier = "TableViewCell"
    
    private let role: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        return label
    }()
    
    private let name: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        return label
    }()
    
    private let cardImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
       // imageView.layer.masksToBounds = true
        
        return imageView
    }()
    
    var card: Card? {
        didSet {
            role.text = card?.type
            name.text = card?.nameCard
            
            guard let imagePath = card?.imageUrl,
                    let imageURL = URL(string: imagePath),
                    let imageData = try? Data(contentsOf: imageURL)
            else {
                cardImage.image = UIImage(systemName: "photo")
                return
            }
            cardImage.image = UIImage(data: imageData)
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(role)
        contentView.addSubview(name)
        contentView.addSubview(cardImage)
        name.snp.makeConstraints { make in
            make.left.top.equalToSuperview().offset(10)
        }
        cardImage.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.width.equalTo(40)
            make.right.equalToSuperview().offset(-35)
        }
        role.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-10)
            make.left.equalToSuperview().offset(10)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
