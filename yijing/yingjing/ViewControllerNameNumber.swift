//
//  ViewControllerNameNumber.swift
//  yingjing
//
//  Created by 齐亚宗 on 2017/6/18.
//  Copyright © 2017年 qiya. All rights reserved.
//

import UIKit

class ViewControllerNameNumber: UIViewController {
    
    @IBAction func returnButton(_ sender: Any) {
        self.presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    @IBOutlet weak var name: UITextField!
    
    
    @IBOutlet weak var number: UITextField!
    
    
    @IBOutlet weak var sureButton: UIButton!
    
    @IBAction func sureButtonAction(_ sender: Any) {
        
        rigStudyNumber = number.text!
        
        rigName = name.text!
        
        self.performSegue(withIdentifier: "sure", sender: self)
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
