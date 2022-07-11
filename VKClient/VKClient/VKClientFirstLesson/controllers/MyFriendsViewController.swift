//
//  MyFriendsViewController.swift
//  VKClientFirstLesson
//
//  Created by Алексей on 15.05.2022.
//

import UIKit
import RealmSwift

class MyFriendsViewController: UIViewController {

    @IBOutlet weak var tableViewMyFriends: UITableView!
    
    @IBOutlet weak var searchBar: UISearchBar!
    
let serviceVK = ServiceVK()
let reuseIdentifierGeneral = "reuseIdentifierGeneral"
let fromFriendsToGallarySegue = "fromFriendsToGallary"
let cellOfMyFriends: CGFloat = 100

    
    private var notificationTokenFriends: NotificationToken?

    var friendsArray: [User] = [] {
        didSet {
            tableViewMyFriends.reloadData()
        }
    }
var copyFriendsArray = [User]()
var friendsResults: Results<User>?

    deinit {
        notificationTokenFriends?.invalidate()
    }

/// Переменная индикатора закрузки
//    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()




//func fillFriendsArray() {
//    let friendOne = Friend(name: "Тор", avatar: UIImage(named: "Тор")!, photos: [UIImage(named: "ThorOne")!, UIImage(named: "ThorTwo")!, UIImage(named: "ThorThree")!])
//    let friendTwo = Friend(name: "Железный человек", avatar: UIImage(named: "Железный человек")!, photos: [UIImage(named: "IronManOne")!, UIImage(named: "IronManTwo")!, UIImage(named: "IronManThree")!])
//    let friendThree = Friend(name: "Халк", avatar: UIImage(named: "Халк")!, photos: [UIImage(named: "HulkOne")!, UIImage(named: "HulkTwo")!, UIImage(named: "HulkThree")!])
//    let friendFour = Friend(name: "Человек паук", avatar: UIImage(named: "Человек паук")!, photos: [UIImage(named: "SpiderManOne")!, UIImage(named: "SpiderManTwo")!])
//    friendsArray.append(friendOne)
//    friendsArray.append(friendTwo)
//    friendsArray.append(friendThree)
//    friendsArray.append(friendFour)
    
//}

//func arrayLetter(sourceArray: [Friend]) -> [String] {
//    var resultArray = [String]()
//    for item in sourceArray {
//        let nameLetter = String(item.name.prefix(1))
//        if !resultArray.contains(nameLetter.lowercased()) {
//            resultArray.append(nameLetter.lowercased())
//    }
//
//}
//    return resultArray.sorted { firstItem, secondItem in
//        firstItem < secondItem
//    }
//}

    
    func arrayLetter(sourceArray: [User]) -> [String] {
        var resultArray = [String]()
        for item in sourceArray {
            let nameLetter = String(item.name.prefix(1))
            if !resultArray.contains(nameLetter.lowercased()) {
                resultArray.append(nameLetter.lowercased())
        }
            
    }
        return resultArray.sorted { firstItem, secondItem in
            firstItem < secondItem
        }
    }

//func arrayByLetter(sourceArray: [Friend], letter: String) -> [Friend] {
//    var resultArray = [Friend]()
//    for item in sourceArray {
//        let nameLetter = String(item.name.prefix(1)).lowercased()
//        if nameLetter == letter.lowercased() {
//            resultArray.append(item)
//        }
//    }
//    return resultArray
//}

    func arrayByLetter(sourceArray: [User], letter: String) -> [User] {
        var resultArray = [User]()
        for item in sourceArray {
            let nameLetter = String(item.name.prefix(1)).lowercased()
            if nameLetter == letter.lowercased() {
                resultArray.append(item)
            }
        }
        return resultArray
    }
    
    
override func viewDidLoad() {
    super.viewDidLoad()
//    fillFriendsArray()
//    copyFriendsArray = friendsArray
    tableViewMyFriends.register(UINib(nibName: "GeneralTableViewCell", bundle: nil), forCellReuseIdentifier: "reuseIdentifierGeneral")
    tableViewMyFriends.delegate = self
    tableViewMyFriends.dataSource = self
    searchBar.delegate = self
    self.setupHideKeyboardOnTap()

    
    serviceVK.loadFriendsData(method: .users) { [weak self] in
       // self?.friendsArray = friendsArray
        self?.getFriendsFromRealm()
    }
}

    private func getFriendsFromRealm() {
        do {
           let realm = try Realm()
           // print(realm.configuration.fileURL)
            friendsResults = realm.objects(User.self)
            if let friendsData = friendsResults {
                friendsArray = Array(friendsData)
               // print(friendsData)
                notificationTokenFriends = friendsResults?.observe { [weak self] change in
                    switch change {
                    case .initial:
                        self?.tableViewMyFriends.reloadData()
                    case .update( _, let deletions, let insertions, let modifications):
                        self?.tableViewMyFriends.beginUpdates()
                        self?.tableViewMyFriends.deleteRows(at: deletions.map({ IndexPath(row: $0, section: 0) }), with: .automatic)
                        self?.tableViewMyFriends.insertRows(at: deletions.map({ IndexPath(row: $0, section: 0) }), with: .automatic)
                        self?.tableViewMyFriends.reloadRows(at: deletions.map({ IndexPath(row: $0, section: 0) }), with: .automatic)
                        self?.tableViewMyFriends.endUpdates()
                     case .error:
                        break
                    }
                }
            }
        } catch {
            print(error)
        }
    }
override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == fromFriendsToGallarySegue,
//           let sourceVC = segue.source as? MyFriendsViewController,
       let destinationVC = segue.destination as? GallaryViewController,
       let friend = sender as? User {
//        destinationVC.photos = Users.photos
    }
    
/// Indicator loading
//        activityIndicator.center = self.view.center
//        activityIndicator.hidesWhenStopped = true
//        activityIndicator.style = UIActivityIndicatorView.Style.large
//        view.addSubview(activityIndicator)
//
//        activityIndicator.startAnimating()
}

}


extension MyFriendsViewController: UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {

func numberOfSections(in tableView: UITableView) -> Int {
    return arrayLetter(sourceArray: friendsArray).count
}


func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return arrayByLetter(sourceArray: friendsArray, letter: arrayLetter(sourceArray: friendsArray)[section]).count
}

func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableViewMyFriends.dequeueReusableCell(withIdentifier: reuseIdentifierGeneral, for: indexPath) as? GeneralTableViewCell else { return UITableViewCell()}
    cell.configure(friend: arrayByLetter(sourceArray: friendsArray, letter: arrayLetter(sourceArray: friendsArray)[indexPath.section])[indexPath.row])
    
    
    return cell
}

func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    performSegue(withIdentifier: fromFriendsToGallarySegue, sender: arrayByLetter(sourceArray: friendsArray, letter: arrayLetter(sourceArray: friendsArray)[indexPath.section])[indexPath.row])
}


func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return cellOfMyFriends
}

func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    return arrayLetter(sourceArray: friendsArray)[section].uppercased()
}

func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
    if searchText.isEmpty {
        self.friendsArray = self.copyFriendsArray
    } else {
        self.friendsArray = self.friendsArray.filter({ friendsItem in
            friendsItem.name.lowercased().contains(searchText.lowercased())
        })
    }
    self.tableViewMyFriends.reloadData()
}




}
