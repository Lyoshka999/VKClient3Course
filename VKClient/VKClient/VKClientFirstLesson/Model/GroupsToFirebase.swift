//
//  GroupsToFirebase.swift
//  VKClientFirstLesson
//
//  Created by Алексей on 07.07.2022.
//

import Foundation

struct GroupsToFirebase: Decodable {
    let id: String
    let groups: [Group]
    
    var toAnyObject: Any {
       return [
            "id": id,
            "groups": groups.compactMap { $0.name }
        ]
    }
}
