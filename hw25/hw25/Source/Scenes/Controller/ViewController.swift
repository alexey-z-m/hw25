import UIKit
import SnapKit
import Alamofire

class ViewController: UIViewController {
    
    let tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.register(TableViewCell.self, forCellReuseIdentifier: TableViewCell.identifier)
        return table
    }()
    
    let textField: UITextField = {
       let field = UITextField()
        field.placeholder = "Введите название карты"
        field.borderStyle = .roundedRect
        return field
    }()
    
    let button: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "magnifyingglass.circle.fill"), for: .normal)
        button.addTarget(self, action: #selector(search), for: .touchUpInside)
        return button
    }()
    
    @objc func search(){
        fetchSeries(name: textField.text ?? "")
    }
    
    var cards: [Card] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchSeries(name: "")
        tableView.dataSource = self
        tableView.delegate = self
        view.addSubview(textField)
        view.addSubview(button)
        view.addSubview(tableView)
        textField.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(50)
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-50)
            make.height.equalTo(50)
        }
        button.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(60)
            make.right.equalToSuperview().offset(-10)
        }
        tableView.snp.makeConstraints { make in
            make.top.equalTo(textField.snp.bottom).offset(10)
            make.left.right.bottom.equalToSuperview()
        }
    }
    
    func alert(_ name: String) {
        let alert = UIAlertController(title: "Карта не найдена", message: "Не получилось найти карту с именем \"\(name)\".", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func fetchSeries(name: String) {
        var searchName = name.replacingOccurrences(of: " ", with: "%20")
        if name != "" {
            searchName = "?name=" + searchName
        }
        let requestUrl = "https://api.magicthegathering.io/v1/cards" + searchName
        print(requestUrl)
        let request = AF.request(requestUrl)
        request.responseDecodable(of: Cards.self) { (data) in
            guard let result = data.value else {
                self.alert(name)
                return
            }
            if result.cards.count == 0 {
                self.alert(name)
            }
            let cards = result.cards
            self.cards = cards
            self.tableView.reloadData()
        }
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cards.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.identifier, for: indexPath) as? TableViewCell
        else {
            return UITableViewCell()
        }
        cell.card = cards[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
       return "результаты:"
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let cardDetail = CardViewController()
        cardDetail.card = cards[indexPath.row]
        present(cardDetail, animated: true)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
}

struct Cards: Decodable {
    let cards: [Card]
}

struct Card: Decodable {
    let nameCard: String
    let type: String?
    let manaCost: String?
    let rarity: String?
    let setName: String?
    let description: String?
    let imageUrl: String?
    let foreignNames: [ForeignNames]?
    
    enum CodingKeys: String, CodingKey {
        case nameCard = "name"
        case type
        case manaCost
        case rarity
        case setName
        case description = "text"
        case imageUrl
        case foreignNames
    }
}
struct ForeignNames: Decodable {
    let name: String?
    let text: String?
    let type: String?
    let imageUrl: String?
    let language: String?
}

