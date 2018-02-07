//
//  UIImage+Extension.swift
//  vpn
//
//  Created by i-chou on 2018/2/6.
//  Copyright © 2018年 i-chou. All rights reserved.
//

import Foundation
import UIKit
import Accelerate

public func zip(image: UIImage, withKBSize size: Int) -> Data{
    
    let imageData = UIImageJPEGRepresentation(image,1)!
    let imageDataSize = imageData.count/8/1024       //kb
    var zipImageData: Data = imageData

    if imageDataSize > size * 6 {
        zipImageData = UIImageJPEGRepresentation(image,0.1)!
        return zipImageData
    }else if imageDataSize > size * 5 {
        zipImageData = UIImageJPEGRepresentation(image,0.2)!
        return zipImageData
    }else if imageDataSize > size * 4 {
        zipImageData = UIImageJPEGRepresentation(image,0.3)!
        return zipImageData
    }else if imageDataSize > size * 3 {
        zipImageData = UIImageJPEGRepresentation(image,0.3)!
        return zipImageData
    }else if imageDataSize > size * 2 {
        zipImageData = UIImageJPEGRepresentation(image,0.4)!
        return zipImageData
    }else if imageDataSize > size {
        zipImageData = UIImageJPEGRepresentation(image,0.6)!
        return zipImageData
    }
    return zipImageData
}


extension UIImage {

    func isEqualImage(image: UIImage) -> Bool {
        let imageData1 = UIImagePNGRepresentation(self)!
        let imageData2 = UIImagePNGRepresentation(image)!

        return imageData1.hashValue == imageData2.hashValue
    }
}


extension UIImage {


    /// 色块图片
    ///
    /// - Parameters:
    ///   - color: 颜色
    ///   - size: 尺寸
    /// - Returns: 图片
    open class func image(with color: UIColor, size: CGSize) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(size, false, k_SCREEN_SCALE)
        guard let context = UIGraphicsGetCurrentContext() else {
            return nil
        }

        context.scaleBy(x: 1.0, y: -1.0)
        context.translateBy(x: 0.0, y: -size.height)

        context.setBlendMode(.multiply)

        let rect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        color.setFill()
        context.fill(rect)

        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image?.withRenderingMode(.alwaysOriginal)
    }


    /// 下载图片
    ///
    /// - Parameters:
    ///   - url: 图片地址
    ///   - completion: 回调闭包
    open class func contentsOfURL(url: URL, completion: @escaping ((UIImage?, Error?) -> Void)) {
        URLSession.shared.dataTask(with: URLRequest(url: url)) { [completion = completion] (data: Data?, response: URLResponse?, error: Error?) in
            DispatchQueue.main.async {
                if let v = error {
                    completion(nil, v)
                } else if let v = data {
                    completion(UIImage(data: v), nil)
                }
            }
            }.resume()
    }
}


extension UIImage {


