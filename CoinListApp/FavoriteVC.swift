

import UIKit

class FavoriteVC: UIViewController {
    var favList = [CoinDetails]()
    
        let favTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(TableViewCell.self, forCellReuseIdentifier: TableViewCell.identifier)
        return tableView
    }()

    private func setNavigationBar() {
         let navBar = UINavigationBar(frame: CGRect(x: 0, y: 55, width: self.view.frame.width, height: 44))
         navBar.barTintColor = .white
         let navItem = UINavigationItem(title: "Favorite Coins")
         let doneItem = UIBarButtonItem(image: UIImage(systemName: "line.horizontal.3"), style: .plain, target: self, action: #selector(editButton))
         navItem.rightBarButtonItem = doneItem
         navBar.setItems([navItem], animated: false)
         self.view.addSubview(navBar)
     }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        self.favTableView.delegate = self
        self.favTableView.dataSource = self
        setNavigationBar()
        configureTableView()
    }

    @objc func editButton() {
        favTableView.setEditing(!favTableView.isEditing, animated: true)
    }
    
    private func configureTableView() {
        view.addSubview(favTableView)
        NSLayoutConstraint.activate([
            favTableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            favTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            favTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            favTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
}

extension FavoriteVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favList.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = favTableView.dequeueReusableCell(withIdentifier: TableViewCell.identifier, for: indexPath) as! TableViewCell
        cell.textLabel?.text = favList[indexPath.row].coinName
        cell.priceLabel.text = favList[indexPath.row].coinPrice
        cell.priceChangeLabel.text = favList[indexPath.row].coinChangePrice
        if self.favList[indexPath.row].intCoin < 0.0 {
            cell.priceChangeLabel.backgroundColor = .systemRed
            return cell
            } else {
                cell.priceChangeLabel.backgroundColor = .systemGreen
                return cell
            }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { _, _, completionHandler in
            completionHandler(true)
            self.favList.remove(at: indexPath.row)
            tableView.reloadData()
        }
        deleteAction.image = UIImage(systemName: "trash")
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let movedFavList = favList.remove(at: sourceIndexPath.row)
        favList.insert(movedFavList, at: destinationIndexPath.row)
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .none
    }
    
    
}
