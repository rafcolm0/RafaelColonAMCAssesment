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
    
    func loadFlickUserGalleries(completion: @escaping(Error?) -> Void){
        PhotoDownloadHandler.shared.fetchFlickrUserGalleries(completion: {
            (results, error) in
            if(results != nil){
                //force-unwrap is ok here because we initialize results to empty array by default
                self.carouselsViewModel = CarouselCellViewModel(galleries: results!);
                completion(nil);
            } else {
                completion(error);
            }
        });
    }
}


extension MainViewModel:UITableViewDelegate{
    
}

extension MainViewModel:UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.carouselsViewModel?.numberOfGalleries() ?? 0;
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell:UITableViewCell?;
        if(indexPath.row == 0){
            cell = tableView.dequeueReusableCell(withIdentifier: "HeroesTableCell", for: indexPath) as! HeroesTableCell;
        } else {
            cell = tableView.dequeueReusableCell(withIdentifier: "PostersTableCell", for: indexPath) as! PostersTableCell;
            (cell as! PostersTableCell).postersTittleLabel.text = self.carouselsViewModel?.getGalleryNameAt(position: indexPath.row);
        }
        //ok to force unwrap here because at this point nothing should be nil
        (cell as! HeroesTableCell).galleryCollectionView.dataSource = self.carouselsViewModel;
        self.carouselsViewModel!.loadFlickGalleriesPhotos(galleryIndex: indexPath.row, completion: {
            (posters, error) in
            (cell as! HeroesTableCell).posters = posters;
            (cell as! HeroesTableCell).galleryCollectionView.reloadData();
        });
        return cell!;
    }
}

