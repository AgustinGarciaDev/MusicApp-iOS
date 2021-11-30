import UIKit

class HighlightButton: UIButton {

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setTitleColor(.red, for: .highlighted)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    override var isHighlighted: Bool {
        get {
            return super.isHighlighted
        }
        set {
            if newValue {
                backgroundColor = .red
            }
            else {
                backgroundColor = .orange
            }
            super.isHighlighted = newValue
        }
    }

}
