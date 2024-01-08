

import UIKit

class WeightConverterViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet var metricToggle: UISegmentedControl!
    @IBOutlet var weightField: UITextField!
    
    var lbWeight: Measurement<UnitMass>?
    var kgWeight: Measurement<UnitMass>?
    
    var isMetric: Bool = false // false = lbs, true = kgs
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        weightField.resignFirstResponder()
        print(NSLocalizedString("Tapped background", comment: "Tapped background"))
    }
    
    @IBAction func weightFieldChanged(_ textField: UITextField) {
        if let text = textField.text {
            let currentLocale = Locale.current
            let decimalSeparator = currentLocale.decimalSeparator ?? "."
            let sanitizedText = text.replacingOccurrences(of: ",", with: decimalSeparator)
            if let value = Double(sanitizedText) {
                if self.isMetric {
                    kgWeight = Measurement(value: value, unit: .kilograms)
                    lbWeight = kgWeight!.converted(to: .pounds)
                } else {
                    lbWeight = Measurement(value: value, unit: .pounds)
                    kgWeight = lbWeight!.converted(to: .kilograms)
                }
            } else {
                kgWeight = nil
                lbWeight = nil
            }
        } else {
            kgWeight = nil
            lbWeight = nil
        }
    }
    
    @IBAction func toggleMetric(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            // Weight in Pounds (lb)
            convertToLbs()
            self.isMetric = false
        } else {
            // Weight in Kilograms (kg)
            convertToKgs()
            self.isMetric = true
        }
    }
    
    func convertToLbs() {
        // Convert weight from kg to lbs
        if let lbs = lbWeight {
            weightField.text = formattedNumber(lbs.value)
        } else {
            weightField.text = NSLocalizedString("???", comment: "Unknown weight")
        }
        print(NSLocalizedString("It is now in Pounds (lb)", comment: "Now in Pounds (lb)"))
    }
    
    func convertToKgs() {
        // Convert weight from lbs to kgs
        if let kgs = kgWeight {
            weightField.text = formattedNumber(kgs.value)
        } else {
            weightField.text = NSLocalizedString("???", comment: "Unknown weight")
        }
        print(NSLocalizedString("It is now in Kilograms (kg)", comment: "Now in Kilograms (kg)"))
    }
    
    //adding a international delegate method to prevent user from entering multiple decimals
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let currentLocale = Locale.current
        let decimalSeparator = currentLocale.decimalSeparator ?? "."
        
        let existingTextHasDecimalSeparator = textField.text?.range(of: decimalSeparator)
        let replacementTextHasDecimalSeparator = string.range(of: decimalSeparator)
        
        if existingTextHasDecimalSeparator != nil,
           replacementTextHasDecimalSeparator != nil {
            return false
        }
        else {
            return true
        }
        
    }
    
    private func formattedNumber(_ value: Double) -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        numberFormatter.minimumFractionDigits = 0
        numberFormatter.maximumFractionDigits = 2
        
        // Use the system locale to format numbers based on the user's device settings
        numberFormatter.locale = Locale.autoupdatingCurrent
        return numberFormatter.string(from: NSNumber(value: value)) ?? ""
    }
     
}
