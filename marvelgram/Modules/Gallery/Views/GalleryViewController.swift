//
//  GalleryViewController.swift
//  marvelgram
//
//  Created by Mikhail Chaus on 07.06.2022.
//

import UIKit

class GalleryViewController: UIViewController {
    // MARK: - Public Properties
    
    var presenter: GalleryPresenterProtocol?

    // MARK: - UIViewController Lifecycle
    
    override func loadView() {
        let view = GalleryView()
        view.uiDelegate = self
        self.view = view
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

// MARK: - GalleryViewUiDelegate

extension GalleryViewController: GalleryViewUiDelegate {
}

// MARK: - GalleryViewProtocol

extension GalleryViewController: GalleryViewProtocol {
}
