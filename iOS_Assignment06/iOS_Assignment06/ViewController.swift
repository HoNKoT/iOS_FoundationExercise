import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var resultLabel: UILabel!
    
    @IBOutlet weak var amountTextField: UITextField!
    
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var tipSlider: UISlider!
    
    var amount: Double = 100.0
    var tipRate: Int = 15

    override func viewDidLoad() {
        super.viewDidLoad()
        amountTextField.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func updateResult() {
        let result = amount * ((Double(tipRate) / 100.0) + 1.0)
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        let formattedResult = formatter.string(from: result as NSNumber) // "$123.44"
//        String(format: "$ %.02f", locale: Locale.current, arguments: 3)
        resultLabel.text = formattedResult
    }

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        // Find out what the text field will be after adding the current edit
        let text = (textField.text! as NSString).replacingCharacters(in: range, with: string)
        
        if let double = Double(text) {
            amount = double
            updateResult()
            return true
        } else {
            return false
        }
    }
    
    @IBAction func slideWatcher(sender: UISlider) {
        tipRate = Int(sender.value)
        tipLabel.text = "\(tipRate) %"
        updateResult()
    }
}

