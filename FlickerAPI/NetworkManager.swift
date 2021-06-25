//
//  NetworkManager.swift
//  FlickerAPI
//
//  Created by Soma Sharma on 16/06/21.
//

import Foundation


var searchText = ""
let apiKey = "aeafe065ace713b9cedb10b958dfa6a3"
var perPage = 10
let format = "format=json&nojsoncallback=1"
var url = ""
let endPoint = "https://www.flickr.com/services/rest"
let method = "method=flickr.photos.search"

enum error:Swift.Error {
    case generic
    case unknownApiResponse
}

class NetworkManager {
    
    static var photoData = [Photo]()
    
    
    static func getFlickrImages(_ searchKey : String , page : Int ,completion:  @escaping completionHandler) {
        searchText = searchKey
        perPage = page
        url = "\(endPoint)/?\(method)&api_key=\(apiKey)&text=\(searchText)&per_page=\(perPage)&\(format)"
        if let url = URL(string: url) {
            let session = URLSession.shared
            session.dataTask(with: url) { (data, response, error) in
                guard let data = data  else {return}
                parseData(json: data)
                completion(true)
            }.resume()
        }
    }
    
    static func parseData(json:Data) {
        
        let decoder = JSONDecoder()
        do {
            let jsonData = try decoder.decode(FlickerPhotoData.self, from: json)
            photoData = jsonData.photos?.photo ?? []
        }
        catch let error {
            print(error)
        }
    }
    
}


