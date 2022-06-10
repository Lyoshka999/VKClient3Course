//
//  NewsTableViewCell.swift
//  VKClientFirstLesson
//
//  Created by Алексей on 05.06.2022.
//

import UIKit

protocol NewsTableCellProtocol: AnyObject {
    func newsTableLikeCountIncrement(counter: Int)
    func newsTableLikeCountDecrement(counter: Int)
}


class NewsTableViewCell: UITableViewCell {

    
    @IBOutlet weak var textNewsLabel: UILabel!
    
    
    @IBOutlet weak var imageNews: UIImageView!
    
    
    @IBOutlet weak var likeNews: LikeCountView!
    
    
    @IBOutlet weak var commentsNews: UIView!
    
    
    @IBOutlet weak var shareNews: UIView!
    
    weak var delegate: NewsTableCellProtocol?
    
    
    
    override func prepareForReuse() {
        textNewsLabel.text = nil
        imageNews.image = nil
    }
    
    
    
    func configure(news: NewsMyApp) {
        textNewsLabel.text = news.textNews
        imageNews.image = news.imageNews
    }
    
    
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
//        imageNews.clipsToBounds = true
//        imageNews.layer.cornerRadius = 45
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}


extension NewsTableViewCell: LikeCountProtocol {
    func likeCountIncrement(counter: Int) {
        delegate?.newsTableLikeCountIncrement(counter: counter)
        UIView.transition(with: likeNews,
                          duration: 1,
                          options: .transitionFlipFromLeft) {
            self.likeNews.backgroundColor = .green
        }
    }
    
    func likeCountDecrement(counter: Int) {
        delegate?.newsTableLikeCountDecrement(counter: counter)
        UIView.transition(with: likeNews,
                          duration: 1,
                          options: .transitionFlipFromLeft) {
            self.likeNews.backgroundColor = .clear
            
        }
        
    }
    
}
