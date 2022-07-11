//
//  Users.swift
//  VKClientFirstLesson
//
//  Created by Алексей on 25.06.2022.
//

import Foundation


class Users: Decodable {
    var items: [User] = []
    
    enum CodingKeys: String, CodingKey {
        case response
    }
    
    enum ResponseCodingKeys: String, CodingKey {
        case count
        case items
    }
    
    convenience required init(from decoder: Decoder) throws {
        self.init()
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let response = try container.nestedContainer(keyedBy: ResponseCodingKeys.self, forKey: .response)
        let items = try response.decode([User].self, forKey: .items)
        self.items = items
    }
}
