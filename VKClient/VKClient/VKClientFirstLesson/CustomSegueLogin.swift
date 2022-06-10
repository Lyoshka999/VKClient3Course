//
//  CustomSegueLogin.swift
//  VKClientFirstLesson
//
//  Created by Алексей on 31.05.2022.
//

import UIKit

class CustomSegueLogin: UIStoryboardSegue {
    
    override func perform() {
        guard let sourceLoginView = source.view.superview,
              let destinationTabBarView = destination.view else { return }
        
        let sourceLoginViewFrame = sourceLoginView.frame
        let destinationFrame = source.view.frame
        
        
        sourceLoginView.addSubview(destination.view)
        
        destinationTabBarView.frame = CGRect(x: source.view.frame.width / 2, y: source.view.frame.height / 2, width: 0, height: 0)
        
        
        UIView.animate(withDuration: 2) { [weak self] in
            self?.source.view.frame = destinationTabBarView.frame
        } completion: { isSuccessfully in
            if isSuccessfully {
                UIView.animate(withDuration: 2) {
                    destinationTabBarView.frame = destinationFrame
                } completion: { [weak self] isSuccess in
                    if isSuccess,
                    let self = self {
                        
                        self.source.present(self.destination, animated: false, completion: nil)
                    }
                }

            }
        }

        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
    }
    
    
    
    
    
    
}
