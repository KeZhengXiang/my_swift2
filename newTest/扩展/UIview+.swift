
//
//  UIViewExtension.swift
//  newTest
//
//  Created by one on 2020/6/18.
//  Copyright © 2020 one. All rights reserved.
//

import UIKit



extension UIView {
    
    //将当前视图转为UIImage
    func asImage() -> UIImage {
        let renderer = UIGraphicsImageRenderer(bounds: bounds)
        return renderer.image { rendererContext in
            layer.render(in: rendererContext.cgContext)
        }
    }
    /**
     /// 整个窗口截屏
     let image = UIApplication.shared.keyWindow!.asImage()

     /// 某一个单独View截图
     let image = self.imageBgView.asImage()

     /// 将转换后的UIImage保存到相机胶卷中
     UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
     */
}


////
////  UIviewExtension.swift
////  my_swift2
////
////  Created by one on 2020/6/18.
////  Copyright © 2020 one. All rights reserved.
////
//
//import UIKit
//
////MARK: - UIView 扩展
//extension UIView{
//
//    /** xib适配 */
//    func layoutXib(){
//        for  view in self.subviews {
//            var returnRect = CGRect()
//            returnRect.size.width = view.width.adapterWidthValue
//            returnRect.size.height = view.height.adapterWidthValue
//            returnRect.origin.x = view.x.adapterWidthValue
//            returnRect.origin.y = view.y.adapterWidthValue
//            view.frame = returnRect
//
//            if view .isKind(of: UITextField.self){
//                let viewField = view as! UITextField
//                let attributedStr:NSMutableAttributedString = viewField.attributedText?.mutableCopy() as! NSMutableAttributedString
//                viewField.attributedText?.enumerateAttributes(in: NSRange(location: 0,length: viewField.text?.count ?? 0), options: .longestEffectiveRangeNotRequired, using: { (dic, range, stop) in
//                    attributedStr.removeAttribute(.font, range: range)
//                    let font:UIFont = dic[NSAttributedString.Key.font] as! UIFont
//                    let fontSize:CGFloat! = font.pointSize
//                    let fontName:String! = font.fontName
//                    attributedStr.addAttributes([NSAttributedString.Key.font:UIFont.init(name: fontName, size: Xlb.ADAPTATION_WIDTH(fontSize))!], range: range)
//                })
//                viewField.attributedText = attributedStr
//
//                /** 设置PlaceHolder */
//                let placeAttributedStr:NSMutableAttributedString = viewField.attributedPlaceholder?.mutableCopy() as! NSMutableAttributedString
//                viewField.attributedPlaceholder?.enumerateAttributes(in: NSRange(location: 0,length: viewField.placeholder?.count ?? 0), options: .longestEffectiveRangeNotRequired, using: { (dic, range, stop) in
//                    placeAttributedStr.removeAttribute(.font, range: range)
//                    let font:UIFont = dic[NSAttributedString.Key.font] as! UIFont
//                    let fontSize:CGFloat! = font.pointSize
//                    let fontName:String! = font.fontName
//                    placeAttributedStr.addAttributes([NSAttributedString.Key.font:UIFont.init(name: fontName, size: Xlb.ADAPTATION_WIDTH(fontSize))!], range: range)
//                })
//                viewField.attributedPlaceholder = placeAttributedStr
//
//            } else if view.isKind(of: UIButton.self){
//                let viewButton = view as! UIButton
//                let fontSize:CGFloat! = viewButton.titleLabel!.font?.pointSize
//                let fontName:String! = viewButton.titleLabel!.font?.fontName
//                viewButton.titleLabel!.font = UIFont.init(name: fontName, size: Xlb.ADAPTATION_WIDTH(fontSize))
//            } else if view.isKind(of: UILabel.self){
//                let viewLabel = view as! UILabel
//                let attributedStr:NSMutableAttributedString = viewLabel.attributedText?.mutableCopy() as! NSMutableAttributedString
//                viewLabel.attributedText?.enumerateAttributes(in: NSRange(location: 0,length: viewLabel.text?.count ?? 0), options: .longestEffectiveRangeNotRequired, using: { (dic, range, stop) in
//                    attributedStr.removeAttribute(.font, range: range)
//                    let font:UIFont = dic[NSAttributedString.Key.font] as! UIFont
//                    let fontSize:CGFloat! = font.pointSize
//                    let fontName:String! = font.fontName
//                    attributedStr.addAttributes([NSAttributedString.Key.font:UIFont.init(name: fontName, size: Xlb.ADAPTATION_WIDTH(fontSize))!], range: range)
//                })
//                viewLabel.attributedText = attributedStr
//            } else if view.isKind(of: UITextView.self){
//                let viewTextView  = view as! UITextView
//                let fontSize:CGFloat! = viewTextView.font?.pointSize
//                let fontName:String! = viewTextView.font?.fontName
//                viewTextView.font = UIFont.init(name: fontName, size: Xlb.ADAPTATION_WIDTH(fontSize))
//            }
//        }
//    }
//
//    /** View转Image */
//    func imageWithView() ->(UIImage) {
//        let imageSize = self.bounds.size
//        UIGraphicsBeginImageContextWithOptions(imageSize, false, UIScreen.main.scale)
//        self.layer.render(in: UIGraphicsGetCurrentContext()!)
//        let image = UIGraphicsGetImageFromCurrentImageContext()!
//        UIGraphicsEndImageContext()
//        return image
//    }
//
//    var x: CGFloat {
//        get { return self.frame.origin.x}
//        set(value) {
//            var origin = self.frame.origin
//            origin.x = value
//            self.frame.origin = origin
//        }
//    }
//    var y: CGFloat {
//        get { return self.frame.origin.y}
//        set(value) {
//            var origin = self.frame.origin
//            origin.y = value
//            self.frame.origin = origin
//        }
//    }
//    var centerX: CGFloat {
//        get { return self.center.x}
//        set(value) {
//            var center = self.center
//            center.x = value
//            self.center = center
//        }
//    }
//    var centerY: CGFloat {
//        get { return self.center.y}
//        set(value) {
//            var center = self.center
//            center.y = value
//            self.center = center
//        }
//    }
//    var width: CGFloat {
//        get { return self.frame.size.width}
//        set(value) {
//            var size = self.frame.size
//            size.width = value
//            self.frame.size = size
//        }
//    }
//    var height: CGFloat {
//        get { return self.frame.size.height}
//        set(value) {
//            var size = self.frame.size
//            size.height = value
//            self.frame.size = size
//        }
//    }
//    var origin: CGPoint {
//        get { return self.frame.origin}
//        set(value) {
//            self.frame.origin = value
//        }
//    }
//    var size: CGSize {
//        get { return self.frame.size}
//        set(value) {
//            self.frame.size = value
//        }
//    }
//}
//
////MARK: - CGFloat 扩展
//extension CGFloat{
//
//    /** 宽度适配 */
//    var adapterWidthValue:CGFloat {
//        return Xlb.MAINSCREEN_WIDTH() * self / 375.0
//    }
//    /** 高度适配 */
//    var adapterHeightValue:CGFloat {
//        return Xlb.MAINSCREEN_HEIGHT() * self / 667.0
//    }
//}
//
//
//class Xlb: NSObject {
//    /** 适配宽度 */
//    class func ADAPTATION_WIDTH( _ value:CGFloat) -> CGFloat {
//        return self.MAINSCREEN_WIDTH() * value / 375.0
//    }
//    /** 适配高度 */
//    class func ADAPTATION_HEIGHT( _ value:CGFloat) -> CGFloat {
//        return self.MAINSCREEN_HEIGHT() * value / 667.0
//    }
//}
