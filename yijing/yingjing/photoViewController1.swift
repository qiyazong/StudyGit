//
//  photoViewController.swift
//  yingjing
//
//  Created by 齐亚宗 on 2017/6/1.
//  Copyright © 2017年 qiya. All rights reserved.
//

import UIKit

class photoViewController1: UIViewController , UITableViewDelegate, UITableViewDataSource  {
    
    
    var refreshControl:ZJRefreshControl!
    
    //var catalog = [[String]]()
    
    
    var tableView:UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        //初始化数据
        
        photoCellData.append(["齐亚宗","img1.jpg"])
        photoCellData.append(["苏若瑶","img2.jpg"])
        photoCellData.append(["孟真","img3.jpg"])
        
        
        //创建表视图
        self.tableView = UITableView(frame: self.view.frame, style: .plain)
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        //创建一个重用单元格
        self.tableView!.register(UINib(nibName: "ImageTableViewCell", bundle: nil), forCellReuseIdentifier: "myCell")
        
        
        
        //设置estimateRowHeight属性默认值
        self.tableView.estimatedRowHeight = 44.0
        //roeHieght属性设置为uiTableViewAutomaticDimemsion
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.view.addSubview(self.tableView!)
        
        refreshControl = ZJRefreshControl(scrollView: tableView,refreshBlock: {
            self.dropViewDidBeginRefreshing();
        },loadmoreBlock: {
            self.dropViewDidBeginLoadmore();
        });
        
        refreshControl.setTopOffset(-64);
    }
    //下拉刷新调用的方法
    func dropViewDidBeginRefreshing()->Void{
        print("-----刷新数据-----");
       
            //结束下拉刷新必须调用
            self.refreshControl.endRefreshing();
        
    }
    
    //上拉加载更多调用的方法
    func dropViewDidBeginLoadmore()->Void{
        print("-----加载数据-----");
        
            //结束加载更多必须调用
            self.refreshControl.endLoadingmore();
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return photoCellData.count
    }
    
    
    
    @available(iOS 2.0, *)
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        //同一形式的单元格重复使用
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell",
                                                 for: indexPath) as! ImageTableViewCell
        //获取对应的条目内容
        let entry = photoCellData[indexPath.row]
        //单元格标题和内容设置
        cell.titleLable.text = entry[0]
        //cell.loadImage(name: entry[1])
        cell.netLoadImage(urlString: "http://123.206.129.177/uploads/156.jpg")
        
        print("图")
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.tableView!.deselectRow(at: indexPath, animated: true)
        let itemData = photoCellData[indexPath.row]
        //let a = itemData[0]
        
        //界面跳转
        
        self.performSegue(withIdentifier: "ShowDetailView", sender: itemData)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowDetailView"{
            let controller = segue.destination as! DetailViewController
            controller.itemData = sender as! [String]
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
}
