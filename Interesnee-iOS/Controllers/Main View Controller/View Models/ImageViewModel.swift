//
//  ImageViewModel.swift
//  Interesnee-iOS
//
//  Created by Артем on 15.11.2022.
//

import Foundation

struct ImageViewModel {

    private var image: Image

    init(image: Image) {
        self.image = image
    }

    var index: Int {
        return image.position - 1
    }

    var thumbnail: URL? {
        guard let url = URL(string: image.thumbnail) else { return nil }
        return url
    }

    var originalImage: URL? {
        guard let url = URL(string: image.original) else { return nil }
        return url
    }

    var sourceUrl: URL? {
        guard let url = URL(string: image.link) else { return nil }
        return url
    }


}
