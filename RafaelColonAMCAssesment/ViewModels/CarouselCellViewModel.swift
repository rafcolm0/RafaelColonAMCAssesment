//
//  CarouselCellViewModel.swift
//  RafaelColonAMCAssesment
//
//  Created by Rafael Colon on 11/2/18.
//  Copyright © 2018 rafaelColon. All rights reserved.
//

import Foundation
import UIKit
import Kingfisher

class CarouselCellViewModel: NSObject {
    var galleries:[PosterGallery];
    
    init(galleries:[PosterGallery]) {
        self.galleries = galleries;
    }
    
    func numberOfGalleries() -> Int {
        return self.galleries.count;
    }
    
    func getGalleryNameAt(position:Int) -> String{
        return self.galleries[position].name ?? "Error?";
    }
    
    func loadFlickGalleriesPhotos(galleryIndex:Int, completion: @escaping ((posters:[Poster]?, error:PhotoDownloadHandler.PhotoDownloadHandlerError?)) -> Void){
        PhotoDownloadHandler.shared.downloadPhotosFor(gallery: self.galleries[galleryIndex], completion:completion);
    }
    
    
}

extension CarouselCellViewModel: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.galleries[collectionView.tag].posters?.count ?? 0;
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HeroCarouselCell", for: indexPath) as! HeroCarouselCell;
        collectionView.dataSource
        cell.heroImageView.kf.setImage(with: self.firebaseUser.photoURL!, placeholder: UIImage(named: "loading_icon_green"));
        return cell;
    }
    
    
}

extension CarouselCellViewModel: UICollectionViewDelegate{
    
}
