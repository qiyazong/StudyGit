//
//  FAImageCropperVC.swift
//  FAImageCropper
//
//  Created by Fahid Attique on 11/02/2017.
//  Copyright © 2017 Fahid Attique. All rights reserved.
//


extension UIImage {
    /**
     *  重设图片大小
     */
    func reSizeImage(_ reSize:CGSize)->UIImage {
        //UIGraphicsBeginImageContext(reSize);
        UIGraphicsBeginImageContextWithOptions(reSize,false,UIScreen.main.scale);
        self.draw(in: CGRect(x: 0, y: 0, width: reSize.width, height: reSize.height));
        let reSizeImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!;
        UIGraphicsEndImageContext();
        return reSizeImage;
    }
    
    /**
     *  等比率缩放
     */
    func scaleImage(_ scaleSize:CGFloat)->UIImage {
        let reSize = CGSize(width: self.size.width * scaleSize, height: self.size.height * scaleSize)
        return reSizeImage(reSize)
    }
    func scaleImage1(_ scaleSize:CGFloat)->UIImage {
        let reSize = CGSize(width: 640 / 2, height: self.size.height * scaleSize)
        return reSizeImage(reSize)
    }
    func compressImage( maxLength: Int) -> NSData? {
        
        
        
        var compress:CGFloat = 0.9
        var data = UIImageJPEGRepresentation(self, compress)
        
        while (data?.count)! > maxLength && compress > 0.01 {
            compress -= 0.02
            data = UIImageJPEGRepresentation(self, compress)
        }
        
        return data! as NSData
    }
}

import UIKit
import Sharaku
import Alamofire


class FAImageCropperVC: UIViewController ,SHViewControllerDelegate{
    
    func shViewControllerImageDidFilter(image: UIImage) {
        
        
        //获取缩放比例
        
        let a = 640 / image.size.width / 2
        
        
        //获取选择的原图
        let pickerImage = image.scaleImage1(a)
        
        //将选择的图片保存到Document目录下
        let fileManager = FileManager.default
        let rootPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String
        let filePath = "\(rootPath)/pickedImage.jpg"
        //print(pickerImage)
        
        let imageData = UIImageJPEGRepresentation(pickerImage, 1)
        //let imageData = pickerImage.compressImage(maxLength: 3000000)! as Data
        
        //print(imageData?.count as Any)
        
        fileManager.createFile(atPath: filePath, contents: imageData, attributes: nil)
        
        //上传图片
        if (fileManager.fileExists(atPath: filePath)){
            //取得nsurl
            let imageNSURL:URL = URL.init(fileURLWithPath: filePath)
            
            
            
            //let headers = ["content-type":"multipart/form-data"]
            
            /*Alamofire.upload(multipartFormData: {MultipartFormData in
             MultipartFormData.append(, withName: <#T##String#>)
             MultipartFormData.append(<#T##data: Data##Data#>, withName: <#T##String#>)
             }, to: "http://upload.qiniu.com",
             headers: headers,
             encodingCompletion: { encodingResult in
             switch encodingResult {
             case .success(let upload, _, _):
             upload.responseJSON { response in
             debugPrint(response)
             }
             case .failure(let encodingError):
             print(encodingError)
             }
             })*/
            
            
            
            //使用alamofire上传
            Alamofire.upload(multipartFormData: {
                multipartFormData in
                
                let uploadToken = "AfhwqE5IXTGNWgPfcEm3NSQYYji5XL14IWWy00xV:Jb5gyikJsHfTCs1v1h0lTcryhno=:eyJzY29wZSI6InFpeWF6b25neWluZ2ppbmciLCJkZWFkbGluZSI6MTQ5Nzk0NTk0NCwidXBIb3N0cyI6WyJodHRwOlwvXC91cC16MS5xaW5pdS5jb20iLCJodHRwOlwvXC91cGxvYWQtejEucWluaXUuY29tIiwiLUggdXAtejEucWluaXUuY29tIGh0dHA6XC9cLzEwNi4zOC4yMjcuMjciXX0="
                
                let date = NSDate()
                let timeInterval  = date.timeIntervalSince1970 * 1000
                
                let string = "\(timeInterval)"
                
                let infront = "zhongyangxijuxueyuan/620/"
                let key = infront + string
                
                multipartFormData.append((key.data(using: String.Encoding.utf8)!), withName: "key")
                
                multipartFormData.append((uploadToken.data(using: String.Encoding.utf8)!), withName: "token")
                multipartFormData.append(imageNSURL, withName: "file", fileName: "pickedImage.jpg", mimeType: "image/jpg")
                
            }, to: "http://upload-z1.qiniu.com", encodingCompletion: { encodingResult in
                switch encodingResult {
                case .success(let upload, _, _):
                    upload.responseJSON { response in
                        debugPrint(response)
                    }
                case .failure(let encodingError):
                    print(encodingError)
                }
            })
            
            /*Alamofire.upload(imageNSURL, to: "http://123.206.129.177/hanggephoto.php")
             .responseString { response in
             print("Success: \(response.result.isSuccess)")
             print("Response String: \(String(describing: response.result.value))")
             }*/
            
            
            
        }
        
        
        //croppedImage1 = image
        //performSegue(withIdentifier: "FADetailViewSegue", sender: nil)
    }
    
