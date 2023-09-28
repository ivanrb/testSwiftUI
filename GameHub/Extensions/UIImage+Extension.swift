//
//  UIImage+Extension.swift
//  GameHub
//
//  Created by Ivan Rodriguez on 13/9/23.
//

import UIKit.UIImage

extension UIImage {
    var predominantColor: UIColor? {
        guard let cg = cgImage else { return nil }
        let ciImage = CIImage(cgImage: cg)
        let extentVector = CIVector(x: ciImage.extent.origin.x,
                                    y: ciImage.extent.origin.y,
                                    z: ciImage.extent.width,
                                    w: ciImage.extent.height)
        let params = [kCIInputImageKey: ciImage, kCIInputExtentKey: extentVector] as [String: Any]
        guard let filter = CIFilter(name: "CIAreaAverage", parameters: params) else { return nil }
        guard let output = filter.outputImage else { return nil }
        var bitmap = [UInt8](repeating: 0, count: 4)
        let context = CIContext(options: [.workingColorSpace: kCFNull as Any])
        context.render(output,
                       toBitmap: &bitmap,
                       rowBytes: 4,
                       bounds: CGRect(x: 0, y: 0, width: 1, height: 1),
                       format: .RGBA8,
                       colorSpace: nil)
        return UIColor(red: CGFloat(bitmap[0]) / 255,
                       green: CGFloat(bitmap[1]) / 255,
                       blue: CGFloat(bitmap[2]) / 255,
                       alpha: CGFloat(bitmap[3]) / 255)
    }
}
