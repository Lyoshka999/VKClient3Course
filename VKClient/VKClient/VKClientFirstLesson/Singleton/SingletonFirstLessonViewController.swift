//
//  SingletonFirstLessonViewController.swift
//  VKClientFirstLesson
//
//  Created by Алексей on 10.06.2022.
//

import UIKit

class SingletonFirstLessonViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let session = SessionFirstLesson.instance

        session.token = ""
        session.userId = 0

    }

}
