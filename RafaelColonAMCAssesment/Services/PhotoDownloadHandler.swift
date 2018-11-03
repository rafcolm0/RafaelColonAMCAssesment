//
//  PhotoDownloadHandler.swift
//  RafaelColonAMCAssesment
//
//  Created by Rafael Colon on 11/2/18.
//  Copyright © 2018 rafaelColon. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class PhotoDownloadHandler{
    static let shared = PhotoDownloadHandler();
    static let flickr_API_KEY:String = "25dcd56827daaec5ac1b692632488aa0";
    static let flickr_API_SECRET:String = "fe247d6ef3f7898c";
    static let FLICKR_URL:String = "https://api.flickr.com/services/rest/";
    static let FLICKR_METHOD:String = "method";
    static let FLICKR_METHOD_GET_GALLERIES:String = "flickr.galleries.getList";
    static let FLICKR_METHOD_GET_GALLERY_PICS:String = "flickr.galleries.getPhotos";
    static let FLICKR_PARAM_API_KEY:String = "api_key";
    static let FLICKR_PARAM_USER_ID:String = "user_id";
    static let FLICKR_USER_ID:String = "161771981@N05";
    static let FLICKR_PARAM_FORMAT:String = "format";
    static let FLICKR_FORMAT:String = "json";
    static let FLICKR_PARAM_NOJSONCALLBACK:String = "nojsoncallback";
    static let FLICKR_NOJSONCALLBACK:String = "1";
    static let FLICKR_PARAM_GALLERYID:String = "gallery_id";
    
    
    enum PhotoDownloadHandlerError: Error {
        case noSuccess;
        case invalidJson;
    }
    
    func fetchFlickrUserGalleries(completion: @escaping ((posters:[PosterGallery]?, error:PhotoDownloadHandlerError?)) -> Void){
        Alamofire.request(PhotoDownloadHandler.FLICKR_URL,
                          method: .get,
                          parameters: [PhotoDownloadHandler.FLICKR_METHOD:PhotoDownloadHandler.FLICKR_METHOD_GET_GALLERIES, PhotoDownloadHandler.FLICKR_PARAM_API_KEY:PhotoDownloadHandler.flickr_API_KEY, PhotoDownloadHandler.FLICKR_PARAM_USER_ID:PhotoDownloadHandler.FLICKR_USER_ID, PhotoDownloadHandler.FLICKR_PARAM_FORMAT:PhotoDownloadHandler.FLICKR_FORMAT, PhotoDownloadHandler.FLICKR_PARAM_NOJSONCALLBACK: PhotoDownloadHandler.FLICKR_NOJSONCALLBACK])
            .validate()
            .responseJSON { response in
                print(response.request!);
                guard response.result.isSuccess else {
                    completion((posters:nil, error:PhotoDownloadHandlerError.noSuccess));
                    return
                }
                
                guard let value = response.result.value else {
                    completion((posters:nil, error:PhotoDownloadHandlerError.invalidJson));
                    return
                }
                print(JSON(value))
                var galleries:[PosterGallery] = [];
                if let nodes = JSON(value)["galleries"]["gallery"].array {
                    for node in nodes {
                        galleries.append(PosterGallery(id: node["id"].string ?? "-1", name: node["title"]["_content"].string, posters: nil));
                    }
                }
                completion((galleries, nil));
        }
    }
    
    func downloadPhotosFor(gallery:PosterGallery!, completion: @escaping ((posters:[Poster]?, error:PhotoDownloadHandlerError?)) -> Void){
        Alamofire.request(PhotoDownloadHandler.FLICKR_URL,
                          method: .get,
                          parameters: [PhotoDownloadHandler.FLICKR_METHOD:PhotoDownloadHandler.FLICKR_METHOD_GET_GALLERY_PICS, PhotoDownloadHandler.FLICKR_PARAM_API_KEY:PhotoDownloadHandler.flickr_API_KEY, PhotoDownloadHandler.FLICKR_PARAM_GALLERYID:gallery.id, PhotoDownloadHandler.FLICKR_PARAM_FORMAT:PhotoDownloadHandler.FLICKR_FORMAT, PhotoDownloadHandler.FLICKR_PARAM_NOJSONCALLBACK: PhotoDownloadHandler.FLICKR_NOJSONCALLBACK])
            .validate()
            .responseJSON { response in
                print(response.request!);
                guard response.result.isSuccess else {
                    completion((posters:nil, error:PhotoDownloadHandlerError.noSuccess));
                    return
                }
                
                guard let value = response.result.value else {
                    completion((posters:nil, error:PhotoDownloadHandlerError.invalidJson));
                    return
                }
                print(JSON(value))
                var poster:[Poster] = [];
                if let nodes = JSON(value)["photos"]["photo"].array {
                    for node in nodes {
                        poster.append(Poster.init(id: node["id"].stringValue, serverId: node["server"].stringValue, farmId: node["farm"].stringValue, secret: node["secret"].stringValue));
                    }
                }
                completion((poster, nil));
        }
    }
}
