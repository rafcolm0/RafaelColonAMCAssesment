//
//  HeroesTableCell.swift
//  RafaelColonAMCAssesment
//
//  Created by Rafael Colon on 11/2/18.
//  Copyright © 2018 rafaelColon. All rights reserved.
//

import Foundation
import UIKit

/*
 UITableViewCell class that "acts" as a "view controller" for the UICollectionView it holds. This UICollectionView is the gallery view populated with posters for the PosterGallery value from self.CarouselCellViewModel.
 */
class HeroesTableCell: UITableViewCell {
    @IBOutlet weak var galleryCollectionView: UICollectionView!
    var carouselViewModel:CarouselCellViewModel?
    
    func generateFlickrCollectionCarousel(gallery:PosterGallery!){
        carouselViewModel = CarouselCellViewModel(gallery:gallery, completion: {
            (error) in
            if(error == nil){
                self.galleryCollectionView.dataSource = self;
                //delegate for this view controller is empty; assigned here anyway to imitate real setup
                self.galleryCollectionView.delegate = self;
                self.galleryCollectionView.reloadData();
            } else {
                //if error: for the purpose of the test, we are just setting galleryCollectionView background to red. In real case scenario, here we could show some error message, hide the entire tableview cell, send error logs back to the app stat analytics, etc.
                self.galleryCollectionView.backgroundColor = UIColor.red;
            }
        });
    }
}

extension HeroesTableCell: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.carouselViewModel?.getPostersCount() ?? 0;
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let url = self.carouselViewModel?.generatePosterImageURLAt(position:indexPath.row);
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HeroCarouselCell", for: indexPath) as! HeroCarouselCell;
        //icon_loading_placeholder is a free licensed icon
        cell.heroImageView.kf.setImage(with:url, placeholder: UIImage(named: "icon_loading_placeholder"));
        return cell;
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //dummy functionality to imitate on cell click
        let feedbackGenerator = UIImpactFeedbackGenerator(style: .heavy)
        feedbackGenerator.impactOccurred()
    }
}

//UICollectionViewDelegate extended to imitate real setup
extension HeroesTableCell: UICollectionViewDelegate{}
