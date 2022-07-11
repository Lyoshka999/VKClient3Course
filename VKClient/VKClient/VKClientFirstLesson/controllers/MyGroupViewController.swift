//
//  MyGroupViewController.swift
//  VKClientFirstLesson
//
//  Created by Алексей on 15.05.2022.
//

import UIKit

class MyGroupViewController: UIViewController {

    let reuseIdentifierGeneral = "reuseIdentifierGeneral"
    let cellOfMyGroups: CGFloat = 100
    let fromAllGroupsToMyGroups = "fromAllGroupsToMyGroups"
    
    @IBOutlet weak var tableViewMyGroup: UITableView!
    
    var myGroupArray = [Group]()
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tableViewMyGroup.reloadData()
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewMyGroup.register(UINib(nibName: "GeneralTableViewCell", bundle: nil), forCellReuseIdentifier: "reuseIdentifierGeneral")
        tableViewMyGroup.delegate = self
        tableViewMyGroup.dataSource = self
    }
    
    
    
    func addGroupInMyGroupExamination(group: Group) -> Bool {
        return myGroupArray.contains { sourceGroup in
            sourceGroup.title == group.title
            
        }
    }
    
    
    

    @IBAction func unwindSegueToMyGroup(segue: UIStoryboardSegue) {
        if segue.identifier == fromAllGroupsToMyGroups,
           let sourceVC = segue.source as? AllGroupsViewController,
           let selectedGroup = sourceVC.selectedGroup as? Group {
            if addGroupInMyGroupExamination(group: selectedGroup) {return}
            self.myGroupArray.append(selectedGroup)
            tableViewMyGroup.reloadData()
            
        }
    }
    
    
    
    
}

extension MyGroupViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myGroupArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableViewMyGroup.dequeueReusableCell(withIdentifier: reuseIdentifierGeneral, for: indexPath) as? GeneralTableViewCell else { return UITableViewCell()}
        cell.configure(group: myGroupArray[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return cellOfMyGroups
    }
    
}
