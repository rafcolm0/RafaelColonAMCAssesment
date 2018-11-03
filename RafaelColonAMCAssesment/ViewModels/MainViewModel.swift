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
                completion(nil);
            } else {
                completion(error);
            }
        });
    }
}

