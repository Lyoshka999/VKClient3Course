//
//  AllGroupsViewController.swift
//  VKClientFirstLesson
//
//  Created by Алексей on 16.05.2022.
//

import UIKit

class AllGroupsViewController: UIViewController {

    let reuseIdentifierGeneral = "reuseIdentifierGeneral"
    let cellOfMyGroups: CGFloat = 100
    let fromAllGroupsToMyGroups = "fromAllGroupsToMyGroups"
    var selectedGroup: Group?
    
    
    
    @IBOutlet weak var tableViewMyGroup: UITableView!
    
    var allGroupArray = [Group]()
    
    func fillMyGroups() {
//        let sportCars = Group(title: "Sport Cars", avatar: UIImage(named: "SportCarOne")!)
//        let cats = Group(title: "Cats", avatar: UIImage(named: "Cats")!)
//        let flowers = Group(title: "Flowers", avatar: UIImage(named: "Flowers")!)
//        allGroupArray.append(sportCars)
//        allGroupArray.append(cats)
//        allGroupArray.append(flowers)
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tableViewMyGroup.reloadData()
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fillMyGroups()
        tableViewMyGroup.register(UINib(nibName: "GeneralTableViewCell", bundle: nil), forCellReuseIdentifier: "reuseIdentifierGeneral")
        tableViewMyGroup.delegate = self
        tableViewMyGroup.dataSource = self
    }

}

extension AllGroupsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allGroupArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableViewMyGroup.dequeueReusableCell(withIdentifier: reuseIdentifierGeneral, for: indexPath) as? GeneralTableViewCell else { return UITableViewCell()}
        cell.configure(group: allGroupArray[indexPath.row])
        cell.delegate = self
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return cellOfMyGroups
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectedGroup = allGroupArray[indexPath.row]
        performSegue(withIdentifier: fromAllGroupsToMyGroups, sender: nil)
    }
    
    
}


extension AllGroupsViewController:  GeneralTableCellProtocol {
    func generalTableLikeCountIncrement(counter: Int) {
        print(String(counter))
    }
    
    func generalTableLikeCountDecrement(counter: Int) {
        print(String(counter))
    }
    
    
}
