import UIKit

extension CGFloat {
    static func random(range:CGFloat) -> CGFloat {
        return CGFloat(CGFloat(arc4random_uniform(1000)) / 1000.0) * range
    }
}

final class SiriWave9Curve {
    struct Controlller {
        let amplitude:CGFloat = 0
        let MAX:CGFloat = 1.0
        let speed:CGFloat
        let width:CGFloat
        let height:CGFloat
    }
    
    typealias ControllerType = Controlller
    
    struct Options {
        let controller:ControllerType
        let jsColor:JSColor
        let tick = 0
    }
    
    let controller : ControllerType
    let jsColor: JSColor
    var tick:CGFloat
    
    init(opt:Options) {
        controller = opt.controller
        jsColor = opt.jsColor
        tick = 0
        amplitude = CGFloat.random(0.7) + 0.3
        seed = CGFloat.random(1.0)
        open_class = CGFloat.random(3) + 2.0
    }
    
    var amplitude:CGFloat
    var seed:CGFloat
    var open_class:CGFloat
    
    func respawn() {
        amplitude = CGFloat.random(0.7) + 0.3
        seed = CGFloat.random(1.0)
        open_class = CGFloat.random(3) + 2.0
    }

    func equation(i:CGFloat) -> CGFloat {
        let p = tick
        let y = -1 * abs(sin(p)) * controller.amplitude * amplitude * controller.MAX * pow(1.0 / (1.0 + pow(open_class * i , 2.0 ) ), 2.0)
        
        if (abs(y) < 0.001)
        {
            respawn()
        }
        return y
    }
    
    func draw(renderer:Renderer) {
        _draw(-1,renderer: renderer)
        _draw(1, renderer: renderer)
    }
    
    func _draw(m:CGFloat, renderer:Renderer) {
        
        tick += controller.speed * (1 - 0.5 * sin(seed * CGFloat(M_PI)))
        
        renderer.beginPath()
        renderer.moveTo(CGPointMake(0, 0))
        
        let x_base = controller.width / 2.0 + ( -controller.width / 4.0 + seed * (controller.width / 2.0) )
        let y_base = controller.height / 2.0
        
        var x_init = CGFloat.max
        
        let grainSize = CGFloat(0.01)
        let min = CGFloat(-3)
        let max = CGFloat(3)
        let range = Range<Int>(start: Int(min/grainSize), end: Int(max/grainSize))
        
        var points = range.map { step -> CGPoint in
            let i = grainSize * CGFloat(step)
            let x = x_base + (i * controller.width / 4.0)
            let y = y_base + (m * equation(i))
            if x_init == CGFloat.max { x_init = x }
            return CGPointMake(x, y)
        }
        points.append(CGPointMake(x_init, y_base))
        points.forEach { renderer.lineTo($0) }
        
        renderer.closePath();

// gradient
        #if false
        let h = abs(equation(0))
        let point = CGPointMake(x_base, y_base)
        var gradient = renderer.createRadialGradient(point, startRadius: h * 1.15, endCenter: point, endRadius: h * 0.3)
        gradient.colors = [UIColor(hex: jsColor.hex, alpha: 0.4), UIColor(hex: jsColor.hex, alpha: 0.3)]
        renderer.fill(gradient)
        #endif
//        var gradient = renderer.createRadialGradient(x_base, y_base, h*1.15, x_base, y_base, h * 0.3 );
//        gradient.addColorStop(0, 'rgba(' + this.color.join(',') + ',0.4)');
//        gradient.addColorStop(1, 'rgba(' + this.color.join(',') + ',0.2)');
//        renderer.fillStyle = gradient;

        renderer.setFillColor(UIColor.greenColor())
        renderer.fill()
    }
}

class SiriWave9 : Drawable {
    
    static let COLORS:[JSColor] = [
        JSColor([32,133,252]),
        JSColor([94,252,169]),
        JSColor([253,71,103])
    ]
    
    var tick:CGFloat = 0
    var ratio:CGFloat
    var width:CGFloat
    var height:CGFloat
    var MAX:CGFloat
    var amplitude:CGFloat
    var speed:CGFloat
    
    struct Options {
        let ratio:CGFloat = 1.0
        var width:CGFloat = 320
        var height:CGFloat = 100
        var amplitude:CGFloat = 1.0
    }
    
    let curves:[SiriWave9Curve]
    
    required init() {
        let opt = Options()
        ratio = opt.ratio
        
        width = ratio * opt.width
        height = ratio * opt.height
        MAX = height/2
        
        speed = 0.1
        amplitude = opt.amplitude
        
        let controlller = SiriWave9Curve.ControllerType(speed: speed, width: width, height: height)
        self.curves = SiriWave9.COLORS.map {
            return SiriWave9Curve(opt: SiriWave9Curve.Options(controller: controlller, jsColor: $0 ) )
        }
    }
    
    init(opt:Options) {
        
        ratio = opt.ratio
        
        width = ratio * opt.width
        height = ratio * opt.height
        MAX = height/2
        
        speed = 0.1
        amplitude = opt.amplitude
        
        let controlller = SiriWave9Curve.ControllerType(speed: speed, width: width, height: height)
        self.curves = SiriWave9.COLORS.map {
            return SiriWave9Curve(opt: SiriWave9Curve.Options(controller: controlller, jsColor: $0 ) )
        }
    }
    
    func clear(renderer:Renderer) {
//        ctx.globalCompositeOperation = 'destination-out'
        renderer.setFillColor(UIColor.clearColor())
        
        renderer.fillRect(CGRectMake(0, 0, width, height))
//        ctx.globalCompositeOperation = 'lighter'
    }
    func draw(renderer:Renderer) {
        clear(renderer)
        self.curves.forEach { $0.draw(renderer) }
//        requestAnimationFrame(_draw.bind(this))
    }
}