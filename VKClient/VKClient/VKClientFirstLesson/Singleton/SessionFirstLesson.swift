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
    
    var token: String = "vk1.a.bQLaYls-V6nensk-FFHJ89GtQHJydvBO3XQ5ck-qmUaqYq679yOZ01kCfTB-sMhmjpU8m8L5bka90zMG8VAU7wAMcnHEOstYyCDCwWZAKvKJ-E-UHhGGBnRXXD-4FEfGlZictExwbrrfaAFVHjq6Hozy1rrKMBUONf3DsVCY_RU5JUXXl8oIJiwyJR2f6ibj"
    var userId: Int = 0
    
}


