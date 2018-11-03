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
    var gallery:PosterGallery!;
    
    init(gallery:PosterGallery, completion: @escaping ((PhotoDownloadHandler.PhotoDownloadHandlerError?) -> Void)) {
        super.init();
        self.gallery = gallery;
        self.loadFlickGalleriesPhotos(completion: completion);
    }
    
    func getPostersCount() -> Int {
        return self.gallery.posters?.count ?? 0;
    }
    
    func getPosterAt(position:Int) -> Poster?{
        return self.gallery.posters?[position] ?? nil;
    }
    
    /** Flickr DOWNLOAD URL TYPES:
     https://farm{farm-id}.staticflickr.com/{server-id}/{id}_{secret}.jpg
     https://farm{farm-id}.staticflickr.com/{server-id}/{id}_{secret}_[mstzb].jpg
     https://farm{farm-id}.staticflickr.com/{server-id}/{id}_{o-secret}_o.(jpg|gif|png)
     **/
    func generatePosterImageURLAt(position:Int) -> URL{
        let poster = getPosterAt(position: position);
        let url = String.init(format: "https://farm%@.staticflickr.com/%@/%@_%@.jpg", poster!.farmId, poster!.serverId, poster!.id, poster!.secret);
        return URL(string: url)!;
    }
    
    func loadFlickGalleriesPhotos(completion: @escaping ((PhotoDownloadHandler.PhotoDownloadHandlerError?) -> Void)){
        PhotoDownloadHandler.shared.downloadPhotosFor(gallery: self.gallery, completion: completion);
    }
}
