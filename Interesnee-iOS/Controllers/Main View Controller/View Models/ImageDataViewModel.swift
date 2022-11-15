//
//  ImageDataViewModel.swift
//  Interesnee-iOS
//
//  Created by Артем on 14.11.2022.
//

import UIKit

class ImageDataViewModel {

    private var images: [Image] = []

    var selectedIndex: Int = 0

    private let networkManager: NetworkManager

    var numberOfImages: Int {
        return images.count
    }

    init(networkManager: NetworkManager = NetworkManager()) {
        self.networkManager = networkManager
    }
}

extension ImageDataViewModel {

    func clearResult() {
        images = []
    }

    func imageViewModel(for indexPath: IndexPath) -> ImageViewModel {
        let image = images[indexPath.row]
        return ImageViewModel(image: image)
    }

    func selectCell(atIndex index: Int) {
        self.selectedIndex = index
    }

    func imageViewModelForSelectedCell() -> ImageViewModel? {
        return ImageViewModel(image: images[selectedIndex])
    }
}

extension ImageDataViewModel {
    
    func isStart() -> Bool {
        return selectedIndex == 0 ? false : true
    }

    func isEnd() -> Bool {
        return selectedIndex == numberOfImages - 1 ? false : true
    }

}


//MARK: - Search
extension ImageDataViewModel {

    func search(with query: String?, pageNumber: Int, completion: @escaping () -> ()) {
        guard let query = query else { return }
        networkManager.fetchImages(query: query, pageNumber: pageNumber) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let imageData):
                self.images += imageData.imagesResults
                completion()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }

}
