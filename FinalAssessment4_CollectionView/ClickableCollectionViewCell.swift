//
//  ClickableCollectionViewCell.swift
//  FinalAssessment4_CollectionView
//
//  Created by Chiu Chih-Che on 2016/11/5.
//  Copyright © 2016年 Jeff. All rights reserved.
//

import UIKit

@objc protocol ClickableCollectionViewCellDelegate: class {
    func doCustomClick(itemOfIndex: Int)
}

class ClickableCollectionViewCell: UICollectionViewCell {
    weak var delegate: ClickableCollectionViewCellDelegate?
    var itemOfIndex: Int?
    
    @IBOutlet weak var button: UIButton!
    
    @IBAction func doCustomClick(sender: AnyObject) {
        delegate!.doCustomClick(itemOfIndex!)
    }
}
