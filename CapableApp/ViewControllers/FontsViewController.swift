//
//  FontsViewController.swift
//  CapableApp
//
//  Created by Christoph Wendt on 31.03.18.
//

import UIKit
import Capable

class FontsController: UITableViewController {
    struct Constants {
        static let defaultFontSize: CGFloat = 17.0
        static let customFontName: String = "Cardo-Regular"
        static let fontsList: [(font: UIFont, description: String)] = [
            (
                font: UIFont.systemFont(ofSize: defaultFontSize),
                description: "System Font"
            ),
            (
                font: UIFont(name: customFontName, size: 17.0)!,
                description: "Custom Font"
            ),
            (
                font: UIFont.scaledFont(for: UIFont(name: customFontName, size: defaultFontSize)!),
                description: "Scaled Custom Font"
            ),
            (
                font: UIFont.scaledSystemFont(ofSize: defaultFontSize),
                description: "Scaled System Font"
            ),
            (
                font: UIFont.scaledBoldSystemFont(ofSize: defaultFontSize),
                description: "Scaled Bold System Font"
            ),
            (
                font: UIFont.scaledItalicSystemFont(ofSize: defaultFontSize),
                description: "Scaled Italic System Font"
            )
        ]
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Constants.fontsList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let row = indexPath.row
        
        cell.textLabel!.text = "This is a sample text"
        cell.textLabel?.font = Constants.fontsList[row].font
        cell.textLabel?.adjustsFontForContentSizeCategory = true
        cell.textLabel?.lineBreakMode = .byWordWrapping
        cell.textLabel?.numberOfLines = 0
        
        cell.detailTextLabel!.text = Constants.fontsList[row].description
        cell.detailTextLabel!.font = UIFont.preferredFont(forTextStyle: .caption2)
            
        return cell
    }
}
