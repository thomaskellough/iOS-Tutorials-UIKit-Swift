//
//  CharacterDataSource.swift
//  How-To-Separate-UITableView
//
//  Created by Thomas Kellough on 11/27/20.
//

import UIKit

class CharacterDataSource: NSObject, UITableViewDataSource {
    
    var characters: [Character] = []
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        characters.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CharacterTableViewCell
        let character = characters[indexPath.row]
        
        cell.setUp(with: character)
        
        return cell
    }
    
}
