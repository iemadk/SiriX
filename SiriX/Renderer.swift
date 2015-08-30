import UIKit

protocol Gradient : FillStyle {
    var startCenter: CGPoint { get }
    var startRadius: CGFloat { get }
    var endCenter: CGPoint { get }
    var endRadius: CGFloat { get }
    var drawsAfterEndLocation: Bool { get }
    var colors:[UIColor] { get set }
}

protocol FillStyle {
    func fill(renderer:Renderer)
}

protocol Renderer {
    
    func setStrokeStyle(color:UIColor)
    func setFillColor(color:UIColor)
    func setLineWidth(width:CGFloat)
    
    /// Moves the pen to `position` without drawing anything.
    func moveTo(position: CGPoint)
    
    /// Draws a line from the pen's current position to `position`, updating
    /// the pen position.
    func lineTo(position: CGPoint)
    
    /// Draws the fragment of the circle centered at `c` having the given
    /// `radius`, that lies between `startAngle` and `endAngle`, measured in
    /// radians.
    func arcAt(center: CGPoint, radius: CGFloat, startAngle: CGFloat, endAngle: CGFloat)
    
    func createRadialGradient(startPoint:CGPoint, startRadius:CGFloat, endCenter:CGPoint, endRadius:CGFloat) -> Gradient
    
    func beginPath()
    func closePath()
    func fill()
    func fill(style:FillStyle)
    
    func fillRect(rect:CGRect)
    func stroke()
}

protocol Drawable {
    /// Issues drawing commands to `renderer` to represent `self`.
    func draw(renderer: Renderer)
    init()
}
