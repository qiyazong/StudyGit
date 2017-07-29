//
//  DetailViewController.swift
//  yingjing
//
//  Created by 齐亚宗 on 2017/6/4.
//  Copyright © 2017年 qiya. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController ,UITableViewDelegate,UITableViewDataSource{
    
    let Operations = operations()
    let view1 = UIView()
    
    var list = ["齐亚宗：哈喽！","梦真：你在哪","苏若瑶：你是谁","齐亚宗：你好"]
    var itemData : Record = Record(name: "", url: URL(string: "http://123.206.129.177/uploads/171.jpg")!, flont: 1.0)
    
    var tableView:UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        //创建表视图
        self.tableView = UITableView(frame: self.view.frame, style: .plain)
        self.tableView.delegate = self
        self.tableView.dataSource = self
        //去掉线
        tableView.separatorStyle = UITableViewCellSeparatorStyle.singleLineEtched
        //去掉多余单元格
        tableView.tableFooterView = view1
        //创建一个重用单元格
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "talkCell")
        self.tableView.register(UINib(nibName:"ImageTableViewCell",bundle:nil), forCellReuseIdentifier: "myCell")
        //设置estimateRowHeight默认属性
        self.tableView.estimatedRowHeight = 44.0
        
        //self.tableView.rowHeight = UITableViewAutomaticDimension
        self.view.addSubview(self.tableView)
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        if section == 0{
            return 1
        }else {
            return list.count
        }
        
    }
    
    
    
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        //同一形式的单元格重复使用
        if indexPath.section == 0{
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell",
                                                 for: indexPath) as! ImageTableViewCell
        //获取对应的条目内容
        let Record = itemData//[indexPath.row]
        cell.constraint(aspect: Record.flont)
        cell.contentImageView.image = Record.image
        cell.titleLable.text = Record.name
            func startDownloadForRecord(_ movieRecord: Record, indexPath: IndexPath){
                //判断队列中是否已有该图片任务
                if let _ = Operations.downloadsInProgress[indexPath] {
                    return
                }
                
                //创建一个下载任务
                let downloader = ImageDownloader(movieRecord: movieRecord)
                //任务完成后重新加载对应的单元格
                downloader.completionBlock = {
                    if downloader.isCancelled {
                        return
                    }
                    DispatchQueue.main.async(execute: {
                        self.Operations.downloadsInProgress.removeValue(forKey: indexPath)
                        
                        self.tableView.reloadRows(at: [indexPath], with: .fade)
                    })
                }
                //记录当前下载任务
                Operations.downloadsInProgress[indexPath] = downloader
                //将任务添加到队列中
                Operations.downloadQueue.addOperation(downloader)
            }

        return cell
        }else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "talkCell", for: indexPath)
            cell.textLabel?.text = list[indexPath.row]
            cell.textLabel?.font = UIFont.systemFont(ofSize: 15.0, weight: UIFontWeightMedium)
            //cell选择的风格
            cell.selectionStyle = UITableViewCellSelectionStyle.none 
            
            return cell
        }
        
    }
    //cell高度变化
    //因为第二个分区单元格动态添加，会引起cell高度的变化，所以要重新设置
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 1{
            return 20
        }else {
            return UITableViewAutomaticDimension
        }
    }
    func startDownloadForRecord(_ movieRecord: Record, indexPath: IndexPath){
        //判断队列中是否已有该图片任务
        if let _ = Operations.downloadsInProgress[indexPath] {
            return
        }
        
        //创建一个下载任务
        let downloader = ImageDownloader(movieRecord: movieRecord)
        //任务完成后重新加载对应的单元格
        downloader.completionBlock = {
            if downloader.isCancelled {
                return
            }
            DispatchQueue.main.async(execute: {
                self.Operations.downloadsInProgress.removeValue(forKey: indexPath)
                
                self.tableView.reloadRows(at: [indexPath], with: .fade)
            })
        }
        //记录当前下载任务
        Operations.downloadsInProgress[indexPath] = downloader
        //将任务添加到队列中
        Operations.downloadQueue.addOperation(downloader)
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
