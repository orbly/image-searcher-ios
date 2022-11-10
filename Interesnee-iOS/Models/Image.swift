//
//  Image.swift
//  Interesnee-iOS
//
//  Created by Артем on 10.11.2022.
//

import Foundation

struct Image: Decodable {
    let position: Int
    let thumbnail: URL
    let link: URL
    let original: URL
}

struct ImageData: Decodable {
    let imagesResults: [Image]

    enum CodingKeys: String, CodingKey {
        case imagesResults = "images_results"
    }
}
