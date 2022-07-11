//
//  SingletonFirstLesson.swift
//  VKClientFirstLesson
//
//  Created by Алексей on 10.06.2022.
//

import Foundation

class SessionMyApp {
    
    static let instance = SessionMyApp()
    
    private init() { }
    
    var token: String = ""
    var userId: String = ""
    
}


