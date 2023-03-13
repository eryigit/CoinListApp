

import UIKit

class TabBarVC: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        let coinListVC = CoinListVC()
        let favoriteVC = FavoriteVC()
        setViewControllers([coinListVC, favoriteVC], animated: true)
        coinListVC.title = "Coin List"
        favoriteVC.title = "Favorite"
        self.tabBar.tintColor = .blue
        self.tabBar.backgroundColor = .white
        let images = ["bitcoinsign.square", "heart"]
        guard let items = self.tabBar.items else { return }
        for x in 0...1 {
            items[x].image = UIImage(systemName: images[x])
        }
    }
    


}
