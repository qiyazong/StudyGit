//
//  detailPersonTableViewController.swift
//  yingjing
//
//  Created by 齐亚宗 on 2017/6/22.
//  Copyright © 2017年 qiya. All rights reserved.
//

import UIKit

class detailPersonTableViewController: UITableViewController {
    var catalog = [[String]]()
    @IBOutlet var tabview: UITableView!
    
    
    @IBOutlet weak var headPhoto: UIButton!
    
    @IBOutlet weak var name: UILabel!
    
    
    @IBOutlet weak var school: UILabel!
    
    @IBOutlet weak var yuanxi: UILabel!
    
    @IBOutlet weak var photoNumber: UILabel!

    @IBOutlet weak var mateNumber: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        catalog.append(["齐亚宗","img1.jpg"])
        catalog.append(["齐亚宗","img2.jpg"])
        catalog.append(["齐亚宗","img3.jpg"])
        self.tabview!.register(UINib(nibName: "personImageTableViewCell", bundle: nil), forCellReuseIdentifier: "myCell")
        //设置estimateRowHeight属性默认值
        self.tabview.estimatedRowHeight = 44.0
        //roeHieght属性设置为uiTableViewAutomaticDimemsion
        self.tabview.rowHeight = UITableViewAutomaticDimension

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
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
        return self.catalog.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell",
                                                 for: indexPath) as! personImageTableViewCell
        //获取对应的条目内容
        let entry = catalog[indexPath.row]
        //单元格标题和内容设置
        cell.titleLable.text = entry[0]
        cell.loadImage(name: entry[1])
        
        return cell
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
