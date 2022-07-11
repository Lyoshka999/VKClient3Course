//
//  Group.swift
//  VKClientFirstLesson
//
//  Created by Алексей on 15.05.2022.
//

import UIKit
import RealmSwift
//struct Group {
//    var title = String()
//    var avatar = UIImage()
//}

class Group: Object, Decodable {
    
  @Persisted var name: String = ""
  @Persisted var groupPhotoData: String = ""
//  @Persisted var avatarGroup: UIImage = #imageLiteral(resourceName: "groups")
   
    override class func primaryKey() -> String? {
        return "groupPhotoData"
    }
    
    
    enum CodingKeys: String, CodingKey {
        case name
        case groupPhotoData = "photo_100"
        
    }
    
    convenience required init(from decoder: Decoder) throws {
        self.init()
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try container.decode(String.self, forKey: .name)
        self.groupPhotoData = try container.decode(String.self, forKey: .groupPhotoData)
    }
    
    
}
