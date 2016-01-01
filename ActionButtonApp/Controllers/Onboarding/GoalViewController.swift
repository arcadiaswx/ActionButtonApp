import UIKit

class GoalViewController: OnboardingViewController, UITextFieldDelegate {

    @IBOutlet weak var goalTextField: UITextField!
    @IBOutlet weak var goalSuffixLabel: UILabel!
    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var goalBackgroundView: UIView!
    let userDefaults = NSUserDefaults.groupUserDefaults()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.goalTextField.inputAccessoryView = Globals.numericToolbar(self, selector: Selector("dismissAndSave"))
        self.goalBackgroundView.addGestureRecognizer(UITapGestureRecognizer(target: self.goalTextField, action: Selector("becomeFirstResponder")))
    }

    func dismissAndSave() {
        guard let text = goalTextField.text else {
            return
        }

        let numberFormatter = NSNumberFormatter()
        numberFormatter.numberStyle = .DecimalStyle

        self.goalTextField.resignFirstResponder()

        var goal = 0.0
        if let number = numberFormatter.numberFromString(text) {
            goal = number as Double
        }

        self.userDefaults.setDouble(goal, forKey: ComplexConstants.Prayr.Goal.key())
        self.userDefaults.synchronize()
    }

    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()

        dismissAndSave()

        return true
    }

    override func updateUI() {
        let numberFormatter = NSNumberFormatter()
        numberFormatter.numberStyle = .DecimalStyle
        self.goalTextField.text = numberFormatter.stringFromNumber(self.userDefaults.doubleForKey(ComplexConstants.Prayr.Goal.key()))
        let unit = ComplexConstants.UnitsOfMeasure(rawValue: self.userDefaults.integerForKey(ComplexConstants.General.UnitOfMeasure.key()))

        if let unit = unit {
            self.goalSuffixLabel.text = unit.suffixForUnitOfMeasure()
        }
    }
}
