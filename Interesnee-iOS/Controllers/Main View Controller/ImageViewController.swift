//
//  ImageViewController.swift
//  Interesnee-iOS
//
//  Created by Артем on 10.11.2022.
//

import UIKit

class ImageViewController: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var collectionView: UICollectionView!

    private let network = NetworkManager()
    private var images: [Image] = []

    private let itemsPerRow: CGFloat = 2
    private let sectionInserts = UIEdgeInsets(top: 20,
                                              left: 20,
                                              bottom: 20,
                                              right: 20)

    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.dataSource = self
        collectionView.delegate = self

        network.fetchImages(query: "Apple", pageNumber: 0) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let imageData):
                self.images = imageData.imagesResults
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }

}

//MARK: - Flow Layout Delegate
extension ImageViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let paddingWidth = sectionInserts.top * (itemsPerRow + 1)
        let availableWidth = collectionView.frame.width - paddingWidth
        let widthPerItem = availableWidth / itemsPerRow
        return CGSize(width: widthPerItem, height: widthPerItem)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInserts
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInserts.top
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInserts.top
    }

}

//MARK: - Collection View Data Source
extension ImageViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCell", for: indexPath) as? MainViewCollectionViewCell else { fatalError("Cannot find MainViewCollectionViewCell") }

        cell.backgroundColor = .white

        return cell
    }


}

//MARK: - Collection View Delegate
extension ImageViewController: UICollectionViewDelegate {

}

