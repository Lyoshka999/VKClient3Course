//
//  SingletonFirstLesson.swift
//  VKClientFirstLesson
//
//  Created by Алексей on 10.06.2022.
//

import Foundation

class SessionFirstLesson {
    
    static let instance = SessionFirstLesson()
    
    private init() { }
    
    var token: String = ""
    var userId: Int = 0
    
}


