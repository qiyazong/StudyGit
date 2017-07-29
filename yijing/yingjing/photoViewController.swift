import UIKit

class photoViewController: UIViewController , UITableViewDelegate, UITableViewDataSource  {
    
    
    var refreshControl:ZJRefreshControl!
    
    //var catalog = [[String]]()
    let Operations = operations()
    
    var tableView:UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let movie = Record(name: "齐亚宗", url: URL(string: "http://123.206.129.177/uploads/171.jpg")!,flont:1)
        
        let movie1 = Record(name: "齐亚宗", url: URL(string: "http://123.206.129.177/uploads/171.jpg")!,flont:2)
        
        let movie2 = Record(name: "齐亚宗", url: URL(string: "http://portrait4.sinaimg.cn/1524971307/blog/180")!,flont:0.5)
        
        //初始化数据
        
        photoCellData.append(movie)
        photoCellData.append(movie1)
        photoCellData.append(movie2)
        
        
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
        let Record = photoCellData[indexPath.row]
        
        cell.constraint(aspect: Record.flont)
        //单元格标题和内容设置
        cell.titleLable.text = Record.name
        //cell.loadImage(name: entry[1])
        cell.contentImageView.image = Record.image
        
        switch (Record.state){
        case .filtered:
            print("失败")
        case .failed:
            
            print("失败")
        case .new:
            
            startDownloadForRecord(Record, indexPath: indexPath)
        case .downloaded: break
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
            controller.itemData = sender as! Record
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
