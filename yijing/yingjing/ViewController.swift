//
//  ViewController.swift
//  yingjing
//
//  Created by 齐亚宗 on 2017/5/28.
//  Copyright © 2017年 qiya. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

let userID = UserDefaults.standard.string(forKey: "userID")

let password1 = UserDefaults.standard.string(forKey: "password1")


class ViewController: UIViewController {
    
    @IBAction func viewClick(_ sender: Any) {
        self.view.endEditing(true)
    }
    
    @IBOutlet weak var phoneNumber: UITextField!
    
    @IBAction func phoneNumberReturn(_ sender: Any) {
        resignFirstResponder()
    }
    
    @IBAction func psReturn(_ sender: Any) {
        resignFirstResponder()
    }
    @IBOutlet weak var password: UITextField!
    
    
    
    
    @IBAction func login(_ sender: Any) {
        
        
        
        var ID = ""
        
        var password = ""
        
        
        
            ID = phoneNumber.text!
        
        
       
            password = self.password.text!
        
    
        
        
        
        if ID.characters.count != 0{
        
        Alamofire.request("http://123.206.129.177/old/mongodb/index1.php", method: .get, parameters: ["tag": "login","phoneNumber":ID,"password":password])
            
            .responseJSON { response in
                
                
                
                let result = JSON(response.result.value)
                if let sec = result["stat"].string{
                    
                    
                    if sec == "true"{
                        //let a = UserDefaults.standard.bool(forKey: "loginBool")
                        
                        UserDefaults.standard.set(ID, forKey: "userID")
                        UserDefaults.standard.set(password, forKey: "password1")
                        UserDefaults.standard.set(true, forKey: "loginBool")
                        self.performSegue(withIdentifier: "login", sender: self)
                    }else{
                        
                        let alertController = UIAlertController(title: "提示",
                                                                message: "手机号或密码错误", preferredStyle: .alert)
                       // let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
                        let okAction = UIAlertAction(title: "好的", style: .default, handler: nil)
                        //alertController.addAction(cancelAction)
                        alertController.addAction(okAction)
                        self.present(alertController, animated: true, completion: nil)
                    }
                }
                
                
            }
        }
        else{
            let alertController = UIAlertController(title: "提示",
                                                    message: "请输入手机号和密码", preferredStyle: .alert)
            // let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
            let okAction = UIAlertAction(title: "好的", style: .default, handler: nil)
            //alertController.addAction(cancelAction)
            alertController.addAction(okAction)
            self.present(alertController, animated: true, completion: nil)
        }
        
 
        
    }
    
    @IBOutlet weak var creatID: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        phoneNumber.text = UserDefaults.standard.string(forKey: "userID")
        
        password.text = UserDefaults.standard.string(forKey: "password1")
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        
        // Dispose of any resources that can be recreated.
    }
  
}

