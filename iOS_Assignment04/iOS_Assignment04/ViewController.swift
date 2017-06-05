import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var currentImageView: UIImageView!
    
    var currentLocation: Location = Location.Doorway

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if (!currentLocation.isRootLocation()) {
            let rightButton = UIBarButtonItem(title: "RESET", style: .plain, target: self, action: #selector(ViewController.backToRoot))
            self.navigationItem.rightBarButtonItem = rightButton
        }
        
        currentImageView.image = currentLocation.getImage()
        let children = currentLocation.getChildren()

        var buttonYPosition =
            currentImageView.frame.height +
                currentImageView.bounds.height
        
        for (idx, child) in children.enumerated() {
            let goingToChildButton = UIButton(frame: CGRect(x: view.bounds.width / 2 - 100,
                                                            y: buttonYPosition,
                                                            width: 200,
                                                            height: 50))
            
            print(buttonYPosition)
            
            goingToChildButton.tag = idx
            print(idx)
            goingToChildButton.addTarget(
                self,
                action: #selector(ViewController.pushToNextLocation(sender:)),
                for: .touchUpInside)

            goingToChildButton.setTitle(child.rawValue, for: UIControlState.normal)
            goingToChildButton.titleLabel?.tintColor = .red
            goingToChildButton.backgroundColor = UIColor.blue
            view.addSubview(goingToChildButton)
            
            buttonYPosition += 50
        }
    }
    
    func pushToNextLocation(sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let newVC = storyboard.instantiateViewController(withIdentifier: "viewController") as! ViewController
        let children = currentLocation.getChildren()
        let nextLocation = children[sender.tag]
        newVC.currentLocation = nextLocation
        self.navigationController?.pushViewController(newVC, animated: true)

    }
    
    func backToRoot() {
        self.navigationController?.popToRootViewController(animated: true)
    }
}

public protocol EnumEnumerable {
    associatedtype Case = Self
}

public extension EnumEnumerable where Case: Hashable {
    private static var iterator: AnyIterator<Case> {
        var n = 0
        return AnyIterator {
            defer { n += 1 }
            
            let next = withUnsafePointer(to: &n) {
                UnsafeRawPointer($0).assumingMemoryBound(to: Case.self).pointee
            }
            return next.hashValue == n ? next : nil
        }
    }
    
    public static func enumerate() -> EnumeratedSequence<AnySequence<Case>> {
        return AnySequence(self.iterator).enumerated()
    }
    
    public static var cases: [Case] {
        return Array(self.iterator)
    }
    
    public static var count: Int {
        return self.cases.count
    }
}


enum Location: String, EnumEnumerable, Equatable {
    case Doorway = "Doorway"
    case CoatRoom = "Coat room"
    case Library = "Library"
    case DiningRoom = "Dining room"
    case StairsUp = "Stairs up"
    case Kichen = "Kitchen"
    case Bedroom = "Bedroom"
    case Bathroom = "Bathroom"
    case BackPorch = "Back porch"
    case SecretPassage = "Secret passage"
    case Dungeon = "Dungeon"
    case Labratory = "Laboratory"
    case MysteriousLake = "Mysterious lake"
    case Generator = "Generator"
    case CursedChalice = "Cursed chalice"

    private func getParent() -> Location? {
        switch self {
        case .Doorway: return nil

        case .CoatRoom: return .Doorway

        case .Library: fallthrough
        case .DiningRoom: fallthrough
        case .StairsUp: return .CoatRoom

        case .Bedroom: fallthrough
        case .Bathroom: return .StairsUp

        case .Kichen: return .DiningRoom
        case .BackPorch: return .Kichen

        case .SecretPassage: return .Library

        case .Dungeon: fallthrough
        case .Labratory: fallthrough
        case .MysteriousLake: return .SecretPassage

        case .Generator: return .Labratory
        case .CursedChalice: return .MysteriousLake
        }
    }
    
    func isRootLocation() -> Bool {
        return getParent() == nil
    }
    
    func getImage() -> UIImage {
        switch self {
        case .Doorway: return UIImage(named: "front_door")!
        case .CoatRoom: return UIImage(named: "coat_room")!
        case .Library: return UIImage(named: "library")!
        case .DiningRoom: return UIImage(named: "dining_room")!
        case .StairsUp: return UIImage(named: "stairs_up")!
        case .Bedroom: return UIImage(named: "bedroom")!
        case .Bathroom: return UIImage(named: "bathroom")!
        case .Kichen: return UIImage(named: "kitchen")!
        case .BackPorch: return UIImage(named: "back_porch")!
        case .SecretPassage: return UIImage(named: "secret_passage")!
        case .Dungeon: return UIImage(named: "dungeon")!
        case .Labratory: return UIImage(named: "labratory")!
        case .MysteriousLake: return UIImage(named: "mysterious_lake")!
        case .Generator: return UIImage(named: "generator")!
        case .CursedChalice: return UIImage(named: "cursed_chalice")!
        }
    }
    
    static func ==(left: Location, right: Location) -> Bool {
        return left.rawValue == right.rawValue
    }

    func getChildren() -> [Location] {
        return Location.cases.filter { $0.getParent() == self}
    }
}
