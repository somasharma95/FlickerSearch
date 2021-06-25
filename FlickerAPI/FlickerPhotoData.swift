//
//  FlickerPhotoData.swift
//  FlickerAPI
//
//  Created by Soma Sharma on 24/06/21.
//

import Foundation

// MARK: - FlickerPhotoData
struct FlickerPhotoData: Codable {
    let photos: Photos?
    let stat: String?
}

// MARK: - Photos
struct Photos: Codable {
    let photo: [Photo]?
}

// MARK: - Photo
struct Photo: Codable {
    let id, secret, server: String?
}
