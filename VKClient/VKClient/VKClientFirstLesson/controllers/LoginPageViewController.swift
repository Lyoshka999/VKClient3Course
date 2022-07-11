//
//  LoginPageViewController.swift
//  VKClientFirstLesson
//
//  Created by Алексей on 13.05.2022.
//

import UIKit

class LoginPageViewController: UIViewController {

    @IBOutlet var loginTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    @IBOutlet weak var scrollViewLogin: UIScrollView!
    
    @IBOutlet weak var firstIndicator: UIView!
    
    @IBOutlet weak var secondIndicator: UIView!
    
    @IBOutlet weak var lastIndicator: UIView!
    
    
    func addShadow(shadow: UIView) {
        shadow.layer.shadowColor = UIColor.gray.cgColor
        shadow.layer.shadowOffset = CGSize(width: 5, height: 5)
        shadow.layer.shadowRadius = 5
        shadow.layer.shadowOpacity = 0.6
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        
        firstIndicator.alpha = 0
        secondIndicator.alpha = 0
        lastIndicator.alpha = 0
        
        indicatorLoadingLoginPage()
        
    }
    
    
    func indicatorLoadingLoginPage() {
        UIView.animate(withDuration: 1) {[weak self] in
            self?.firstIndicator.alpha = 0
            self?.secondIndicator.alpha = 1
        } completion: { _ in
            UIView.animate(withDuration: 1) {[weak self] in
                self?.secondIndicator.alpha = 0
                self?.lastIndicator.alpha = 1
            } completion: { _ in
                UIView.animate(withDuration: 1) {[weak self] in
                    self?.lastIndicator.alpha = 0
                    self?.firstIndicator.alpha = 1
                } completion: {[weak self] _ in
                    self?.indicatorLoadingLoginPage()
                }
         }
 
      }
    }
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
 
        
        self.setupHideKeyboardOnTap()
        addShadow(shadow: loginTextField)
        addShadow(shadow: passwordTextField)
        addShadow(shadow: loginButton)
        
        
        
        
        loginButton.clipsToBounds = true
        loginButton.layer.cornerRadius = 18
        
        
        loginTextField.clipsToBounds = true
        loginTextField.layer.cornerRadius = 20
        
        passwordTextField.clipsToBounds = true
        passwordTextField.layer.cornerRadius = 20
        
        
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [UIColor.systemBlue.cgColor, UIColor.systemCyan.cgColor, UIColor.systemTeal.cgColor, UIColor.systemMint.cgColor]
        gradientLayer.locations = [0, 0.33, 0.66, 1]
        gradientLayer.startPoint = CGPoint.zero
        gradientLayer.endPoint = CGPoint(x: 1, y: 1)
        gradientLayer.frame = self.view.bounds
        self.view.layer.addSublayer(gradientLayer)
        
        scrollViewLogin.layer.zPosition = 1
        
        
    }
    
    
    
    @IBAction func loginButtonPress(_ sender: UIButton) {
        
        
        guard let login = loginTextField.text,
              let password = passwordTextField.text
        else { return }
        
        if login == "admin",
           password == "1111" {
            loginTextField.backgroundColor = UIColor.green
            passwordTextField.backgroundColor = UIColor.green
            performSegue(withIdentifier: "loginButton", sender: nil)
            
        } else if login == "",
                  password == "" {
            loginTextField.backgroundColor = UIColor.green
            passwordTextField.backgroundColor = UIColor.green
            performSegue(withIdentifier: "loginButton", sender: nil)
        }
        
        else {
            loginTextField.backgroundColor = UIColor.red
            passwordTextField.backgroundColor = UIColor.red
            return
        }
    }
    
}
