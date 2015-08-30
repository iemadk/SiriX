import UIKit

class DrawView <T:Drawable>: UIView {
    typealias DrawableType = T
    let drawable = DrawableType()
    override func drawRect(rect: CGRect) {
        if let context = UIGraphicsGetCurrentContext() {
            CGContextSaveGState(context)
            drawable.draw(context)
            CGContextRestoreGState(context)
        }
    }
    init() {
        super.init(frame: CGRectZero)
    }
}

class ViewController: UIViewController {

    let drawView = DrawView<SiriWave9>()
//    let drawView = DrawView<SiriWave>()

    override func viewDidLoad() {
        super.viewDidLoad()
        drawView.frame = view.bounds
        view.addSubview(drawView)
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

