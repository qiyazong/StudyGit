//
//  ViewControllerPlus.swift
//  yingjing
//
//  Created by 齐亚宗 on 2017/5/30.
//  Copyright © 2017年 qiya. All rights reserved.
//

import UIKit
import Alamofire
import Sharaku


class ViewControllerPlus: UITabBarController,UIImagePickerControllerDelegate,UINavigationControllerDelegate ,SHViewControllerDelegate{
    
    func shViewControllerImageDidFilter(image: UIImage) {
        
        
        //获取缩放比例
        
        
        //获取选择的原图
        
        let pickerImage = image
        //将选择的图片保存到Document目录下
        let fileManager = FileManager.default
        let rootPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String
        let filePath = "\(rootPath)/pickedImage.jpg"
        let imageData = UIImageJPEGRepresentation(pickerImage, 0)
        fileManager.createFile(atPath: filePath, contents: imageData, attributes: nil)
        
        
        //上传图片
        if (fileManager.fileExists(atPath: filePath)){
            //取得nsurl
            let imageNSURL:URL = URL.init(fileURLWithPath: filePath)
            
            print("woshishei")
            
            //使用alamofire上传
            Alamofire.upload(imageNSURL, to: "http://123.206.129.177/hanggephoto.php")
                .responseString { response in
                    print("Success: \(response.result.isSuccess)")
                    print("Response String: \(String(describing: response.result.value))")
            }
            
            
        }

        
        
    }
    
    func shViewControllerDidCancel() {
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.addCenterButton(btnimage: UIImage(named: "button_add")!, selectedbtnimg: UIImage(named: "button_add")!, selector: "addOrderView", view: self.view)
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    //参数说明
    //btnimage 按钮图片
    //selectedbtnimg 点击时图片
    //selector 按钮方法名称
    //view 按钮添加到view  正常是 self.view就可以
    func addCenterButton(btnimage buttonImage:UIImage,selectedbtnimg selectedimg:UIImage,selector:String,view:UIView)
    {
        //创建一个自定义按钮
        let button:UIButton = UIButton(type: UIButtonType.custom)
        //btn.autoresizingMask
        //button大小为适应图片
        button.frame = CGRect(x: 0, y: 0, width: buttonImage.size.width, height: buttonImage.size.height)
        
        button.setImage(buttonImage, for: UIControlState.normal)
        button.setImage(selectedimg, for: UIControlState.selected)
        //去掉阴影
        button.adjustsImageWhenDisabled = true;
        //按钮的代理方法
        button.addTarget( self, action: Selector(selector), for:UIControlEvents.touchUpInside )
        //高度差
        let heightDifference:CGFloat = buttonImage.size.height - self.tabBar.frame.size.height
        if (heightDifference < 0){
            button.center = self.tabBar.center;
        }
        else
        {
            var center:CGPoint = self.tabBar.center;
            center.y = center.y - heightDifference/2.0;
            button.center = center;
        }
        view.addSubview(button);
    }
    
    
    //按钮方法
    func addOrderView()
    {
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
            /*//初始化图片控制器
            let picker = UIImagePickerController()
            //设置代理
            picker.delegate = self
            //指定图片控制器类型
            picker.sourceType = UIImagePickerControllerSourceType.photoLibrary
            //设置是否允许编辑
            //picker.allowsEditing = true            
            //弹出控制器，显示界面
            self.present(picker, animated: true, completion: {
                () -> Void in
            })*/
            let sb = UIStoryboard(name: "Main2", bundle:nil)
            let vc = sb.instantiateViewController(withIdentifier: "navation1")
            self.present(vc, animated: true, completion: nil)
            
            
        }else{
            print("读取相册错误")
            print("wewe")
        }

    }
    //选择图片成功后代理
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        //获取选择的原图
        let pickerImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        //将选择的图片保存到Document目录下
        let fileManager = FileManager.default
        let rootPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String
        let filePath = "\(rootPath)/pickedImage.jpg"
        let imageData = UIImageJPEGRepresentation(pickerImage, 1.0)
        fileManager.createFile(atPath: filePath, contents: imageData, attributes: nil)
        
        
        //上传图片
        if (fileManager.fileExists(atPath: filePath)){
            //取得nsurl
            let imageNSURL:URL = URL.init(fileURLWithPath: filePath)
            
            //使用alamofire上传
            Alamofire.upload(imageNSURL, to: "http://123.206.129.177/hanggephoto.php")
                .responseString { response in
                    print("Success: \(response.result.isSuccess)")
                    print("Response String: \(String(describing: response.result.value))")
            }
            picker.dismiss(animated: true, completion: nil)
            
            
        }
        
        
    }

    
}
