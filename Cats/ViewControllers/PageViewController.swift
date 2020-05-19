//
//  PageViewController.swift
//  Cats
//
//  Created by Aleksei Chupriienko on 15.05.2020.
//  Copyright © 2020 Aleksei Chupriienko. All rights reserved.
//

import UIKit

class PageViewController: UIPageViewController {
    
    
    // MARK: - Public Properties
    
    var imageURLs: [String]?
    var currentURL: String?
    
    //MARK: - Private Properties
    
    private var imageIndex: Int?
    private let doneButton = UIButton()

    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.dataSource = self
        setUpBackground()
        setUpButton()
        addTapGesture()
        setUpInitialViewController()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = false
    }
    
    //MARK: - Private Methods
    
    @objc private func hideButton() {
        doneButton.isHidden = doneButton.isHidden ? false : true
    }
    
    @objc private func doneButtonAction() {
        navigationController?.popViewController(animated: true)
    }
    
    private func addTapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideButton))
        view.addGestureRecognizer(tapGesture)
    }
    
    private func setUpBackground() {
        view.backgroundColor = UIColor.black
    }
    
    private func setUpInitialViewController() {
        if imageURLs != nil, currentURL != nil, let index = imageURLs?.firstIndex(of: currentURL!), let vc = viewControllerAtIndex(index: index)
        {
            self.setViewControllers([vc], direction: .forward, animated: false, completion: nil)
        }
    }
    
    private func setUpButton() {
        doneButton.frame = CGRect(x: self.view.frame.size.width - 74, y: 40 , width: 54, height: 30)
        doneButton.setTitle("Done", for: .normal)
        doneButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        doneButton.setTitleColor(.white, for: .normal)
        doneButton.layer.borderColor = UIColor.white.cgColor
        doneButton.layer.borderWidth = 2
        doneButton.layer.cornerRadius = 5
        doneButton.addTarget(self, action: #selector(doneButtonAction), for: .touchUpInside)
        view.addSubview(doneButton)
    }
        
    private func viewControllerAtIndex(index: Int) -> UIViewController? {
        if 0..<imageURLs!.count ~= index, let vc = storyboard?.instantiateViewController(withIdentifier: Constants.zoomedId) as? ZoomedImageViewController {
            vc.urlString = imageURLs![index]
            imageIndex = index
            return vc
        }
        return nil
    }
    
}

extension PageViewController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        if let vc = viewController as? ZoomedImageViewController, let index = imageURLs?.firstIndex(of: vc.urlString!) {
            currentURL = vc.urlString
            let indexBefore = index - 1
            return viewControllerAtIndex(index: indexBefore)
        }
        return nil
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        if let vc = viewController as? ZoomedImageViewController, let index = imageURLs?.firstIndex(of: vc.urlString!) {
            let indexAfter = index + 1
            return viewControllerAtIndex(index: indexAfter)
        }
        return nil
    }
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        if imageURLs != nil {
            return imageURLs!.count
        }
        return 0
    }
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        if imageIndex != nil {
            return imageIndex!
        }
        return 0
    }
    
}
