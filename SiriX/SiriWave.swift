import UIKit

class SiriWave : Drawable {
    
    struct Options {
        var ratio:CGFloat = 1
        var amplitude:CGFloat = 1
        var speed:CGFloat = 0.2
        let hexColor:Int = 0xffffff
        var frequency:CGFloat = 6
        let width:CGFloat = 320
        let height:CGFloat = 100
    }

    var phase:CGFloat = 0
    let width:CGFloat
    let width_2:CGFloat
    let width_4:CGFloat
    let height:CGFloat
    let height_2:CGFloat
    let MAX:CGFloat
    var ratio:CGFloat
    var amplitude:CGFloat
    var speed:CGFloat
    var frequency:CGFloat
    let hexColor:Int
    
    required init() {
        let opt = Options()
        ratio = opt.ratio
        amplitude = opt.amplitude
        speed = opt.speed
        frequency = opt.frequency
        hexColor = opt.hexColor
        
        width = ratio * opt.width
        width_2 = width / 2
        width_4 = width / 4
        height = ratio * opt.height
        height_2 = height / 2
        MAX = (height_2) - 4
    }

    init(opt:Options) {
        ratio = opt.ratio
        amplitude = opt.amplitude
        speed = opt.speed
        frequency = opt.frequency
        hexColor = opt.hexColor

        width = ratio * opt.width
        width_2 = width / 2
        width_4 = width / 4
        height = ratio * opt.height
        height_2 = height / 2
        MAX = (height_2) - 4
    }
    
    class Cache {
        var storage = Dictionary<CGFloat,CGFloat>()
        func attFunc(x:CGFloat) -> CGFloat {
            if (storage[x] == nil) {
                storage[x] = pow(4.0/(4.0 + pow(CGFloat(x),4.0)), 4.0)
            }
            return storage[x]!
        }

    }
    let cache = Cache()
    
    func _ypos(i:CGFloat, attenuation:CGFloat) -> CGFloat {
        let att = (MAX * amplitude) / attenuation
        return height_2 + cache.attFunc(i) * att * sin(frequency * i - phase)
    }

    func _xpos(i:CGFloat) -> CGFloat {
        return width_2 + i * width_4
    }

    func draw(var renderer: Renderer) {
        
        func drawLine( renderer:Renderer, attenuation:CGFloat, color:UIColor, width:CGFloat)
        {
            renderer.beginPath()
            renderer.moveTo(CGPointMake(0, 0))
            renderer.setStrokeStyle(color)
            renderer.setLineWidth(width)
            
            var i = CGFloat(-2)
            i += CGFloat(0.01)
            while ( i <= 2.0) {
                i += CGFloat(0.01)
                var y = _ypos(i, attenuation: attenuation)
                if (abs(i) >= 1.90) {
                    y = height_2
                }
                renderer.lineTo(CGPointMake(_xpos(i), y))
            }
            renderer.stroke()
        }
        
        func clear() {
            //        renderer.globalCompositeOperation = 'destination-out'
            renderer.setFillColor(UIColor.clearColor())
            renderer.fillRect(CGRectMake(0, 0, width, height))
            //        renderer.globalCompositeOperation = 'source-over'
        }
        
        phase = (phase + CGFloat(M_PI) * speed) % CGFloat(M_PI_2)
        
        clear()
        drawLine(renderer, attenuation: -2, color: UIColor(hex: hexColor, alpha: 1.0), width:1.0)
        drawLine(renderer, attenuation: -6, color: UIColor(hex: hexColor, alpha: 0.2), width:1.0)
        drawLine(renderer, attenuation: 4, color: UIColor(hex: hexColor, alpha: 0.4), width:1.0)
        drawLine(renderer, attenuation: 2, color: UIColor(hex: hexColor, alpha: 0.6), width:1.0)
        drawLine(renderer, attenuation: 1, color: UIColor(hex: hexColor, alpha: 1), width:1.5)
        //requestAnimationFrame(_draw.bind(this))
    }
    
    /* API */
    func setNoise(v:CGFloat) {
        amplitude = max(min(v, 1), 0)
    }
}
