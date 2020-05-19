//
//  ViewController.swift
//  Cats
//
//  Created by Aleksei Chupriienko on 30.04.2020.
//  Copyright © 2020 Aleksei Chupriienko. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    //MARK: - IBOutlets
    
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: - Private Properties
    
    private let service = CatsServiceAPI.shared
    private let loader = ImageLoader.shared
    private var breeds = Breeds()
    private var imageUrls = [String: String]()
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableFooterView = UIView()
        updateData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    //MARK: - Private Methods
    
    private func updateData() {
        setLoadingView()
        service.fetchBreeds { (breeds) in
            switch breeds {
            case .success(let breeds):
                self.breeds = breeds
                DispatchQueue.main.async {
                    self.removeLoadingView()
                    self.tableView.reloadData()
                }
                self.breeds.forEach { (breed) in
                    self.service.fetchImageURLs(id: breed.id, for: .singleImage) { (result) in
                        switch result {
                        case .success(let urls):
                            DispatchQueue.main.async {
                                self.imageUrls[breed.id] = urls.first
                                if self.imageUrls.count == breeds.count {
                                    self.tableView.reloadData()
                                }
                            }
                        case .failure(let error):
                            print(error.localizedDescription)
                        }
                    }
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self.removeLoadingView()
                    self.showAlert(message: error.localizedDescription)
                }
            }
        }
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        breeds.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.tableCell, for: indexPath) as? CatBreedCell else { return UITableViewCell()
        }
        let breed = breeds[indexPath.row]
        cell.label.text = breed.name
        if let urlString = imageUrls[breed.id], let url = URL(string: urlString) {
            let token = loader.loadImage(url, completion: { (result) in
                switch result {
                case .success(let image):
                    DispatchQueue.main.async {
                        cell.picture.image = image
                    }
                case .failure(_):
                    break
                }
            })
            cell.onReuse = {
                if let token = token {
                    self.loader.cancelLoad(token)
                }
            }
        }
        return cell
    }
    
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let breed = breeds[indexPath.row]
        if let detailsVC = storyboard?.instantiateViewController(withIdentifier: Constants.detailsId) as? DetailsViewController {
            if let urlString = imageUrls[breed.id], let url = URL(string: urlString) {
                detailsVC.url = url
            }
            detailsVC.breed = breed
            navigationController?.pushViewController(detailsVC, animated: true)
        }
    }
    
}

extension ViewController: Loadable {}
