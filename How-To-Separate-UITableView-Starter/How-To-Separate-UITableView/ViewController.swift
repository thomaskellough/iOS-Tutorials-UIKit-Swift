//
//  ViewController.swift
//  How-To-Separate-UITableView
//
//  Created by Thomas Kellough on 11/27/20.
//

import UIKit

class ViewController: UITableViewController {
    
    var characters: [Character] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let ned = Character(name: "Ned Stark", house: "Stark")
        let arya = Character(name: "Arya Stark", house: "Stark")
        let daenerys = Character(name: "Daenerys Targaryen", house: "Targaryen")
        let rhaegar = Character(name: "Rhaegar Targaryen", house: "Targaryen")
        let obern = Character(name: "Obern Martell", house: "Martell")
        let doran = Character(name: "Doran Martell", house: "Martell")
        let olenna = Character(name: "Olenna Tyrell", house: "Tyrell")
        let mace = Character(name: "Mace Tyrell", house: "Tyrell")
        
        characters = [ned, arya, daenerys, rhaegar, obern, doran, olenna, mace].sorted(by: { $0.name < $1.name })
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let character = characters[indexPath.row]
        
        cell.textLabel?.text = character.name
        cell.textLabel?.font = UIFont.preferredFont(forTextStyle: .title1)
        
        cell.detailTextLabel?.text = character.house
        cell.detailTextLabel?.font = UIFont.preferredFont(forTextStyle: .title3)
        
        if let image = UIImage(named: character.house.lowercased()) {
            cell.imageView?.image = image
        }
        
        switch character.house.lowercased() {
        case "stark":
            cell.backgroundColor = UIColor(red: 128/255, green: 128/255, blue: 128/255, alpha: 1)
        case "tyrell":
            cell.backgroundColor = UIColor(red: 144/255, green: 158/255, blue: 131/255, alpha: 1)
        case "targaryen":
            cell.backgroundColor = UIColor(red: 155/255, green: 44/255, blue: 41/255, alpha: 1)
        case "martell":
            cell.backgroundColor = UIColor(red: 227/255, green: 138/255, blue: 75/255, alpha: 1)
        default:
            break
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        75
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let character = characters[indexPath.row]
        
        let ac = UIAlertController(title: character.name, message: character.house, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        characters.count
    }
    
}

