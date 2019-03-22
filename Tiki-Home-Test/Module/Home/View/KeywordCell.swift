//
//  KeywordCell.swift
//  Tiki-Home-Test
//
//  Created by HUYNH Hoc Luan on 3/22/19.
//  Copyright © 2019 Luan Huynh. All rights reserved.
//

import UIKit
import AlamofireImage

struct KeywordCellModel {
    
    // MARK: - Properties
    var keyword: String? = ""
    var object: Any?
    var cellName: String? = ""
    var imageUrl: String? = ""
    var containViewColor: UIColor = .black
    var keywordLines: Int = 0
    
    // MARK: - Init
    init(keyword: String, cellName: String, imageUrl: String,  containViewColor: UIColor = .black, object: Any? = nil, keywordLines: Int = 0) {
        self.keyword = keyword
        self.cellName = cellName
        self.imageUrl = imageUrl
        self.containViewColor = containViewColor
        self.object = object
        self.keywordLines = keywordLines
    }
}

class KeywordCell: UICollectionViewCell {
    
    // MARK: - Outlets
    @IBOutlet weak var keywordLabel: UILabel!
    @IBOutlet weak var iconImage: UIImageView!
    @IBOutlet weak var containView: UIView!
    
    // MARK: - Properties
    static let cellIdentifier = "KeywordCell"
    var object: Any?
    var cellName: String = ""
    
    // MARK: - Functions
    func initData(model: KeywordCellModel) -> Void {
        keywordLabel.text = model.keyword ?? ""
        keywordLabel.numberOfLines = model.keywordLines
        object = model.object
        cellName = model.cellName ?? ""
        containView.backgroundColor = model.containViewColor
        containView.layer.cornerRadius = 5
        
        if let url = URL(string: model.imageUrl ?? "") {
            iconImage.af_setImage(withURL: url)
        } else {
            iconImage.image = UIImage()
        }
    }
    
    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        let autoLayoutAttributes = super.preferredLayoutAttributesFitting(layoutAttributes)
        let targetSize = CGSize(width: 200, height: 150)
        let autoLayoutSize = contentView.systemLayoutSizeFitting(targetSize, withHorizontalFittingPriority: UILayoutPriority.defaultLow, verticalFittingPriority: UILayoutPriority.required)
        let autoLayoutFrame = CGRect(origin: autoLayoutAttributes.frame.origin, size: autoLayoutSize)

        autoLayoutAttributes.frame = autoLayoutFrame
        return autoLayoutAttributes
    }

}
