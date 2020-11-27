//
//  ViewController.swift
//  How-To-Separate-UITableView
//
//  Created by Thomas Kellough on 11/27/20.
//

import UIKit

class ViewController: UITableViewController {
        
    let dataSource = CharacterDataSource()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.dataSource = dataSource
        
        let ned = Character(name: "Ned Stark", house: "Stark")
        let arya = Character(name: "Arya Stark", house: "Stark")
        let daenerys = Character(name: "Daenerys Targaryen", house: "Targaryen")
        let rhaegar = Character(name: "Rhaegar Targaryen", house: "Targaryen")
        let obern = Character(name: "Obern Martell", house: "Martell")
        let doran = Character(name: "Doran Martell", house: "Martell")
        let olenna = Character(name: "Olenna Tyrell", house: "Tyrell")
        let mace = Character(name: "Mace Tyrell", house: "Tyrell")
        
        dataSource.characters = [ned, arya, daenerys, rhaegar, obern, doran, olenna, mace].sorted(by: { $0.name < $1.name })
        
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        75
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let character = dataSource.characters[indexPath.row]
        
        let ac = UIAlertController(title: character.name, message: character.house, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
    }
    
}
