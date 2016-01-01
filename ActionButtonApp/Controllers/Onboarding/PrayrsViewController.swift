import UIKit
import pop

class PrayrsViewController: OnboardingViewController, UITextFieldDelegate {

    @IBOutlet weak var smallPrayrText: UITextField!
    @IBOutlet weak var bigPrayrText: UITextField!
    @IBOutlet weak var smallSuffixLabel: UILabel!
    @IBOutlet weak var bigSuffixLabel: UILabel!
    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var smallBackgroundView: UIView!
    @IBOutlet weak var bigBackgroundView: UIView!

    let userDefaults = NSUserDefaults.groupUserDefaults()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.smallPrayrText.inputAccessoryView = Globals.numericToolbar(self, selector: Selector("dismissAndSave"))
        self.bigPrayrText.inputAccessoryView = Globals.numericToolbar(self, selector: Selector("dismissAndSave"))

        self.smallBackgroundView.addGestureRecognizer(UITapGestureRecognizer(target: self.smallPrayrText, action: Selector("becomeFirstResponder")))
        self.bigBackgroundView.addGestureRecognizer(UITapGestureRecognizer(target: self.bigPrayrText, action: Selector("becomeFirstResponder")))

        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShow:", name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillHide:", name: UIKeyboardWillHideNotification, object: nil)
    }

    func dismissAndSave() {
        let numberFormatter = NSNumberFormatter()
        numberFormatter.numberStyle = .DecimalStyle

        _ = [self.smallPrayrText, self.bigPrayrText].map({$0.resignFirstResponder()})

        var small = 0.0
        var big = 0.0
        if let number = numberFormatter.numberFromString(self.smallPrayrText.text ?? "0") {
            small = number as Double
        }

        if let number = numberFormatter.numberFromString(self.bigPrayrText.text ?? "0") {
            big = number as Double
        }

        self.userDefaults.setDouble(small, forKey: ComplexConstants.Prayr.Small.key())
        self.userDefaults.setDouble(big, forKey: ComplexConstants.Prayr.Big.key())
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
        self.smallPrayrText.text = numberFormatter.stringFromNumber(self.userDefaults.doubleForKey(ComplexConstants.Prayr.Small.key()))
        self.bigPrayrText.text = numberFormatter.stringFromNumber(self.userDefaults.doubleForKey(ComplexConstants.Prayr.Big.key()))
        let unit = ComplexConstants.UnitsOfMeasure(rawValue: self.userDefaults.integerForKey(ComplexConstants.General.UnitOfMeasure.key()))

        if let unit = unit {
            self.smallSuffixLabel.text = unit.suffixForUnitOfMeasure()
            self.bigSuffixLabel.text = unit.suffixForUnitOfMeasure()
        }
    }

    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        _ = [self.smallPrayrText, self.bigPrayrText].map({$0.resignFirstResponder()})
    }

    func keyboardWillShow(notification: NSNotification) {
        scrollViewTo(-(self.headerLabel.frame.origin.y + self.headerLabel.frame.size.height), from: 0)
    }

    func keyboardWillHide(notification: NSNotification) {
        scrollViewTo(0, from: -(self.headerLabel.frame.origin.y + self.headerLabel.frame.size.height))
    }

    func scrollViewTo(offset: CGFloat, from: CGFloat) {
        let move = POPBasicAnimation(propertyNamed: kPOPLayerTranslationY)
        move.fromValue = from
        move.toValue = offset
        move.removedOnCompletion = true
        self.view.layer.pop_addAnimation(move, forKey: "move")
    }
}
