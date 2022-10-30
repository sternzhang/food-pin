//
//  RestaurantTableViewController.swift
//  FoodPin
//
//  Created by 张世强 on 2022/10/28.
//

import UIKit

enum Section {
    case all
}

class RestaurantTableViewController: UITableViewController {
    var restaurantNames = ["Cafe Deadend", "Homei", "Teakha", "Cafe Loisl", "P etite Oyster", "For Kee Restaurant", "Po's Atelier", "Bourke Street Bakery" , "Haigh's Chocolate", "Palomino Espresso", "Upstate", "Traif", "Graham Av enue Meats", "Waffle & Wolf", "Five Leaves", "Cafe Lore", "Confessional", "Barrafina", "Donostia", "Royal Oak", "CASK Pub and Kitchen"]
    var restaurantImages = ["cafedeadend", "homei", "teakha", "cafeloisl", "petiteoyster", "forkee", "posatelier", "bourkestreetbakery", "haigh", "palomino", "upstate", "traif", "graham", "waffleandwolf", "fiveleaves", "cafelore", "confessional", "barrafina", "donostia", "royaloak", "cask"]
    var restaurantLocations = ["Hong Kong", "Hong Kong", "Hong Kong", "Hong Ko ng", "Hong Kong", "Hong Kong", "Hong Kong", "Sydney", "Sydney", "Sydney", "New York", "New York", "New York", "New York", "New York", "New York", "N ew York", "London", "London", "London", "London"]
    var restaurantTypes = ["Coffee & Tea Shop", "Cafe", "Tea House", "Austrian / Causual Drink", "French", "Bakery", "Bakery", "Chocolate", "Cafe", "Ame rican / Seafood", "American", "American", "Breakfast & Brunch", "Coffee & Tea", "Coffee & Tea", "Latin American", "Spanish", "Spanish", "Spanish", " British", "Thai"]
    var restaurantIsFavorites = Array(repeating: false, count: 21)
    
    lazy var dataSource = configureDataSource()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.cellLayoutMarginsFollowReadableWidth = true
//        tableView.separatorStyle = .none
        tableView.dataSource = dataSource
        var snapshot = NSDiffableDataSourceSnapshot<Section, String>()
        snapshot.appendSections([.all])
        snapshot.appendItems(restaurantNames, toSection: .all)
        
        dataSource.apply(snapshot, animatingDifferences: false)
    }
    
    func configureDataSource() -> UITableViewDiffableDataSource<Section, String> {
        let cellIdentifier = "favoritecell"
        let dataSource = UITableViewDiffableDataSource<Section, String>(
            tableView: tableView, cellProvider: {tableView, indexPath, restaurantName in
                let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! RestaurantTableViewCell
                cell.nameLabel.text = restaurantName
                cell.locationLabel.text = self.restaurantLocations[indexPath.row]
                cell.typeLabel.text = self.restaurantTypes[indexPath.row]
                cell.thumbnailImageView.image = UIImage(named: self.restaurantImages[indexPath.row])
                cell.heartImageView.image = UIImage(systemName: "heart.fill" )
                cell.heartImageView.isHidden = self.restaurantIsFavorites[indexPath.row] ? false : true
//                cell.accessoryType = self.restaurantIsFavorites[indexPath.row] ? .checkmark : .none
                return cell
            }
        )
        return dataSource
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let optionMenu = UIAlertController(title: nil, message: "What do you want to do?", preferredStyle: .actionSheet)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        optionMenu.addAction(cancelAction)
        
        let reserveActionHandler = {(action: UIAlertAction!) -> Void in
            let alertMessage = UIAlertController(title: "Not available yet", message: "Sorry, this feature is not available yet. Please retry later.", preferredStyle: .alert)
            alertMessage.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            self.present(alertMessage, animated: true, completion: nil)
        }
        
        let reserveAction = UIAlertAction(title: "Reserve a table", style: .default, handler: reserveActionHandler)
        optionMenu.addAction(reserveAction)
        
        let favoriteAction = UIAlertAction(title: self.restaurantIsFavorites[indexPath.row] ? "Remove from favorite": "Mark as favorite", style: .default, handler: {
            (action: UIAlertAction!) -> Void in
            self.restaurantIsFavorites[indexPath.row] = !self.restaurantIsFavorites[indexPath.row]
            let cell = tableView.cellForRow(at: indexPath) as? RestaurantTableViewCell
//            cell?.accessoryType = self.restaurantIsFavorites[indexPath.row] ? .checkmark : .none
            cell?.heartImageView.isHidden = self.restaurantIsFavorites[indexPath.row] ? false : true
            cell?.tintColor = .systemYellow
        })
        optionMenu.addAction(favoriteAction)
        present(optionMenu, animated: true, completion: nil)
        tableView.deselectRow(at: indexPath, animated: false)
    }

}
