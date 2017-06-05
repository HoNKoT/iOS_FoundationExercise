import UIKit

class CityViewController: UIViewController {
    
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
        // Do any additional setup after loading the view, typically from a nib.
        self.title = city.cityName
        self.view.backgroundColor = city.cityColor
        
        let button: UIButton = UIButton(frame: CGRect(x: view.bounds.width / 2 - 50,
                                                      y: view.bounds.height / 2,
                                                      width: 100,
                                                      height: 50))
        button.backgroundColor = UIColor.black
        button.addTarget(self, action: #selector(pushToNextVC), for: .touchUpInside)
        
        view.addSubview(button)
    }
    
    func pushToNextVC() {
        let newVC = DetailedViewController(city)
        newVC.view.backgroundColor = UIColor.red
        self.navigationController?.pushViewController(newVC, animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

class City {
    
    let location: Location
    var cityName: String {
        get {
            switch location {
            case Location.Vancouver: return "Vancouver"
            case Location.NewYork: return "New York"
            case Location.Kenya: return "Kenya"
            case Location.Tokyo: return "Tokyo"
            case Location.Osaka: return "Osaka"
            }
        }
    }
    
    var cityImage: UIImage {
        get {
            switch location {
            case Location.Vancouver: return UIImage(named: "icons8-home")!
            case Location.NewYork: return UIImage(named: "icons8-edit")!
            case Location.Kenya: return UIImage(named: "icons8-shopping_cart")!
            case Location.Tokyo: return UIImage(named: "icons8-share")!
            case Location.Osaka: return UIImage(named: "icons8-twitter")!
            }
        }
    }
    
    var citySelectedImage: UIImage {
        get {
            switch location {
            case Location.Vancouver: return UIImage(named: "icons8-home-1")!
            case Location.NewYork: return UIImage(named: "icons8-edit-1")!
            case Location.Kenya: return UIImage(named: "icons8-shopping_cart-1")!
            case Location.Tokyo: return UIImage(named: "icons8-share-1")!
            case Location.Osaka: return UIImage(named: "icons8-twitter-1")!
            }
        }
    }
    
    var cityColor: UIColor {
        get {
            switch location {
            case Location.Vancouver: return UIColor.orange
            case Location.NewYork: return UIColor.blue
            case Location.Kenya: return UIColor.red
            case Location.Tokyo: return UIColor.cyan
            case Location.Osaka: return UIColor.white
            }
        }
    }
    
    var cityTabItem: UITabBarItem {
        get {
            return UITabBarItem(title: cityName, image:cityImage, selectedImage: citySelectedImage)
        }
    }
    
    init(_ location: Location) {
        self.location = location
    }
}

enum Location {
    case Vancouver
    case NewYork
    case Kenya
    case Tokyo
    case Osaka
    
    func cityColor() -> UIColor {
        switch location {
        case .Vancouver: return UIColor.orange
        case .NewYork: return UIColor.blue
        case .Kenya: return UIColor.red
        case .Tokyo: return UIColor.cyan
        case .Osaka: return UIColor.white
        }
    }
}