    func shViewControllerDidCancel() {
    }
    
    // MARK: IBOutlets
    
    @IBOutlet weak var scrollContainerView: UIView!
    @IBOutlet weak var scrollView: FAScrollView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var btnZoom: UIButton!
    @IBOutlet weak var btnCrop: UIButton!
    @IBAction func zoom(_ sender: Any) {
        scrollView.zoom()
    }
    @IBAction func crop(_ sender: Any) {
        //croppedImage = captureVisibleRect()
        
        croppedImage = captureVisibleRect()
        
        let vc = SHViewController(image:croppedImage!)
        vc.delegate = self
        present(vc, animated: true, completion: nil)
        
        //performSegue(withIdentifier: "FADetailViewSegue", sender: nil)
    }
    
    
    
    // MARK: Public Properties
    
    var photos:[PHAsset]!
    var imageViewToDrag: UIImageView!
    var indexPathOfImageViewToDrag: IndexPath!
    
    
    
    let cellWidth = ((UIScreen.main.bounds.size.width)/3)-1
    
    
    // MARK: Private Properties
    
    private let imageLoader = FAImageLoader()
    private var croppedImage: UIImage? = nil

    
    
    // MARK: LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.\
        viewConfigurations()
        checkForPhotosPermission()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "FADetailViewSegue" {
            
            let detailVC = segue.destination as? FADetailVC
            detailVC?.croppedImage = croppedImage
        }
    }
    
    // MARK: Private Functions
    
    private func checkForPhotosPermission(){
        
        // Get the current authorization state.
        let status = PHPhotoLibrary.authorizationStatus()
        
        if (status == PHAuthorizationStatus.authorized) {
            // Access has been granted.
            loadPhotos()
        }
        else if (status == PHAuthorizationStatus.denied) {
            // Access has been denied.
        }
        else if (status == PHAuthorizationStatus.notDetermined) {
            
            // Access has not been determined.
            PHPhotoLibrary.requestAuthorization({ (newStatus) in
                
                if (newStatus == PHAuthorizationStatus.authorized) {
                    
                    DispatchQueue.main.async {
                        self.loadPhotos()
                    }
                }
                else {
                    // Access has been denied.
                }
            })
        }
            
        else if (status == PHAuthorizationStatus.restricted) {
            // Restricted access - normally won't happen.
        }
    }
    
    private func viewConfigurations() {
        
        navigationBarConfigurations()
        btnCrop.layer.cornerRadius = btnCrop.frame.size.width/2
        btnZoom.layer.cornerRadius = btnZoom.frame.size.width/2
    }
    
    private func navigationBarConfigurations() {
    
        navigationController?.navigationBar.backgroundColor = .black
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.setBackgroundImage(UIImage(color: .black), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage(color: .clear)
        navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName:UIColor.white]
    }

    
    private func loadPhotos(){

        imageLoader.loadPhotos { (assets) in
            self.configureImageCropper(assets: assets)
        }
    }
    
    private func configureImageCropper(assets:[PHAsset]){

        if assets.count != 0{
            photos = assets
            
            
            collectionView.delegate = self
            collectionView.dataSource = self
            collectionView.reloadData()
            selectDefaultImage()
        }
    }

    private func selectDefaultImage(){
        collectionView.selectItem(at: IndexPath(item: 0, section: 0), animated: true, scrollPosition: .top)
        selectImageFromAssetAtIndex(index: 0)
    }
    
    
    private func captureVisibleRect() -> UIImage{
        
        var croprect = CGRect.zero
        let xOffset = (scrollView.imageToDisplay?.size.width)! / scrollView.contentSize.width;
        let yOffset = (scrollView.imageToDisplay?.size.height)! / scrollView.contentSize.height;
        
        croprect.origin.x = scrollView.contentOffset.x * xOffset;
        croprect.origin.y = scrollView.contentOffset.y * yOffset;
        
        let normalizedWidth = (scrollView?.frame.width)! / (scrollView?.contentSize.width)!
        let normalizedHeight = (scrollView?.frame.height)! / (scrollView?.contentSize.height)!
        
        croprect.size.width = scrollView.imageToDisplay!.size.width * normalizedWidth
        croprect.size.height = scrollView.imageToDisplay!.size.height * normalizedHeight
        
        let cr: CGImage? = scrollView.imageView.image?.cgImage?.cropping(to: croprect)
        let cropped = UIImage(cgImage: cr!)
        
        return cropped

    }
    private func isSquareImage() -> Bool{
        let image = scrollView.imageToDisplay
        if image?.size.width == image?.size.height { return true }
        else { return false }
    }

    
    // MARK: Public Functions

    func selectImageFromAssetAtIndex(index:NSInteger){
        
        FAImageLoader.imageFrom(asset: photos[index], size: PHImageManagerMaximumSize) { (image) in
            DispatchQueue.main.async {
                self.displayImageInScrollView(image: image)
            }
        }
    }
    
    func displayImageInScrollView(image:UIImage){
        self.scrollView.imageToDisplay = image
        if isSquareImage() { btnZoom.isHidden = true }
        else { btnZoom.isHidden = false }
    }
    
    func replicate(_ image:UIImage) -> UIImage? {
        
        guard let cgImage = image.cgImage?.copy() else {
            return nil
        }

        return UIImage(cgImage: cgImage,
                               scale: image.scale,
                               orientation: image.imageOrientation)
    }
    

    func handleLongPressGesture(recognizer: UILongPressGestureRecognizer) {

        let location = recognizer.location(in: view)

        if recognizer.state == .began {

            let cell: FAImageCell = recognizer.view as! FAImageCell
            indexPathOfImageViewToDrag = collectionView.indexPath(for: cell)
            imageViewToDrag = UIImageView(image: replicate(cell.imageView.image!))
            imageViewToDrag.frame = CGRect(x: location.x - cellWidth/2, y: location.y - cellWidth/2, width: cellWidth, height: cellWidth)
            view.addSubview(imageViewToDrag!)
            view.bringSubview(toFront: imageViewToDrag!)
        }
        else if recognizer.state == .ended {
            
            if scrollView.frame.contains(location) {
                collectionView.selectItem(at: indexPathOfImageViewToDrag, animated: true, scrollPosition: UICollectionViewScrollPosition.centeredVertically)
              selectImageFromAssetAtIndex(index: indexPathOfImageViewToDrag.item)
            }
            
            imageViewToDrag.removeFromSuperview()
            imageViewToDrag = nil
            indexPathOfImageViewToDrag = nil
        }
        else{
            imageViewToDrag.center = location
        }
    }
}





extension FAImageCropperVC:UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell:FAImageCell = collectionView.dequeueReusableCell(withReuseIdentifier: "FAImageCell", for: indexPath) as! FAImageCell
        cell.populateDataWith(asset: photos[indexPath.item])
        cell.configureGestureWithTarget(target: self, action: #selector(FAImageCropperVC.handleLongPressGesture))
        
        return cell
    }
}


extension FAImageCropperVC:UICollectionViewDelegate{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell:FAImageCell = collectionView.cellForItem(at: indexPath) as! FAImageCell
        cell.isSelected = true
        selectImageFromAssetAtIndex(index: indexPath.item)
    }
}


extension FAImageCropperVC:UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: cellWidth, height: cellWidth)
    }
}
