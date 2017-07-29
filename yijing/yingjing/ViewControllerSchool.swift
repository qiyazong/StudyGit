//
//  ViewControllerSchool.swift/Users/qiyazong/Desktop/project/yingjing5/yingjing
//  yingjing
//
//  Created by 齐亚宗 on 2017/6/18.
//  Copyright © 2017年 qiya. All rights reserved.
//

import UIKit


var rigClassChoices = [String]()

var rigSchool = ""
var rigClassName = ""
var rigStudyNumber = ""
var rigName = ""
var rigPhoneNumber = ""
var rigPassword = ""
var rigCode = ""


class ViewControllerSchool: UIViewController {
    
    
    @IBAction func nextButtonButton(_ sender: Any) {
    }
    @IBOutlet weak var nextButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //self.view.backgroundColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1)
        
        let school = ["中央戏剧学院":["表演系","舞台美术系"],"北京电影学院":["111","222","333"],"中国传媒大学":["表演系","播音主持系"],"中央音乐学院":["声乐系","器乐系"]]
        
        let defaultTitle = "请选择 学校"
        
        var schoolChoices = Array(school.keys)
        
        
        
        //let choices = ["中央戏剧学院", "北京电影学院", "中央音乐学院", "中国传媒大学"]
        let rect1 = CGRect(x: 25, y: 150, width: self.view.frame.width - 50, height: 50)
        let dropBoxView = TGDropBoxView(parentVC: self, title: defaultTitle, items: schoolChoices , frame: rect1)
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
            
            rigClassChoices = school[dropBoxView.currentTitle()]!
            
            rigSchool = dropBoxView.currentTitle()
            
            NSLog("selected No.\(row): \(dropBoxView.currentTitle())")
            
        }
        
        
        
        
        
        
        self.view.addSubview(dropBoxView)
        
        //self.view.addSubview(dropBoxView1)
        // Do any additional setup after loading the view, typically from a nib.
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
