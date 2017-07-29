//
//  ImageTableViewCell.swift
//  yingjing
//
//  Created by 齐亚宗 on 2017/6/1.
//  Copyright © 2017年 qiya. All rights reserved.
//

extension UIView {
    //返回该view所在VC
    func firstViewController() -> UIViewController? {
        for view in sequence(first: self.superview, next: { $0?.superview }) {
            if let responder = view?.next {
                if responder.isKind(of: UIViewController.self){
                    return responder as? UIViewController
                }
            }
        }
        return nil
    }
}

import UIKit

class ImageTableViewCell: UITableViewCell {
    
    func constraint(aspect:CGFloat){
        
        print("图片约束")
        
        
        //设置imageView宽高比约束
        aspectConstaint = NSLayoutConstraint(item: contentImageView,
                                             attribute: .width, relatedBy: .equal,
                                             toItem: contentImageView, attribute: .height,
                                             multiplier: aspect, constant: 0.0)
        
    }
    @IBAction func headPhotoButton(_ sender: Any) {
        
        
        let vc = firstViewController()
        
        
        
        vc?.performSegue(withIdentifier: "showPerson", sender: nil)
        
    }
    @IBOutlet weak var headPhoto: UIButton!
    //@IBAction func head(_ sender: Any) {
        
    //}

    @IBOutlet weak var contentImageView: UIImageView!
    
    @IBOutlet weak var titleLable: UILabel!
    
    
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
    
    func netLoadImage(urlString: String) {
        //定义NSURL对象
        let url = URL(string: urlString)
        let data = try? Data(contentsOf: url!)
        //从网络获取数据流,再通过数据流初始化图片
        if let imageData = data, let image = UIImage(data: imageData) {
            //计算原始图片的宽高比
            let aspect = image.size.width / image.size.height
            //设置imageView宽高比约束
            aspectConstaint = NSLayoutConstraint(item: contentImageView,
                                                 attribute: .width, relatedBy: .equal,
                                                 toItem: contentImageView, attribute: .height,
                                                 multiplier: aspect, constant: 0.0)
            //加载图片
            contentImageView.image = image
        }else{
            //去除imageView里的图片和宽高比约束
            aspectConstaint = nil
            contentImageView.image = nil
        }
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




