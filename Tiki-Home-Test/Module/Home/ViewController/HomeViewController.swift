//
//  HomeViewController.swift
//  Tiki-Home-Test
//
//  Created by HUYNH Hoc Luan on 3/21/19.
//  Copyright © 2019 Luan Huynh. All rights reserved.
//

import UIKit
import Alamofire

class HomeViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet var iconImageViews: [UIImageView]!
    @IBOutlet weak var collectionViewContainView: UIView!
    
    // MARK: - Properties
    var viewModel: HomeViewModel?
    var flowLayout: UICollectionViewFlowLayout {
        return self.collectionView?.collectionViewLayout as! UICollectionViewFlowLayout
    }
    
    // MARK: - Override Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        registerCells()
        initViewModel()
        setupCollectionView()
        requestAPIToGetData()
        setupView()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    // MARK: - Functions
    private func initViewModel() -> Void {
        if viewModel == nil {
            viewModel = HomeViewModel()
        }
    }
    
    private func registerCells() -> Void {
        collectionView.register(UINib(nibName: KeywordCell.cellIdentifier, bundle: Bundle.main), forCellWithReuseIdentifier: KeywordCell.cellIdentifier)
    }
    
    private func setupCollectionView() -> Void {
        self.flowLayout.estimatedItemSize = CGSize(width: collectionView.frame.width, height: 150)
        collectionView.dataSource = self
        
    }
    
    private func reloadData() -> Void {
        self.collectionView.reloadData()
    }
    
    private func setupView() -> Void {
        collectionViewContainView.setShadow()
        
        for iconImage in iconImageViews {
            iconImage.image = iconImage.image?.withRenderingMode(.alwaysTemplate)
            iconImage.tintColor = UIColor.white
        }

        if let searchTextField = searchBar.value(forKey: "searchField") as? UITextField {
            if let backgroundview = searchTextField.subviews.first {
                // Background color
                backgroundview.backgroundColor = UIColor.white
                // Rounded corner
                backgroundview.layer.cornerRadius = 10;
                backgroundview.clipsToBounds = true;
            }
        }

        
    }
    
    
    // MARK: - Request API
    private func requestAPIToGetData() -> Void {
        Repository.requestAPIToGetData { [weak self] (isSuccess, keywords) in
            guard let this = self else { return }
            if isSuccess {
                this.viewModel?.listKeywords = keywords
                this.reloadData()
            }
        }
    }


}

extension HomeViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.viewModel?.listKeywords.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: KeywordCell.cellIdentifier, for: indexPath) as! KeywordCell
        if let keyword = self.viewModel?.listKeywords[indexPath.row], let model = self.viewModel?.initKeywordCellModel(keyword: keyword, index: indexPath.row) {
            cell.initData(model: model)
        }
        
        return cell
    }
    
    
}


