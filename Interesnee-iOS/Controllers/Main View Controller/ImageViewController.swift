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
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    private var viewModel: ImageDataViewModel!
    private var pageNumber: Int = 0

    private let itemsPerRow: CGFloat = 2
    private let sectionInserts = UIEdgeInsets(top: 20,
                                              left: 20,
                                              bottom: 20,
                                              right: 20)

    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.delegate = self
        collectionView.dataSource = self

        viewModel = ImageDataViewModel()

        activityIndicator.isHidden = true
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
        return viewModel.numberOfImages
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCell", for: indexPath) as? MainViewCollectionViewCell else { fatalError("Cannot find MainViewCollectionViewCell") }

        cell.configure(with: viewModel.imageViewModel(for: indexPath))

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row == viewModel.numberOfImages - 10 {
            pageNumber += 1
            viewModel.search(with: searchBar.text, pageNumber: pageNumber) {
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            }
        }
    }

}

extension ImageViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.selectCell(atIndex: indexPath.row)
    }
}

//MARK: - Search Bar Delegate
extension ImageViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        activityIndicator.isHidden = false
        collectionView.isHidden = true
        activityIndicator.startAnimating()

        searchBar.resignFirstResponder()

        viewModel.clearResult()
        viewModel.search(with: searchBar.text, pageNumber: 0) {
            DispatchQueue.main.async {
                self.collectionView.isHidden = false
                self.collectionView.reloadData()
            }
            self.activityIndicator.stopAnimating()
        }
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()

        viewModel.clearResult()
        searchBar.text = ""

        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
}

//MARK: - Prepare Segue
extension ImageViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let navC = segue.destination as? UINavigationController,
              let detailVC = navC.viewControllers.first as? DetailImageViewController
        else {
            fatalError("Detail controller not found!")
        }

//        guard let selectedIndex = collectionView.indexPathsForSelectedItems?.last?.row else {
//            return
//        }
//        print(selectedIndex)
        
        detailVC.viewModel = viewModel
//        detailVC.selectedIndex = selectedIndex
    }
}
