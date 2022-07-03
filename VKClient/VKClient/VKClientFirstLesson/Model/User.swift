//
//  User.swift
//  VKClientFirstLesson
//
//  Created by Алексей on 25.06.2022.
//

import UIKit
import RealmSwift

class User: Object, Decodable {

    @Persisted var userID: Int = 0
    @Persisted var name: String = ""
    @Persisted var lastName: String = ""
    @Persisted var userPhotoData: String = ""
  //  var avatar: UIImage = #imageLiteral(resourceName: "16.-phill")
    
    override class func primaryKey() -> String? {
        return "userID"
    }
     
    
    enum CodingKeys: String, CodingKey {
        case userID = "id"
        case name = "first_name"
        case lastName = "last_name"
        case userPhotoData = "photo_100"
    }
    
    convenience required init(from decoder: Decoder) throws {
        self.init()
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.userID = try container.decode(Int.self, forKey: .userID)
        self.name = try container.decode(String.self, forKey: .name)
        self.lastName = try container.decode(String.self, forKey: .lastName)
        self.userPhotoData = try container.decode(String.self, forKey: .userPhotoData)
    }
}
