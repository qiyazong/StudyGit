//
//  personImageTableViewCell.swift
//  yingjing
//
//  Created by 齐亚宗 on 2017/6/24.
//  Copyright © 2017年 qiya. All rights reserved.
//

import UIKit

class personImageTableViewCell: UITableViewCell {
    
    func constraint(aspect:CGFloat){
        
        print("图片约束")
        
        
        //设置imageView宽高比约束
        aspectConstaint = NSLayoutConstraint(item: contentImageView,
                                              attribute: .width, relatedBy: .equal,
                                              toItem: contentImageView, attribute: .height,
                                              multiplier: aspect, constant: 0.0)
        
    }
    
    
    
    
    

    @IBOutlet weak var titleLable: UILabel!
    @IBOutlet weak var contentImageView: UIImageView!
    
    
    
    
    
    //内容图片宽高比约束
    internal var aspectConstaint : NSLayoutConstraint?{
        didSet{
            if oldValue != nil {
                contentImageView.removeConstraint(oldValue!)
            }
            if aspectConstaint != nil{
                contentImageView.addConstraint(aspectConstaint!)
            }
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.selectionStyle = UITableViewCellSelectionStyle.none
    }
    //加载图片内容（并设置高度约束）
    func loadImage(name:String){
        if let image = UIImage(named:name){
            //计算原始图片的宽高比
            let aspect = image.size.width / image.size.height
            //设置imageview的宽高比约束
            aspectConstaint = NSLayoutConstraint(item: contentImageView, attribute: .width, relatedBy: .equal, toItem: contentImageView, attribute: .height, multiplier: aspect, constant: 0.0)
            //加载图片
            contentImageView.image = image
            
        }else{
            //去除imageview里的宽高比约束
            aspectConstaint = nil
            contentImageView.image = nil
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        //清除图片的宽高比约束
        aspectConstaint = nil
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}




