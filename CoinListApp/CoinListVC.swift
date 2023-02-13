
import UIKit
import Alamofire
import CoreData

class CoinListVC: UIViewController {
    
    var coinList = [CoinDetails]()

    private let tableView: UITableView = {
       let tableView = UITableView()
        tableView.backgroundColor = .systemBackground
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.allowsSelection = true
        tableView.register(TableViewCell.self, forCellReuseIdentifier: TableViewCell.identifier)
       return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        tableView.delegate = self
        tableView.dataSource = self
        
        configureTableView()
        getCoinDetails()
        Timer.scheduledTimer(timeInterval: 10.0, target: self, selector: #selector(timerRefresh), userInfo: nil, repeats: true)

    }
    
    @objc func timerRefresh() {
        getCoinDetails()
        coinList.removeAll()
    }
    
    private func getCoinDetails() {
        AF.request("https://api.coincap.io/v2/assets", method: .get).response { [self] response in
            guard let data = response.data else { return }
            do {
                let jsonResponse =  try JSONSerialization.jsonObject(with: data) as? [String:Any]
                let jsonData = jsonResponse!["data"] as? [[String:Any]]
                for x in 0...99 {
                    let coinName = jsonData![x]["name"] as? String
                    let coinPrice = jsonData![x]["priceUsd"] as? String
                    let coinPriceChange = jsonData![x]["changePercent24Hr"] as? String
                    
                    let newChange = Double(coinPriceChange!)
                    let newChangePrice = String(Double(Int(Double(coinPriceChange!)! * 100)) / 100.0)
                    let newPrice = String(Double(Int(Double(coinPrice!)! * 100)) / 100.0)
                 
                    let eachCoin = CoinDetails(coinName: coinName!, coinPrice: newPrice, coinChangePrice: newChangePrice, intCoin: newChange!)
                    coinList.append(eachCoin)

                }
               
            }catch {
                print(error.localizedDescription)
            }
            tableView.reloadData()
            tableView.setContentOffset(tableView.contentOffset, animated: false)
        }
    }
    
    
    private func configureTableView() {
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

extension CoinListVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return coinList.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.identifier) as? TableViewCell
        cell?.textLabel?.text = coinList[indexPath.row].coinName
        cell?.priceLabel.text = coinList[indexPath.row].coinPrice
        cell?.priceChangeLabel.text = "\(coinList[indexPath.row].coinChangePrice)\(" %")"
    
        if self.coinList[indexPath.row].intCoin < 0.0 {
            cell?.priceChangeLabel.backgroundColor = .systemRed
                return cell!
            } else {
                cell?.priceChangeLabel.backgroundColor = .systemGreen
                return cell!
            }
    }
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let favAction = UIContextualAction(style: .normal, title: "Add") { [self] _, _,completionHandler in
            completionHandler(true)
            let favVC = tabBarController?.viewControllers![1] as! FavoriteVC
            favVC.favList.append(coinList[indexPath.row])
            favVC.favTableView.reloadData()
        }
        favAction.image = UIImage(systemName: "heart")
        return UISwipeActionsConfiguration(actions: [favAction])
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
}
