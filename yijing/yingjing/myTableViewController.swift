//
//  myTableViewController.swift
//  yingjing
//
//  Created by 齐亚宗 on 2017/6/2.
//  Copyright © 2017年 qiya. All rights reserved.
//

import UIKit

class myTableViewController: UITableViewController {
    @IBAction func logout(_ sender: Any) {
        UserDefaults.standard.removeObject(forKey: "loginBool")
        
        
    }
    let Operations = operations()
    
    @IBOutlet var tableView1: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        //初始化数据
        
        let movie = Record(name: "齐亚宗", url: URL(string: "http://123.206.129.177/uploads/171.jpg")!,flont:1)
        
        let movie1 = Record(name: "齐亚宗", url: URL(string: "http://123.206.129.177/uploads/171.jpg")!,flont:2)
        
         let movie2 = Record(name: "齐亚宗", url: URL(string: "http://portrait4.sinaimg.cn/1524971307/blog/180")!,flont:0.5)
        
        myPhotoData.append(movie)
        myPhotoData.append(movie1)
        myPhotoData.append(movie2)
        
        
        self.tableView1!.register(UINib(nibName: "personImageTableViewCell", bundle: nil), forCellReuseIdentifier: "myCell")
        //设置estimateRowHeight属性默认值
        self.tableView1.estimatedRowHeight = 44.0
        //roeHieght属性设置为uiTableViewAutomaticDimemsion
        self.tableView1.rowHeight = UITableViewAutomaticDimension
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return myPhotoData.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell",
                                                 for: indexPath) as! personImageTableViewCell
        //获取对应的条目内容
        let Record = myPhotoData[indexPath.row]
        
        cell.constraint(aspect: Record.flont)
        //单元格标题和内容设置
        cell.titleLable.text = Record.name
        cell.contentImageView.image = Record.image
        
        switch (Record.state){
        case .filtered:
            print("失败")
        case .failed:
            
            print("失败")
        case .new:
            
            startDownloadForRecord(Record, indexPath: indexPath)
        case .downloaded: break
            //indicator.startAnimating()
            //startFiltrationForRecord(movieRecord, indexPath: indexPath)
        }

        return cell
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
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
