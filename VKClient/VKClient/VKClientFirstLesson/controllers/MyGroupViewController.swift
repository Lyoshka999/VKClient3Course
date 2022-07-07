//
//  MyGroupViewController.swift
//  VKClientFirstLesson
//
//  Created by Алексей on 15.05.2022.
//

import UIKit
import RealmSwift
import FirebaseDatabase

class MyGroupViewController: UIViewController {

    let serviceVK = ServiceVK()
    let session = SessionMyApp.instance
    let reuseIdentifierGeneral = "reuseIdentifierGeneral"
    let cellOfMyGroups: CGFloat = 100
    let fromAllGroupsToMyGroups = "fromAllGroupsToMyGroups"
    
    private var notificationTokenGroups: NotificationToken?
    
    
    @IBOutlet weak var tableViewMyGroup: UITableView!
    
    var myGroupArray = [Group]()
    
    var groupArray: [Group] = [] {
        didSet {
            saveGroupsNamesToFirebase(id: session.userId, groups: groupArray)
            tableViewMyGroup.reloadData()
        }
    }
    
    var groupResults: Results<Group>?
    
    deinit {
        notificationTokenGroups?.invalidate()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tableViewMyGroup.reloadData()
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewMyGroup.register(UINib(nibName: "GeneralTableViewCell", bundle: nil), forCellReuseIdentifier: "reuseIdentifierGeneral")
        tableViewMyGroup.delegate = self
        tableViewMyGroup.dataSource = self
        serviceVK.loadGroupsData(method: .groups) { [weak self] groupArray in
//            self?.groupArray = groupArray
            self?.getGroupsFromRealm()
        }
}
    
    
    
    private func getGroupsFromRealm() {
        do {
           let realm = try Realm()
//            print(realm.configuration.fileURL)
            groupResults = realm.objects(Group.self)
            if let groupData = groupResults {
                groupArray = Array(groupData)
                notificationTokenGroups = groupResults?.observe { [weak self] change in
                    switch change {
                    case .initial:
                        self?.tableViewMyGroup.reloadData()
                    case .update( _, let deletions, let insertions, let modifications):
                        self?.tableViewMyGroup.beginUpdates()
                        self?.tableViewMyGroup.deleteRows(at: deletions.map({ IndexPath(row: $0, section: 0) }), with: .automatic)
                        self?.tableViewMyGroup.insertRows(at: insertions.map({ IndexPath(row: $0, section: 0) }), with: .automatic)
                        self?.tableViewMyGroup.reloadRows(at: modifications.map({ IndexPath(row: $0, section: 0) }), with: .automatic)
                        self?.tableViewMyGroup.endUpdates()
                     case .error:
                        break
                    }
                }
            }

        } catch {
            print(error)
        }
    }
    
    
    func addGroupInMyGroupExamination(group: Group) -> Bool {
        return myGroupArray.contains { sourceGroup in
            sourceGroup.name == group.name
            
        }
    }
    
//    private func groupFirebaseDatabase(userId: Int, group: [Group]) {
//
//        let myGroupFromAppData = GroupForFirebaseDatabase(
//
//
//        let data = [myGroupFromAppData].map { $0.toAnyObject }
//        let dbLink = Database.database().reference()
//        dbLink.child("Groups").setValue(data)
//    }

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
        return groupArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableViewMyGroup.dequeueReusableCell(withIdentifier: reuseIdentifierGeneral, for: indexPath) as? GeneralTableViewCell else { return UITableViewCell()}
        cell.configure(group: groupArray[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return cellOfMyGroups
    }
    
}

extension MyGroupViewController {
    
    private func saveGroupsNamesToFirebase(id: String, groups: [Group]) {
        let group = GroupsToFirebase(id: id, groups: groups)
        let data = group.toAnyObject
        let dbLink = Database.database(url: "https://myfirstvkclientapp-default-rtdb.europe-west1.firebasedatabase.app"
).reference()
        
        dbLink.child("Groups/\(id)").setValue(data)
    }
}