    /// 高斯模糊
    ///
    /// - Parameters:
    ///   - radius: 圆角，默认0
    ///   - tintColor: tintcolor
    ///   - saturationDeltaFactor: 模糊度
    /// - Returns: 图片
    open func blur(radius: CGFloat = 0, tintColor: UIColor? = nil, saturationDeltaFactor: CGFloat = 0) -> UIImage? {
        var effectImage = self

        let screenScale = k_SCREEN_SCALE
        let imageRect = CGRect(origin: .zero, size: size)
        let hasBlur = radius > CGFloat(Float.ulpOfOne)
        let hasSaturationChange = fabs(saturationDeltaFactor - 1.0) > CGFloat(Float.ulpOfOne)

        if hasBlur || hasSaturationChange {
            UIGraphicsBeginImageContextWithOptions(size, false, screenScale)
            let inContext = UIGraphicsGetCurrentContext()!
            inContext.scaleBy(x: 1.0, y: -1.0)
            inContext.translateBy(x: 0, y: -size.height)

            inContext.draw(cgImage!, in: imageRect)

            var inBuffer = createEffectBuffer(context: inContext)

            UIGraphicsBeginImageContextWithOptions(size, false, screenScale)

            let outContext = UIGraphicsGetCurrentContext()!
            var outBuffer = createEffectBuffer(context: outContext)

            if hasBlur {
                let a = sqrt(2 * Double.pi)
                let b = CGFloat(a) / 4
                let c = radius * screenScale
                let d = c * 3.0 * b

                var e = UInt32(floor(d + 0.5))

                if 1 != e % 2 {
                    e += 1 // force radius to be odd so that the three box-blur methodology works.
                }

                let imageEdgeExtendFlags = vImage_Flags(kvImageEdgeExtend)

                vImageBoxConvolve_ARGB8888(&inBuffer, &outBuffer, nil, 0, 0, e, e, nil, imageEdgeExtendFlags)
                vImageBoxConvolve_ARGB8888(&outBuffer, &inBuffer, nil, 0, 0, e, e, nil, imageEdgeExtendFlags)
                vImageBoxConvolve_ARGB8888(&inBuffer, &outBuffer, nil, 0, 0, e, e, nil, imageEdgeExtendFlags)
            }

            var effectImageBuffersAreSwapped = false

            if hasSaturationChange {
                let s = saturationDeltaFactor

                let floatingPointSaturationMatrix: [CGFloat] = [
                    0.0722 + 0.9278 * s,  0.0722 - 0.0722 * s,  0.0722 - 0.0722 * s,  0,
                    0.7152 - 0.7152 * s,  0.7152 + 0.2848 * s,  0.7152 - 0.7152 * s,  0,
                    0.2126 - 0.2126 * s,  0.2126 - 0.2126 * s,  0.2126 + 0.7873 * s,  0,
                    0,                    0,                    0,                    1
                ]

                let divisor: CGFloat = 256
                let matrixSize = floatingPointSaturationMatrix.count
                var saturationMatrix = [Int16](repeating: 0, count: matrixSize)

                for i in 0..<matrixSize {
                    saturationMatrix[i] = Int16(round(floatingPointSaturationMatrix[i] * divisor))
                }

                if hasBlur {
                    vImageMatrixMultiply_ARGB8888(&outBuffer, &inBuffer, saturationMatrix, Int32(divisor), nil, nil, vImage_Flags(kvImageNoFlags))
                    effectImageBuffersAreSwapped = true
                } else {
                    vImageMatrixMultiply_ARGB8888(&inBuffer, &outBuffer, saturationMatrix, Int32(divisor), nil, nil, vImage_Flags(kvImageNoFlags))
                }
            }

            if !effectImageBuffersAreSwapped {
                effectImage = UIGraphicsGetImageFromCurrentImageContext()!
            }

            UIGraphicsEndImageContext()

            if effectImageBuffersAreSwapped {
                effectImage = UIGraphicsGetImageFromCurrentImageContext()!
            }

            UIGraphicsEndImageContext()
        }

        // Set up output context.
        UIGraphicsBeginImageContextWithOptions(size, false, screenScale)
        let outputContext = UIGraphicsGetCurrentContext()!
        outputContext.scaleBy(x: 1.0, y: -1.0)
        outputContext.translateBy(x: 0, y: -size.height)

        // Draw base image.
        outputContext.draw(cgImage!, in: imageRect)

        // Draw effect image.
        if hasBlur {
            outputContext.saveGState()
            outputContext.draw(effectImage.cgImage!, in: imageRect)
            outputContext.restoreGState()
        }

        // Add in color tint.
        if let v = tintColor {
            outputContext.saveGState()
            outputContext.setFillColor(v.cgColor)
            outputContext.fill(imageRect)
            outputContext.restoreGState()
        }

        // Output image is ready.
        let outputImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()

        return outputImage
    }


    fileprivate func createEffectBuffer(context: CGContext) -> vImage_Buffer {
        let data = context.data
        let width = vImagePixelCount(context.width)
        let height = vImagePixelCount(context.height)
        let rowBytes = context.bytesPerRow
        return vImage_Buffer(data: data, height: height, width: width, rowBytes: rowBytes)
    }

}
