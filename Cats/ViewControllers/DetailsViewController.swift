//
//  DetailsViewController.swift
//  Cats
//
//  Created by Aleksei Chupriienko on 04.05.2020.
//  Copyright © 2020 Aleksei Chupriienko. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {
    
    //MARK: - IBOutlets
    
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var information: UITextView!
    @IBOutlet weak var showMoreImagesButton: UIButton!
    

    // MARK: - Public Properties
    
    var breed: Breed? = nil
    var url: URL? = nil
    
    //MARK: - Private Properties
    
    private let loader = ImageLoader.shared
    private let service = CatsServiceAPI.shared
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    //MARK: - Private Methods
    
    private func setupUI() {
        setLoadingView()
        
        if breed != nil {
            let myBreed = breed!
            if url != nil {
                setUpImage(url: url!)
            } else {
                service.fetchImageURLs(id: myBreed.id, for: .singleImage) { (result) in
                    switch result{
                    case .success(let urls):
                        if let urlString = urls.first, let url = URL(string: urlString) {
                            self.setUpImage(url: url)
                        }
                    case .failure(let error):
                        DispatchQueue.main.async {
                            self.showAlert(message: "When loading image\n\(error.localizedDescription.lowercased())")
                            self.removeLoadingView()
                        }
                    }
                }
            }
            
            let buttonTitle = "Show more \(myBreed.name) pictures"
            showMoreImagesButton.setTitle(buttonTitle, for: .normal)
            showMoreImagesButton.titleLabel?.textAlignment = .center
            let attributes = makeAttributes(myBreed)
            let content = makeContent(attributes: attributes)
            information.attributedText = content
        }
    }
    
    private func setUpImage(url: URL) {
        loader.loadImage(url) { (result) in
            switch result {
            case .success(let image):
                DispatchQueue.main.async {
                    self.imageView.image = image
                    self.removeLoadingView()
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self.removeLoadingView()
                    self.showAlert(message: "While downloading image\n\(error.localizedDescription.lowercased())")
                }
            }
        }
    }
    
    private func starsProduction(indicator: Int) -> String{
        var stars = ""
        for _ in 1...indicator {
            stars += "⭐️"
        }
        return stars
    }
    
    private func checkForTrue(value: Int) -> String {
        return value == 1 ? "✅" : "❌"
    }
    
    private func makeContent(attributes: [String]) -> NSMutableAttributedString {
        let font = UIFont.systemFont(ofSize: 20)
        let keys: [NSMutableAttributedString.Key: Any] = [.font: font]
        let text = NSMutableAttributedString(string: "", attributes: keys)
        for attribute in attributes {
            if !attribute.isEmpty {
                text.append(NSMutableAttributedString(string: attribute, attributes: keys))
                if attribute != attributes.last! {
                    text.append(NSMutableAttributedString(string: "\n", attributes: keys))
                }
            }
        }
        return text
    }
    
    private func makeAttributes(_ myBreed: Breed ) -> [String] {
        let breedName = "breed:\n" + myBreed.name
        let description = "description:\n" + myBreed.description
        let weight = "weight:\n" + myBreed.weight.imperial + " lb(s)" + "\n" + myBreed.weight.metric + " kg(s)"
        let lifespan = "lifespan:\n" + myBreed.lifeSpan + " years"
        let temperament = "temperament:\n" +  myBreed.temperament
        let origin = "origin:\n" + myBreed.origin + " " + myBreed.countryCode.getFlag()
        var alternativeNames: String {
            if let names = myBreed.altNames, !names.trimmingCharacters(in: .whitespaces).isEmpty {
                return "alternative names:\n" + names
            }
            return ""
        }
        let experimental = "experimental: " + checkForTrue(value: myBreed.experimental)
        let hairless = "hairless: " + checkForTrue(value: myBreed.hairless)
        let natural = "natural: " + checkForTrue(value: myBreed.natural)
        let rare = "rare: " + checkForTrue(value: myBreed.rare)
        let rex = "rex: " + checkForTrue(value: myBreed.rex)
        let suppressedTail = "suppressed tail: " + checkForTrue(value: myBreed.suppressedTail)
        let shortLegs = "short legs: " + checkForTrue(value: myBreed.shortLegs)
        let hypoallergenic = "hypoallergenic: " + checkForTrue(value: myBreed.hypoallergenic)
        let adaptabilty = "adaptability: " + starsProduction(indicator: myBreed.adaptability)
        let affectoinLevel = "affection level: " + starsProduction(indicator: myBreed.affectionLevel)
        let childFriendly = "child friendly: " + starsProduction(indicator: myBreed.childFriendly)
        let dogFriendly = "dog friendly: " + starsProduction(indicator: myBreed.dogFriendly)
        let energyLevel = "energy level: " + starsProduction(indicator: myBreed.energyLevel)
        let grooming = "grooming: " + starsProduction(indicator: myBreed.grooming)
        let healthIssues = "health issues: " + starsProduction(indicator: myBreed.healthIssues)
        let intelligence = "intelligence: " + starsProduction(indicator: myBreed.intelligence)
        let sheddingLevel = "shedding level: " + starsProduction(indicator: myBreed.sheddingLevel)
        let socialNeeds = "social needs: " + starsProduction(indicator: myBreed.socialNeeds)
        let strangerFriendly = "stranger friendly: " + starsProduction(indicator: myBreed.strangerFriendly)
        let vocalisation = "vocalisation: " + starsProduction(indicator: myBreed.vocalisation)
        var informationAdditional: String {
            var info = "additional info:\n"
            if let wikiUrl: String = myBreed.wikipediaUrl {
                info += wikiUrl
            }
            if let cfaUrl: String = myBreed.cfaUrl {
                info += "\n" + cfaUrl
            }
            if let vetstreetUrl: String = myBreed.vetstreetUrl {
                info += "\n" + vetstreetUrl
            }
            if let vcahospitalsUrl: String = myBreed.vcahospitalsUrl {
                info += "\n" + vcahospitalsUrl
            }
            return info
        }
        let attributes = [breedName, description, weight, lifespan, temperament, origin,
                      alternativeNames, experimental, hairless, natural, rare, rex,
                      suppressedTail, shortLegs, hypoallergenic, adaptabilty,
                      affectoinLevel, childFriendly, dogFriendly, energyLevel, grooming,
                      healthIssues, intelligence, sheddingLevel, socialNeeds,
                      strangerFriendly, vocalisation, informationAdditional]
        
        return attributes
    }
    
    
    // MARK: - IBActions
    
    @IBAction func showMoreImagesButtonAction(_ sender: UIButton) {
        if let galleryVC = storyboard?.instantiateViewController(withIdentifier: Constants.galleryId) as? GalleryViewController {
            galleryVC.id = breed?.id
            galleryVC.navigationItem.title = breed?.name
            navigationController?.pushViewController(galleryVC, animated: true)
        }
    }
    
}

extension DetailsViewController: Loadable {
    func setLoadingView() {
        DispatchQueue.main.async {
            if #available(iOS 13.0, *) {
                self.spinner.style = .large
            } else {
                self.spinner.style = .whiteLarge
                self.spinner.color = .systemGray
            }
            self.spinner.startAnimating()
        }
    }
    
    func removeLoadingView() {
        DispatchQueue.main.async {
            self.spinner.stopAnimating()
        }
    }
    
}
