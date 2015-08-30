import UIKit

extension Renderer {
    func createRadialGradient(p1:CGPoint, _ r1:CGFloat, _ p2:CGPoint, _ r2:CGFloat) -> Gradient {
        return Gradient(p1: p1, r1: r1, p2: p2, r2: r2)
    }
}

let EJ_CANVAS_GRADIENT_WIDTH = 1024

enum GradientType {
    case Linear
    case Radial
}

struct GradientColorStop {
    let pos:CGFloat
    let order:UInt
    let hexColor:Int
}

typealias ColorType = Int

class Gradient {
    let type : GradientType
    let p1:CGPoint, p2:CGPoint
    let r1:CGFloat, r2:CGFloat
    
    let colorStops = [CGColorRef]()
    //EJTexture *texture;
    init(p1:CGPoint, p2:CGPoint) {
        self.type = .Linear
        self.p1 = p1;
        self.p2 = p2;
    }
    
    init(p1:CGPoint, r1:CGFloat, p2:CGPoint, r2:CGFloat) {
        self.type = .Radial
        self.p1 = p1
        self.r1 = r1
        self.p2 = p2
        self.r2 = r2
    }
    
    func addStopWithColor(color:ColorType, pos:CGFloat) {
        
    }
    func rebuild() {}
    
}