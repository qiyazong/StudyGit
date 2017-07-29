import UIKit

// 这个枚举包含所有图片的状态
enum RecordState {
    case new, downloaded, filtered, failed
}

// 条目类
class Record {
    let name:String
    let url:URL
    let flont:CGFloat
    var state = RecordState.new
    //默认初始图片
    var image = UIImage(named: "WechatIMG4.jpeg")
    
    init(name:String, url:URL,flont:CGFloat) {
        self.name = name
        self.url = url
        self.flont = flont
    }
}
