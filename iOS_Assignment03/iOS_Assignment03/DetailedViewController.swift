import UIKit

class DetailedViewController: UIViewController {
    var city: City
    
    // this is a convenient way to create this view controller without a imageURL
    
    convenience init() {
        self.init(nil)
    }
    
    init(_ city: City?) {
        self.city = city!
        super.init(nibName: nil, bundle:nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let button: UILabel = UILabel(frame: CGRect(x: view.bounds.width / 2 - 50,
                                                      y: view.bounds.height / 2,
                                                      width: 100,
                                                      height: 50))
        button.text = city.cityName
        
        view.addSubview(button)
    }
}
