//
//  SingletonFirstLessonViewController.swift
//  VKClientFirstLesson
//
//  Created by Алексей on 10.06.2022.
//

import UIKit

class SingletonMyAppViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let session = SessionMyApp.instance

        session.token = ""
        session.userId = 0

    }

}
