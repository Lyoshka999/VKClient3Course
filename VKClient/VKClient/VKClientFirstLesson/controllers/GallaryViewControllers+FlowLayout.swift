//
//  GallaryViewControllers+FlowLayout.swift
//  VKClientFirstLesson
//
//  Created by Алексей on 17.05.2022.
//

import UIKit

extension GallaryViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let collectionViewWidth = collectionView.bounds.width
        let betweenSpace = CGFloat(5)
        let countImageOnLineWidth = CGFloat(2)
        let cellWidth = collectionViewWidth / countImageOnLineWidth - betweenSpace
        return CGSize(width: cellWidth, height: cellWidth)
    }
}
