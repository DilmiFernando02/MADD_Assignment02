import Foundation
import SwiftUI
import CoreImage.CIFilterBuiltins

struct QRGenerator {
    static func image(from string: String) -> Image {
        let context = CIContext()
        let filter = CIFilter.qrCodeGenerator()
        filter.message = Data(string.utf8)
        filter.correctionLevel = "M"
        if let output = filter.outputImage,
           let cgimg = context.createCGImage(output.transformed(by: CGAffineTransform(scaleX: 10, y: 10)), from: output.extent) {
            return Image(decorative: cgimg, scale: 1.0, orientation: .up)
        }
        return Image(systemName: "qrcode")
    }
}
