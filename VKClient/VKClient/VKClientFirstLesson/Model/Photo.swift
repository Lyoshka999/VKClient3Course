//
//  Photo.swift
//  VKClientFirstLesson
//
//  Created by Алексей on 25.06.2022.
//

import Foundation
import UIKit

class Photo: DataJSON, Decodable {

    var description: String = ""
    var type: String = ""
    var url: String = ""
    var photo: UIImage = #imageLiteral(resourceName: "groups")
    
    enum CodingKeys: String, CodingKey {
        case sizes
        case description = "text"
    }
    enum SizesCodingKeys: String, CodingKey {
        case type
        case url
    }

    
    convenience required init(from decoder: Decoder) throws {
        self.init()
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.description = try container.decode(String.self, forKey: .description)
        
        var sizeContainer = try container.nestedUnkeyedContainer(forKey: .sizes)

        _ = try sizeContainer.nestedContainer(keyedBy: SizesCodingKeys.self)
        _ = try sizeContainer.nestedContainer(keyedBy: SizesCodingKeys.self)
        _ = try sizeContainer.nestedContainer(keyedBy: SizesCodingKeys.self)
        _ = try sizeContainer.nestedContainer(keyedBy: SizesCodingKeys.self)
        
        let sizes = try sizeContainer.nestedContainer(keyedBy: SizesCodingKeys.self)
        self.type = try sizes.decode(String.self, forKey: .type)
        self.url = try sizes.decode(String.self, forKey: .url)
    }
}
