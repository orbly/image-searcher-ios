//
//  DetailImageViewController.swift
//  Interesnee-iOS
//
//  Created by Артем on 10.11.2022.
//

import UIKit
import Kingfisher

class DetailImageViewController: UIViewController {

    @IBOutlet weak var nextButton: UIBarButtonItem!
    @IBOutlet weak var previousButton: UIBarButtonItem!
    @IBOutlet weak var fullImageView: UIImageView!
    
    weak var viewModel: ImageDataViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()

        updateUI()
    }

    private func updateUI() {
        previousButton.isEnabled = viewModel.isStart()

        nextButton.isEnabled = viewModel.isEnd()

        fullImageView.kf.indicatorType = .activity
        fullImageView.kf.setImage(with: viewModel.imageViewModelForSelectedCell()?.originalImage)
    }

    @IBAction func prevButtonPressed(_ sender: UIBarButtonItem) {
        viewModel.selectedIndex -= 1

        updateUI()
    }

    @IBAction func nextButtonPressed(_ sender: UIBarButtonItem) {
        viewModel.selectedIndex += 1

        updateUI()
    }
    

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let webSourceVC = segue.destination as? WebSourceViewController else {
            fatalError("WebSourceViewController not found!")
        }

        webSourceVC.sourceUrl = viewModel.imageViewModelForSelectedCell()?.sourceUrl

    }

}
