//
//  GalleryViewController.swift
//  Cats
//
//  Created by Aleksei Chupriienko on 09.05.2020.
//  Copyright © 2020 Aleksei Chupriienko. All rights reserved.
//

import UIKit

class GalleryViewController: UIViewController {
    
    //MARK: - IBOutlets
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    // MARK: - Public Properties
    
    var id: String?
    
    //MARK: - Private Properties
    
    private let service = CatsServiceAPI.shared
    private var imageURLs = [String]()
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.delegate = self
        loadPictures()
    }
    
    //MARK: - Private Methods
    
    private func loadPictures() {
        if id != nil {
            setLoadingView()
            service.fetchImageURLs(id: id!, for: .multipleImages) { (result) in
                switch result {
                case .success(let urls):
                    self.imageURLs = urls
                    DispatchQueue.main.async {
                        self.removeLoadingView()
                        self.collectionView.reloadData()
                    }
                case .failure(let error):
                    DispatchQueue.main.async {
                        self.removeLoadingView()
                        self.showAlert(message: error.localizedDescription) { (alert) in
                            self.navigationController?.popViewController(animated: true)
                        }
                    }
                }
            }
        }
    }
    
}

extension GalleryViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        imageURLs.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.collectionCell, for: indexPath) as? CatImageViewCell else {
            return UICollectionViewCell()
        }
        if let url = URL(string: imageURLs[indexPath.row]) {
            ImageLoader.shared.loadImage(url) { (result) in
                do {
                    let image = try result.get()
                    DispatchQueue.main.async {
                        cell.imageView.image = image
                    }
                } catch {
                    print(error)
                }
            }
        }
        return cell
    }
    
}

extension GalleryViewController:  UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        if let pageVC = storyboard?.instantiateViewController(withIdentifier: Constants.pageId) as? PageViewController {
            pageVC.imageURLs = imageURLs
            pageVC.currentURL = imageURLs[indexPath.row]
            navigationController?.pushViewController(pageVC, animated: true)
        }
    }
    
}

extension GalleryViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let numOfCellsInRow = 4
        let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout
        let totalSpace = flowLayout.sectionInset.left + flowLayout.sectionInset.right + (flowLayout.minimumInteritemSpacing * CGFloat(numOfCellsInRow - 1))
        let size = Int((collectionView.bounds.width - totalSpace) / CGFloat(numOfCellsInRow))
        return CGSize(width: size, height: size)
    }
    
}

extension GalleryViewController: Loadable {}
