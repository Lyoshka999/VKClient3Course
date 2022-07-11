//
//  GeneralTableViewCell.swift
//  VKClientFirstLesson
//
//  Created by Алексей on 15.05.2022.
//

import UIKit
import Kingfisher

protocol GeneralTableCellProtocol: AnyObject {
    func generalTableLikeCountIncrement(counter: Int)
    func generalTableLikeCountDecrement(counter: Int)
}


class GeneralTableViewCell: UITableViewCell {

    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var backViewOfImageOnCellMyFriends: UIView!
    
    @IBOutlet weak var likeView: LikeCountView!
    
    
    weak var delegate: GeneralTableCellProtocol?
    
    
    override func prepareForReuse() {
        avatarImageView.kf.cancelDownloadTask()
        avatarImageView.image = nil
        titleLabel.text = nil
    }
    
    
//    func configure(friend: Friend) {
//        avatarImageView.image = friend.avatar
//        titleLabel.text = friend.name
//    }
    
    func configure(friend: User) {
      //  avatarImageView.image = friend.avatar
      //  avatarImageView.image = #imageLiteral(resourceName: "Котик2")
        titleLabel.text = friend.name
        
        if let url = URL(string: friend.userPhotoData) {
            avatarImageView.kf.setImage(with: url)
        }
    }
    
    func configure(group: Group) {
//        avatarImageView.image = group.groupPhotoData
        titleLabel.text = group.name
        
        if let url = URL(string: group.groupPhotoData) {
            avatarImageView.kf.setImage(with: url)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        likeView.delegate = self
        avatarImageView.layer.cornerRadius = 45
        backViewOfImageOnCellMyFriends.layer.cornerRadius = 45
        backViewOfImageOnCellMyFriends.layer.shadowColor = UIColor.gray.cgColor
        backViewOfImageOnCellMyFriends.layer.shadowRadius = 5
        backViewOfImageOnCellMyFriends.layer.shadowOpacity = 0.9
        backViewOfImageOnCellMyFriends.layer.shadowOffset = CGSize(width: 5, height: 5)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func pressAvatarButtonToAnimation(_ sender: Any) {
        
        let scale = CGFloat(30)
        

        UIView.animate(withDuration: 0) { [weak self] in
            
            
            guard let self = self else {return}
            self.avatarImageView.frame = CGRect(x: self.avatarImageView.frame.origin.x + scale / 2, y: self.avatarImageView.frame.origin.y + scale / 2, width: self.avatarImageView.frame.width - scale, height: self.avatarImageView.frame.height - scale)
        } completion: { isSuccessfully in
            UIView.animate(withDuration: 2,
                           delay: 0,
                           usingSpringWithDamping: 0.2,
                           initialSpringVelocity: 0.8,
                           options: []) { [weak self] in
                guard let self = self else {return}
                self.avatarImageView.frame = CGRect(x: self.avatarImageView.frame.origin.x - scale / 2, y: self.avatarImageView.frame.origin.y - scale / 2, width: self.avatarImageView.frame.width + scale, height: self.avatarImageView.frame.height + scale)
                
            } completion: { _ in
                
            }

        }
   
    }
}


extension GeneralTableViewCell: LikeCountProtocol {
    func likeCountIncrement(counter: Int) {
        delegate?.generalTableLikeCountIncrement(counter: counter)
        UIView.transition(with: likeView,
                          duration: 1,
                          options: .transitionFlipFromLeft) {
            self.likeView.backgroundColor = .green
        }
    }
    
    func likeCountDecrement(counter: Int) {
        delegate?.generalTableLikeCountDecrement(counter: counter)
        UIView.transition(with: likeView,
                          duration: 1,
                          options: .transitionFlipFromLeft) {
            self.likeView.backgroundColor = .clear
            
        }
        
    }
    
}
