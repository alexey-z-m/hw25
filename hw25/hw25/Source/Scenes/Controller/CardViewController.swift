//
//  CardViewController.swift
//  hw25
//
//  Created by Panda on 05.08.2022.
//

import UIKit

class CardViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupHierarchy()
        setupLayout()
        // Do any additional setup after loading the view.
    }
    
    private let typeCrad: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        return label
    }()
    
    private let titleNameCard: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 40, weight: .bold)
        label.textAlignment = .center
        return label
    }()
    
    private let nameCard: UILabel = {
        let label = UILabel()
        return label
    }()
    
    private let descriptionCard: UILabel = {
        let label = UILabel()
        return label
    }()
    
    private let cardImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .systemGray5
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 20
        
        return imageView
    }()
    
    var card: Card? {
        didSet {
            typeCrad.text = card?.type
            titleNameCard.text = card?.nameCard
            setImage(cardImage, source: card?.imageUrl)
            nameCard.text = card?.nameCard
            descriptionCard.text = card?.description
            for i in 0..<(card?.foreignNames?.count ?? 0) {
                if card?.foreignNames?[i].language == "Russian" {
                    nameCard.text = card?.foreignNames?[i].name ?? ""
                    setImage(cardImage, source: card?.foreignNames?[i].imageUrl)
                    descriptionCard.text = card?.foreignNames?[i].text ?? ""
                }
            }            
        }
    }
    
    func setImage(_ imageUI: UIImageView, source: String?) {
        guard let imagePath = source,
                let imageURL = URL(string: imagePath),
                let imageData = try? Data(contentsOf: imageURL)
        else {
            imageUI.image = UIImage(systemName: "photo")
            return
        }
        imageUI.image = UIImage(data: imageData)
    }
    
    func setupHierarchy() {
        view.addSubview(typeCrad)
        view.addSubview(titleNameCard)
        view.addSubview(cardImage)
        view.addSubview(nameCard)
        view.addSubview(descriptionCard)
    }
    
    func setupLayout() {
        titleNameCard.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(30)
            make.left.right.equalToSuperview()
        }
        cardImage.snp.makeConstraints { make in
            make.top.equalTo(titleNameCard.snp.bottom).offset(30)
            make.left.right.equalToSuperview()
            make.height.equalTo(300)
        }
        nameCard.snp.makeConstraints { make in
            make.top.equalTo(cardImage.snp.bottom).offset(30)
        }
        descriptionCard.snp.makeConstraints { make in
            make.top.equalTo(nameCard.snp.bottom).offset(5)
        }
    }
}
