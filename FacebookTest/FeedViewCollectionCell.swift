//
//  FeedViewCollectionCell.swift
//  FacebookTest
//
//  Created by Jeffrey Gu on 4/16/17.
//  Copyright © 2017 Jeffrey Gu. All rights reserved.
//

import Foundation
import UIKit
class FeedViewCollectionCell:UICollectionViewCell {
    
    var data:FeedEvent = FeedEvent()
    var textView:UILabel!
    var imageView:UIImageView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.cyan
        
//        let imageLength = frame.size.width*0.25
        let imageLength = CGFloat(50)
        let textOffsetX = CGFloat(75)
        let textOffsetY = CGFloat(10)
        
        imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: imageLength, height: imageLength))
        imageView.contentMode = UIViewContentMode.scaleAspectFit
        contentView.addSubview(imageView)
        
        textView = UILabel(frame: CGRect(x: textOffsetX, y: textOffsetY, width: frame.size.width - imageLength, height: frame.size.height - textOffsetY))
        textView.numberOfLines = 3
        textView.textColor = UIColor.black
        textView.font = UIFont.systemFont(ofSize: UIFont.smallSystemFontSize)
        contentView.addSubview(textView)
        
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
