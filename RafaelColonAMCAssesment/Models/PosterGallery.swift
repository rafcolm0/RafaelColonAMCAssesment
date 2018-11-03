//
//  PosterGallery.swift
//  RafaelColonAMCAssesment
//
//  Created by Rafael Colon on 11/2/18.
//  Copyright © 2018 rafaelColon. All rights reserved.
//

import Foundation

class PosterGallery: NSObject {
    let id: String
    let name: String?
    var posters: [Poster]?
    
    init(id:String, name:String?, posters:[Poster]?) {
        self.id = id;
        self.name = name;
        self.posters = posters;
    }
}
