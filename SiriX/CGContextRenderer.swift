import UIKit

extension Int : FillStyle {
    func fill(renderer: Renderer) {
        
    }
}

extension CGContext  : Renderer {
    
    func setStrokeStyle(color: UIColor) {
        color.setStroke()
    }
    
    func fill(style:FillStyle) {
        style.fill(self)
    }
    
    func setFillColor(color: UIColor) {
        color.setFill()
    }
    func setLineWidth(width: CGFloat) {
        CGContextSetLineWidth(self, width)
    }
    /// Moves the pen to `position` without drawing anything.
    func moveTo(position: CGPoint) {
        CGContextMoveToPoint(self, position.x, position.y)
    }
    
    /// Draws a line from the pen's current position to `position`, updating
    /// the pen position.
    func lineTo(position: CGPoint) {
        CGContextAddLineToPoint(self, position.x, position.y)
    }
    
    func arcAt(center: CGPoint, radius: CGFloat, startAngle: CGFloat, endAngle: CGFloat) {
        let arc = CGPathCreateMutable()
        CGPathAddArc(arc, nil, center.x, center.y, radius, startAngle, endAngle, true)
        CGContextAddPath(self, arc)
    }
    
    func beginPath() {
        CGContextBeginPath(self)
    }
    func closePath() {
        CGContextClosePath(self)
    }
    func fill() {
        CGContextFillPath(self)
    }
    func stroke() {
        CGContextStrokePath(self)
    }
    func fillRect(rect:CGRect) {
        CGContextFillRect(self, rect)
    }
    
}
