//
//  FontsViewController.swift
//  Example
//
//  Created by Christoph Wendt on 31.03.18.
//

import UIKit
import Foundation
import Capable

class FontsController: UITableViewController {

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return FontsConstants.fontsList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let row = indexPath.row
        
        cell.textLabel!.text = FontsConstants.defaultText
        cell.textLabel?.font = FontsConstants.fontsList[row].font
        cell.textLabel?.adjustsFontForContentSizeCategory = true
        cell.textLabel?.lineBreakMode = .byWordWrapping
        cell.textLabel?.numberOfLines = 0
        
        cell.detailTextLabel!.text = FontsConstants.fontsList[row].description
        cell.detailTextLabel!.font = UIFont.preferredFont(forTextStyle: .caption2)
            
        return cell
    }
}
