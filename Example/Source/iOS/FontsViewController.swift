//
//  FontsViewController.swift
//  Example
//
//  Created by Christoph Wendt on 31.03.18.
//

import Capable
import Foundation
import UIKit

class FontsController: UITableViewController {
    override func numberOfSections(in _: UITableView) -> Int {
        return 1
    }

    override func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
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
        cell.detailTextLabel!.font = UIFont.systemFont(ofSize: 13.0)

        return cell
    }
}
