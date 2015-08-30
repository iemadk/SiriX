import UIKit

protocol CanFillRenderedGradient {
    func fillGradient(gradient:RenderedGradient)
}

struct RenderedGradient : Gradient {
    let startCenter: CGPoint
    let startRadius: CGFloat
    let endCenter: CGPoint
    let endRadius: CGFloat
    let drawsAfterEndLocation: Bool
    var colors = [UIColor]()
    func fill(renderer: Renderer) {
        if let canFillMe = renderer as? CanFillRenderedGradient {
            canFillMe.fillGradient(self)
        }
    }
}

extension CGContext {
    
    func createRadialGradient(startPoint: CGPoint, startRadius: CGFloat, endCenter: CGPoint, endRadius: CGFloat) -> Gradient {
        return RenderedGradient(startCenter: startPoint, startRadius: startRadius, endCenter: endCenter, endRadius: endRadius, drawsAfterEndLocation: true, colors: [UIColor]())
    }

    func fillGradient(gradient:RenderedGradient) {
        let gradientRef = CGGradientCreateWithColors(CGColorSpaceCreateDeviceRGB(), gradient.colors, [0,1])
        var options = CGGradientDrawingOptions.DrawsAfterEndLocation
        if gradient.drawsAfterEndLocation {
            options = CGGradientDrawingOptions.DrawsBeforeStartLocation
        }
        CGContextDrawRadialGradient(self, gradientRef, gradient.startCenter, gradient.startRadius, gradient.endCenter, gradient.endRadius, options)
    }
}

