//
//  myViewController.swift
//  yingjing
//
//  Created by 齐亚宗 on 2017/6/1.
//  Copyright © 2017年 qiya. All rights reserved.
//

import UIKit

class myViewController: UIViewController , UITableViewDelegate, UITableViewDataSource{

    @IBOutlet weak var tableView: UITableView!
    var catalog = [[String]]()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //初始化数据
        catalog.append(["齐亚宗","img1.jpg"])
        catalog.append(["苏若瑶","img2.jpg"])
        catalog.append(["孟真","img3.jpg"])
        
    
        //创建一个重用单元格
        self.tableView!.register(UINib(nibName: "ImageTableViewCell", bundle: nil), forCellReuseIdentifier: "myCell")
        
        
        
        //设置estimateRowHeight属性默认值
        self.tableView.estimatedRowHeight = 44.0
        //roeHieght属性设置为uiTableViewAutomaticDimemsion
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.view.addSubview(self.tableView!)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return self.catalog.count
    }
    
    
    
    @available(iOS 2.0, *)
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        //同一形式的单元格重复使用
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell",
                                                 for: indexPath) as! ImageTableViewCell
        //获取对应的条目内容
        let entry = catalog[indexPath.row]
        //单元格标题和内容设置
        cell.titleLable.text = entry[0]
        cell.loadImage(name: entry[1])
        
        return cell
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
