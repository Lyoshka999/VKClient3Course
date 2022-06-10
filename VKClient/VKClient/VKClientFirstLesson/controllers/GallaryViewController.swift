//
//  GallaryViewController.swift
//  VKClientFirstLesson
//
//  Created by Алексей on 16.05.2022.
//

import UIKit

class GallaryViewController: UIViewController {

    
    @IBOutlet weak var gallaryCollectionView: UICollectionView!
    
//    @IBOutlet weak var galleryViewMyFriends: UIView!
    
    
    
    let showFullPhotoMyFriends = "showFullPhotoMyFriends"
    let reuseIdentifierGallaryCollectionView = "GallaryCollectionView"
    
    var photos = [UIImage]()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        gallaryCollectionView.dataSource = self
        gallaryCollectionView.delegate = self
        gallaryCollectionView.register(UINib(nibName: "GallaryCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: reuseIdentifierGallaryCollectionView)
    }
    


}


extension GallaryViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifierGallaryCollectionView, for: indexPath) as? GallaryCollectionViewCell else { return UICollectionViewCell() }
        
        cell.configure(image: self.photos[indexPath.item])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: showFullPhotoMyFriends, sender: nil)
    }
    
}


extension GallaryViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == showFullPhotoMyFriends,
           let selectedPhoto = gallaryCollectionView.indexPathsForSelectedItems?.first,
           let fullPhotoMyFriends = segue.destination as? FullScreenPhotosViewController {
            fullPhotoMyFriends.photos = photos
            fullPhotoMyFriends.selectedPhotoIndex = selectedPhoto.item
        }
    }
}

