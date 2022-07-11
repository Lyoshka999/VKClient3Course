//
//  NewsViewController.swift
//  VKClientFirstLesson
//
//  Created by Алексей on 05.06.2022.
//

import UIKit


class NewsViewController: UIViewController {

    @IBOutlet weak var newsTableView: UITableView!
    
    
    let reuseIdentifierNews = "reuseIdentifierNews"
    let cellOfNews: CGFloat = 310
    
    
    
    var newsArray = [NewsMyApp]()
    
    
    func fillNewsArray() {
        
        let newsOne = NewsMyApp(textNews: "Вы только гляньте на этого котика - загляденье!!", imageNews:UIImage(named: "Котик1")!)
        let newsTwo = NewsMyApp(textNews: "Тоже котик ничего!", imageNews:UIImage(named: "Котик2")!)
        newsArray.append(newsOne)
        newsArray.append(newsTwo)
        
        
        
        
        
        
    }
    
    
    
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        fillNewsArray()
        newsTableView.register(UINib(nibName: "NewsTableViewCell", bundle: nil), forCellReuseIdentifier: reuseIdentifierNews)
        newsTableView.delegate = self
        newsTableView.dataSource = self
        
       
        
    }
    


}



extension NewsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let newsCell = newsTableView.dequeueReusableCell(withIdentifier: reuseIdentifierNews, for: indexPath) as? NewsTableViewCell else {return UITableViewCell()}
        newsCell.configure(news: newsArray[indexPath.row])
        
        return newsCell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return cellOfNews
    }
    
}
