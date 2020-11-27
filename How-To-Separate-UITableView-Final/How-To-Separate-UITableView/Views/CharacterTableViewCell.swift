//
//  CharacterTableViewCell.swift
//  How-To-Separate-UITableView
//
//  Created by Thomas Kellough on 11/27/20.
//

import UIKit

class CharacterTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setUp(with character: Character) {
        textLabel?.text = character.name
        textLabel?.font = UIFont.preferredFont(forTextStyle: .title1)
        
        detailTextLabel?.text = character.house
        detailTextLabel?.font = UIFont.preferredFont(forTextStyle: .title3)
        
        if let image = UIImage(named: character.house.lowercased()) {
            imageView?.image = image
        }
        
        switch character.house.lowercased() {
        case "stark":
            backgroundColor = UIColor(red: 128/255, green: 128/255, blue: 128/255, alpha: 1)
        case "tyrell":
            backgroundColor = UIColor(red: 144/255, green: 158/255, blue: 131/255, alpha: 1)
        case "targaryen":
            backgroundColor = UIColor(red: 155/255, green: 44/255, blue: 41/255, alpha: 1)
        case "martell":
            backgroundColor = UIColor(red: 227/255, green: 138/255, blue: 75/255, alpha: 1)
        default:
            break
        }
    }

}
