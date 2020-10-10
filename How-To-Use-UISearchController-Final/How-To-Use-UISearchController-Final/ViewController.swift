//
//  ViewController.swift
//  How-To-Use-UISearchController-Final
//
//  Created by Thomas Kellough on 10/10/20.
//

import UIKit

class ViewController: UITableViewController, UISearchResultsUpdating {
    
    var students = [Student]()
    var filteredStudents = [Student]()
    var dataChanged: (() -> Void)?
    var filterText: String = "" {
        didSet {
            filteredStudents = students.matching(filterText)
            dataChanged?()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createStudents()
        
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search..."
        navigationItem.searchController = searchController
        
        dataChanged = {
          self.tableView.reloadData()
        }
    }
    
    func createStudents() {
        let harry = Student(name: "Harry Potter", house: "Gryffindor")
        let hermione = Student(name: "Hermione Granger", house: "Gryffindor")
        let ron = Student(name: "Ronald Weasley", house: "Gryffindor")
        let luna = Student(name: "Luna Lovegood", house: "Ravenclaw")
        let ginny = Student(name: "Ginny Weasley", house: "Gryffindor")
        let fred = Student(name: "Fred Weasley", house: "Gryffindor")
        let george = Student(name: "George Weasley", house: "Gryffindor")
        let neville = Student(name: "Neville Longbottom", house: "Gryffindor")
        let dean = Student(name: "Dean Thomas", house: "Gryffindor")
        let draco = Student(name: "Draco Malfoy", house: "Slytherin")
        let parvati = Student(name: "Parvati Patil", house: "Gryffindor")
        let padma = Student(name: "Padma Patil", house: "Ravenclaw")
        let cedric = Student(name: "Cedric Diggory", house: "Hufflepuff")
        let hannah = Student(name: "Hannah Abbott", house: "Hufflepuff")
        let zacharias = Student(name: "Zacharias Smith", house: "Hufflepuff")
        let crabbe = Student(name: "Vincent Crabbe", house: "Slytherin")
        let goyle = Student(name: "Gregory Goyle", house: "Slytherin")
        
        students += [harry, hermione, ron, ginny, fred, george, luna, neville, dean, draco, parvati, padma, cedric, hannah, zacharias, crabbe, goyle]
        filteredStudents = students
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        let student = filteredStudents[indexPath.row]
        
        cell.textLabel?.text = student.name
        cell.detailTextLabel?.text = student.house
        cell.textLabel?.font = .preferredFont(forTextStyle: .headline)
        cell.detailTextLabel?.font = .preferredFont(forTextStyle: .subheadline)
        cell.textLabel?.textColor = .white
        cell.detailTextLabel?.textColor = .white
        
        switch student.house {
        case "Gryffindor":
            cell.backgroundColor = UIColor(red: 174/255, green: 0, blue: 1/255, alpha: 1)
        case "Ravenclaw":
            cell.backgroundColor = UIColor(red: 34/255, green: 47/255, blue: 91/255, alpha: 1)
        case "Hufflepuff":
            cell.backgroundColor = UIColor(red: 255/255, green: 219/255, blue: 0, alpha: 1)
            cell.textLabel?.textColor = .black
            cell.detailTextLabel?.textColor = .black
        case "Slytherin":
            cell.backgroundColor = UIColor(red: 42/255, green: 98/255, blue: 61/255, alpha: 1)
        default:
            break
        }
        
        return cell
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        filteredStudents.count
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        if let text = searchController.searchBar.text {
            filterText = text
        }
    }
    
}

struct Student {
    var name: String
    var house: String
}

extension Array where Element == Student {
    func matching(_ text: String) -> [Student] {
        if text.count > 0 {
            return self.filter {
                $0.name.lowercased().contains(text.lowercased()) || $0.house.lowercased().contains(text.lowercased())
            }
        } else {
            return self
        }
    }
}
