//
//  UIImage+.swift
//  newTest
//
//  Created by one on 2020/7/8.
//  Copyright © 2020 one. All rights reserved.
//

import Foundation


import UIKit

extension UIImage
{
  //旋转 degrees
    func rotate(by degrees: CGFloat, flip: Bool? = nil) -> UIImage
    {
        let radians = CGFloat(degrees * (CGFloat.pi / 180.0))
        
        let bufferView = UIView(frame: CGRect(origin: CGPoint.zero, size: self.size))
        let t: CGAffineTransform = CGAffineTransform(rotationAngle: radians)
        bufferView.transform = t
        let bufferSize = bufferView.frame.size
        
        UIGraphicsBeginImageContextWithOptions(bufferSize, false, self.scale)
        let bitmap = UIGraphicsGetCurrentContext()
        bitmap?.translateBy(x: bufferSize.width / 2, y: bufferSize.height / 2)
        bitmap?.rotate(by: radians)
        if let isFlipped = flip {
            if !isFlipped {
                bitmap?.scaleBy(x: 1.0, y: -1.0)
            } else {
                bitmap?.scaleBy(x: -1.0, y: -1.0)
            }
        } else {
            bitmap?.scaleBy(x: -1.0, y: -1.0)
        }
        bitmap?.draw(self.cgImage!, in: CGRect(origin: CGPoint(x: -self.size.width / 2, y: -self.size.height / 2), size: self.size))
        
        let finalBuffer = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return finalBuffer!
    }

// MARK: - Init/Deinit functions
//    convenience init?(imageBuffer: CVPixelBuffer) {
//        var cgImage: CGImage?
//        
//        VTCreateCGImageFromCVPixelBuffer(imageBuffer, options: nil, imageOut: &cgImage)
//        
//        if let cgImage = cgImage {
//            self.init(cgImage: cgImage)
//        } else {
//            return nil
//        }
//    }
    
    
    /// Resize image from given size.
    ///
    /// - Parameter newSize: Size of the image output.
    /// - Returns: Resized image.
    func resize(to newSize: CGSize) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(CGSize(width: newSize.width, height: newSize.height), true, 1.0)
        self.draw(in: CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height))
        let resizedImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        return resizedImage
    }
    
    func cutImage(rect:CGRect) ->UIImage{
        let cgimage = self.cgImage
        let newcgimage = cgimage?.cropping(to: rect)
        print(newcgimage?.width)
        let partuiimage = UIImage(cgImage: newcgimage!)
      
        UIGraphicsBeginImageContext(self.size)
        partuiimage.draw(in: rect)
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
    /// Crop image with given rectangle frame.
    ///
    /// - Parameter rect: Rectangle zone taken from the original image.
    /// - Returns: Cropped image.
    func crop(to rect: CGRect) -> UIImage {
        if let imageRef: CGImage = self.cgImage?.cropping(to: rect) {
            let cropped: UIImage = UIImage(cgImage: imageRef, scale: 0, orientation: self.imageOrientation)
            return cropped
        }
        return self
    }
    
    /// Square up the image and centerising the cropping.
    ///
    /// - Returns: Cropped image.
    func smartCrop() -> UIImage {
        var imageHeight = self.size.height
        var imageWidth = self.size.width
        
        if imageHeight > imageWidth {
            imageHeight = imageWidth
        }
        else {
            imageWidth = imageHeight
        }
        
        let size = CGSize(width: imageWidth, height: imageHeight)
        
        guard let width = self.cgImage?.width, let height = self.cgImage?.height else {
            return self
        }
        
        let refWidth: CGFloat = CGFloat(width)
        let refHeight: CGFloat = CGFloat(height)
        
        let x = (refWidth - size.width) / 2
        let y = (refHeight - size.height) / 2
        
        let cropRect = CGRect(x: x, y: y, width: size.height, height: size.width)
        return crop(to: cropRect)
    }
    
    
//图像buffer
    var buffer: CVPixelBuffer? {
        let attrs = [kCVPixelBufferCGImageCompatibilityKey: kCFBooleanTrue, kCVPixelBufferCGBitmapContextCompatibilityKey: kCFBooleanTrue] as CFDictionary
        var pixelBuffer: CVPixelBuffer?
        let status = CVPixelBufferCreate(kCFAllocatorDefault, Int(self.size.width), Int(self.size.height), kCVPixelFormatType_32ARGB, attrs, &pixelBuffer)
        guard (status == kCVReturnSuccess) else {
            return nil
        }
        
        CVPixelBufferLockBaseAddress(pixelBuffer!, CVPixelBufferLockFlags(rawValue: 0))
        let pixelData = CVPixelBufferGetBaseAddress(pixelBuffer!)
        
        let rgbColorSpace = CGColorSpaceCreateDeviceRGB()
        let context = CGContext(data: pixelData, width: Int(self.size.width), height: Int(self.size.height), bitsPerComponent: 8, bytesPerRow: CVPixelBufferGetBytesPerRow(pixelBuffer!), space: rgbColorSpace, bitmapInfo: CGImageAlphaInfo.noneSkipFirst.rawValue)
        
        context?.translateBy(x: 0, y: self.size.height)
        context?.scaleBy(x: 1.0, y: -1.0)
        
        UIGraphicsPushContext(context!)
        self.draw(in: CGRect(x: 0, y: 0, width: self.size.width, height: self.size.height))
        UIGraphicsPopContext()
        CVPixelBufferUnlockBaseAddress(pixelBuffer!, CVPixelBufferLockFlags(rawValue: 0))
        
        return pixelBuffer
    }
    //灰度图片转数组
    var greyData:[UInt8]{
        
        //var pixelValues: [UInt8]?
        
        let width = Int(self.size.width)
        let height = Int(self.size.height)
        let colorSpace =  self.cgImage?.colorSpace //CGColorSpaceCreateDeviceRGB()
        
        
        let bitsPerComponent = 8
        let bytesPerRow = width
        let totalBytes = height * width
        let bitmapInfo = CGImageAlphaInfo.none
        
        var intensities = [UInt8](repeating: 0, count: Int(totalBytes))
        
        let contextRef = CGContext(data: &intensities, width: width, height: height, bitsPerComponent: bitsPerComponent, bytesPerRow: bytesPerRow, space: colorSpace!, bitmapInfo: bitmapInfo.rawValue)
    
        contextRef?.draw(self.cgImage!, in: CGRect(x: 0.0, y: 0.0, width: CGFloat(width), height: CGFloat(height)))

        return intensities
    
    }
 /**
    Converts the image into an array of RGBA bytes.
   */
  @nonobjc public func toByteArray() -> [UInt8] {
    let width = Int(size.width)
    let height = Int(size.height)
    var bytes = [UInt8](repeating: 0, count: width * height * 4)

    bytes.withUnsafeMutableBytes { ptr in
      if let context = CGContext(
                    data: ptr.baseAddress,
                    width: width,
                    height: height,
                    bitsPerComponent: 8,
                    bytesPerRow: width * 4,
                    space: CGColorSpaceCreateDeviceRGB(),
                    bitmapInfo: CGImageAlphaInfo.premultipliedLast.rawValue) {

        if let image = self.cgImage {
          let rect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
          context.draw(image, in: rect)
        }
      }
    }
    return bytes
  }

  /**
    Creates a new UIImage from an array of RGBA bytes.
   */
  @nonobjc public class func fromByteArray(_ bytes: UnsafeMutableRawPointer,
                                           width: Int,
                                           height: Int) -> UIImage {

    if let context = CGContext(data: bytes, width: width, height: height,
                               bitsPerComponent: 8, bytesPerRow: width * 4,
                               space: CGColorSpaceCreateDeviceRGB(),
                               bitmapInfo: CGImageAlphaInfo.premultipliedLast.rawValue),
       let cgImage = context.makeImage() {
      return UIImage(cgImage: cgImage, scale: 0, orientation: .up)
    } else {
      return UIImage()
    }
  }
//图片再特定点添加标记（十字）
    func addPoint(data:[Int]) -> UIImage {
        return addPoint(data: data, color: UIColor.red)
    }
    
    func addPoint(data:[Int], color:UIColor) -> UIImage {
    
    UIGraphicsBeginImageContextWithOptions(self.size, false, self.scale)
   
    //传递1：将原始图像绘制为背景
    self.draw(at: CGPoint(x: 0, y: 0))

    
    //传递2：在原始图像上绘制线条
    let context = UIGraphicsGetCurrentContext()
    context?.setLineWidth(1.0)
    
    
    for i in 0..<data.count/2 {
        let x = data[2*i]
        let y = data[2*i+1]
        
        context?.move(to: CGPoint(x:x-5,y:y))
        context?.addLine(to: CGPoint(x:x+5,y:y))
        context?.move(to: CGPoint(x:x,y:y-5))
        context?.addLine(to: CGPoint(x:x,y:y+5))
    }
    //context?.move(to: CGPoint(x:10,y:10))
    //context?.addLine(to: CGPoint(x:100,y:100))
    context?.setStrokeColor(color.cgColor)

    context?.strokePath()
 
    
    //创建新图像
    var newImage = UIGraphicsGetImageFromCurrentImageContext()
    //收拾
    UIGraphicsEndImageContext()
    
    return newImage!
   }
   
//图片添加线
   func addLine(data1:[Int],data2:[Int]) -> UIImage {
      
      UIGraphicsBeginImageContextWithOptions(self.size, false, self.scale)
     
      //传递1：将原始图像绘制为背景
      self.draw(at: CGPoint(x: 0, y: 0))

      
      //传递2：在原始图像上绘制线条
      let context = UIGraphicsGetCurrentContext()
      context?.setLineWidth(1.0)
      
      
      for i in 0..<data1.count/2 {
          let x1 = data1[2*i]
          let y1 = data1[2*i+1]
          let x2 = data2[2*i]
          let y2 = data2[2*i+1]
          
          context?.move(to: CGPoint(x:x1,y:y1))
          context?.addLine(to: CGPoint(x:x2,y:y2))
      }

      context?.setStrokeColor(UIColor.green.cgColor)

      context?.strokePath()
   
      
      //创建新图像
      var newImage = UIGraphicsGetImageFromCurrentImageContext()
      //收拾
      UIGraphicsEndImageContext()
      
      return newImage!
     }
    
    
     
}
