import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var paintImageView: PaintImageView!
    @IBOutlet weak var penButton: UIButton!
    @IBOutlet weak var eraserButton: UIButton!
    @IBOutlet weak var textButton: UIButton!
//    
//    let paintImageView = PaintImageView.init(image: UIImage.init(named: "03-logo"))

    override func viewDidLoad() {
        super.viewDidLoad()
        paintImageView.frame = self.view.frame
        
        penButton.addTarget(self, action: #selector(penMode), for: .touchUpInside)
        eraserButton.addTarget(self, action: #selector(eraserMode), for: .touchUpInside)
        textButton.addTarget(self, action: #selector(textMode), for: .touchUpInside)
//        
//        self.view.addSubview(paintImageView)
    }
    
    func penMode() {
        paintImageView.mode = Mode.Pen
    }
    
    func eraserMode() {
        paintImageView.mode = Mode.Eraser
    }
    
    func textMode() {
        paintImageView.mode = Mode.Text
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
