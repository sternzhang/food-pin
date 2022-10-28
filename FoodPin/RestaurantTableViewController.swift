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
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func configureDataSource() -> UITableViewDiffableDataSource<Section, String> {
        let cellIdentifier = "datacell"
        let dataSource = UITableViewDiffableDataSource<Section, String>(
            tableView: tableView, cellProvider: {tableView, IndexPath, restaurantName in
                let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: IndexPath)
                cell.textLabel?.text = restaurantName
                cell.imageView?.image = UIImage(named: "restaurant")
                
                return cell
            }
        )
        return dataSource
    }

}
