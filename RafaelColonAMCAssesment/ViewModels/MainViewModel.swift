//
//  MainViewModel.swift
//  RafaelColonAMCAssesment
//
//  Created by Rafael Colon on 11/2/18.
//  Copyright © 2018 rafaelColon. All rights reserved.
//

import Foundation
import UIKit

class MainViewModel:NSObject {
    var carouselsViewModel:CarouselCellViewModel?;
    var galleries:[PosterGallery]?;
    
    override init() {
        super.init();
    }
    
    func numberOfGalleries() -> Int {
        return self.galleries?.count ?? 0;
    }
    
    func getGalleryNameAt(position:Int) -> String{
        return self.galleries?[position].name ?? "Error?";
    }
    
    func getGalleryAt(position:Int) -> PosterGallery?{  //dangerous?
        return self.galleries?[position] ?? nil;
    }
    
    func loadFlickUserGalleries(completion: @escaping(Error?) -> Void){
        PhotoDownloadHandler.shared.fetchFlickrUserGalleries(completion: {
            (results, error) in
            if(results != nil){
                self.galleries = results;
                /*
                 NOTE: As we coudn't find any gallery flag or gallery ordering system in the Flickr API, this sort is just because the Flickr gallery (called "Banners") we are using for the top large banners (Heroes UICollectionView) is the gallery with the smallest name alphabetically, and for this example we always want it in cell position 0 for the tableview to distinct.
                 
                 On a real case scenario, the API would have some sort of flag system for the app to differentiate between banner (Heroes UICollectionView) type collections vs standard poster collections, or even a structured ordering convention.
                 */
                self.galleries?.sort(by: { $0.name! < $1.name! });
                completion(nil);
            } else {
                completion(error);
            }
        });
    }
}

