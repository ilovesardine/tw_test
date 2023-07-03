//
//  ContactListDataSource.swift
//  tw-test
//
//  Created by Krisnandika Aji on 03/07/23.
//

import UIKit

class ContactListCollectionDataSource: NSObject, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate {
    
    var data: [Contact]
    var searchKeyword: String
    var selectionHandler: ((Contact) -> Void)?
    
    init(data: [Contact], searchKeyword: String = "", selectionHandler: ((Contact) -> Void)?) {
        self.data = data
        self.searchKeyword = searchKeyword
        self.selectionHandler = selectionHandler
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout
        let space = flowLayout.minimumInteritemSpacing + flowLayout.sectionInset.left + flowLayout.sectionInset.right
        let size = (collectionView.frame.size.width - space) / 2
        return CGSize(width: size, height: size)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ContactListItemCell.description(), for: indexPath) as? ContactListItemCell else { return UICollectionViewCell() }
        
        let data = self.data[indexPath.item]
        cell.populate(with: data)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        
        self.selectionHandler?(self.data[indexPath.item])
    }
}
