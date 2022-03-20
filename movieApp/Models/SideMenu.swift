//
//  SideMenu.swift
//  movieApp
//
//  Created by Mustafa on 24.02.2022.
//

import Foundation
import UIKit

protocol MenuControllerDelegate {
    func didSelectMenuItem(named: String)
}
				
class MenuController: UITableViewController {
    
    var delegate: MenuControllerDelegate?
    
    private let menuItems: [String]
    
    init(with menuItems: [String]) {
        self.menuItems = menuItems
        super.init(nibName: nil, bundle: nil)
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.backgroundColor =  #colorLiteral(red: 0.8669999838, green: 0.8669999838, blue: 0.8669999838, alpha: 1)
        view.backgroundColor =  #colorLiteral(red: 0.8669999838, green: 0.8669999838, blue: 0.8669999838, alpha: 1)
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuItems.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.textLabel?.text = menuItems[indexPath.row]
        cell.textLabel?.textColor = K.Colors.textColor
        cell.contentView.backgroundColor =  #colorLiteral(red: 0.8669999838, green: 0.8669999838, blue: 0.8669999838, alpha: 1)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        //Relay to delegate about menu item selection.
        let selectedItem = menuItems[indexPath.row]
        delegate?.didSelectMenuItem(named: selectedItem)
    }
}
