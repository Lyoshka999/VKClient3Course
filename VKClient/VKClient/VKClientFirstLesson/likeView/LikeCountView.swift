//
//  LikeCountView.swift
//  VKClientFirstLesson
//
//  Created by Алексей on 21.05.2022.
//

import UIKit

protocol LikeCountProtocol: AnyObject {
    func likeCountIncrement(counter: Int)
    func likeCountDecrement(counter: Int)
}



class LikeCountView: UIView {

    
    @IBOutlet weak var heartButton: UIButton!
    
    @IBOutlet weak var likeCounterLabel: UILabel!
    
    
    var likeEnable = false
    @IBInspectable var counter: Int = 0
    
    
    weak var delegate: LikeCountProtocol?
    
    
    private var likeView: UIView?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    private func loadFromNib() -> UIView {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: "LikeCountView", bundle: bundle)
        guard let likeView = nib.instantiate(withOwner: self, options: nil).first as? UIView else {return UIView()}
        return likeView
    }
    
    private func setup() {
        likeView = loadFromNib()
        guard let likeView = likeView else {return}
        likeView.frame = bounds
        likeView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        likeCounterLabel.text = String(counter)
        addSubview(likeView)
    }
    
    
    @IBAction func pressHeartToLike(_ sender: Any) {
        guard let button = sender as? UIButton else {return}
        if likeEnable {
            button.setImage(UIImage(systemName: "heart"), for: .normal)
            counter -= 1
            likeCounterLabel.text = String(counter)
            delegate?.likeCountDecrement(counter: counter)
        } else {
            button.setImage(UIImage(systemName: "heart.fill"), for: .normal)
            counter += 1
            likeCounterLabel.text = String(counter)
            delegate?.likeCountIncrement(counter: counter)
        }
        likeEnable = !likeEnable
        
    }
    
    
    
    
    
    
}
