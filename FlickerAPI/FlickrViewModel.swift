//
//  FlickrViewModel.swift
//  FlickerAPI
//
//  Created by Soma Sharma on 16/06/21.
//

import Foundation
import UIKit

typealias completionHandler = (_ success:Bool) -> Void

struct Constants {
    static let imageEndpoint = "https://live.staticflickr.com"
}
final class FlickrViewModel {
    
    var photoData = [Photo]()
    var isMoreDataAvailable : Bool = true
    func getphotos(_ searchText:String , page:Int , completion: @escaping completionHandler) {
        NetworkManager.getFlickrImages(searchText, page: page) { [weak self] result in
            if result {
                self?.photoData = NetworkManager.photoData
                completion(true)
                
            }
        }
    }
    
      func configureImageUrl(data:Photo) -> String {
       guard let serverId = data.server ,
        let photoId = data.id,
        let secretId = data.secret
        else {return ""}
        let size = "w.jpg"
        let id = "\(photoId)_\(secretId)_\(size)"
        let url = "\(Constants.imageEndpoint)/\(serverId)/\(id)"
        return url
        
    }
    
    func getSections() -> Int {
        return isMoreDataAvailable ? 2 : 1
    }
    
    func getRows(section:Int) -> Int {
        switch section {
        case 0:
            return photoData.count
        case 1:
            return 1
        default:
            return 0
        }
    }
    
  
}



let cache = NSCache<AnyObject , AnyObject>()
extension UIImageView { 
    func imageDownloader(url:String) {
        if  let urls = URL(string: url) {
            if let image = cache.object(forKey: urls as AnyObject) {
                DispatchQueue.main.async { [weak self] in
                self?.image = image as? UIImage
                }
            }
            else {
        URLSession.shared.dataTask(with: urls) { data, response, error in
            
            guard let data = data else {return}
            let image = UIImage(data: data)
            DispatchQueue.main.async { [weak self] in
                cache.setObject(image as AnyObject, forKey:urls as AnyObject)
            self?.image = image
            }
        }.resume()
        }
        }
    }

    
}
