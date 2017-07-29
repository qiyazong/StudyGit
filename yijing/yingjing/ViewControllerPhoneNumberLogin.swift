//
//  ViewControllerPhoneNumberLogin.swift
//  yingjing
//
//  Created by 齐亚宗 on 2017/6/18.
//  Copyright © 2017年 qiya. All rights reserved.
//

import UIKit

class ViewControllerPhoneNumberLogin: UIViewController {
    
    @IBAction func head(_ sender: Any) {
        
        let sb = UIStoryboard(name: "Main2", bundle:nil)
        let vc = sb.instantiateViewController(withIdentifier: "navation1")
        self.present(vc, animated: true, completion: nil)
    }
    
    @IBOutlet weak var phoneNumber: UITextField!
    
    
    @IBOutlet weak var password: UITextField!
    
    
    
    @IBOutlet weak var code: UITextField!
    
    
    @IBAction func getCode(_ sender: Any) {
        
    }
    
    @IBAction func next(_ sender: Any) {
        rigPhoneNumber = phoneNumber.text!
        rigPassword = password.text!
        rigCode = code.text!
        
        //print(rigPassword, rigPhoneNumber,rigSchool,rigStudyNumber,rigClassName,rigCode,rigName)
        
    }
    
    
    @IBAction func returnButton(_ sender: Any) {
        self.presentingViewController?.dismiss(animated: true, completion: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

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

}
