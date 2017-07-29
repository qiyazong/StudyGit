//
//  ViewControllerSchool1.swift
//  yingjing
//
//  Created by 齐亚宗 on 2017/6/24.
//  Copyright © 2017年 qiya. All rights reserved.
//

import UIKit

class ViewControllerSchool1: UIViewController {

    @IBAction func returnbutton(_ sender: Any) {
        
        self.presentingViewController?.dismiss(animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        
        
        let rect1 = CGRect(x: 25, y: 150, width: self.view.frame.width - 50, height: 50)
        let dropBoxView = TGDropBoxView(parentVC: self, title: "请选择院系", items: rigClassChoices, frame: rect1)
        dropBoxView.isHightWhenShowList = true
        //dropBoxView.willShowOrHideBoxListHandler = { (isShow) in
        //if isShow { NSLog("will show choices") }
        //else { NSLog("will hide choices") }
        //}
        dropBoxView.didShowOrHideBoxListHandler = { (isShow) in
            if isShow { NSLog("did show choices") }
            else { NSLog("did hide choices") }
        }
        dropBoxView.didSelectBoxItemHandler = { (row) in
            
            
            
            rigClassName = dropBoxView.currentTitle()
            
            NSLog("selected No.\(row): \(dropBoxView.currentTitle())")
            
        }
        
        self.view.addSubview(dropBoxView)
        
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
