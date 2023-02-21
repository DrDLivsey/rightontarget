import UIKit

extension UIColor {
    public convenience init?(hex: String) {
        let r, g, b, a: CGFloat

        if hex.hasPrefix("#") {
            let start = hex.index(hex.startIndex, offsetBy: 1)
            let hexColor = String(hex[start...])

            if hexColor.count == 6 {
                let scanner = Scanner(string: hexColor)
                var hexNumber: UInt64 = 0

                if scanner.scanHexInt64(&hexNumber) {
                    r = CGFloat((hexNumber & 0xff0000) >> 16) / 255
                    g = CGFloat((hexNumber & 0x00ff00) >> 8) / 255
                    b = CGFloat(hexNumber & 0x0000ff) / 255
                    a = 255 / 255

                    self.init(red: r, green: g, blue: b, alpha: a)
                    return
                }
            }
        }

        return nil
    }
}

class ColorsGame: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    func randomHexGenerator()->String{
        var arrayString = ["#"]
        let a = ["1","2","3","4","5","6","7","8","9","a","b","c","d","e","f"]
        for _ in 1...6 {
            arrayString.append(a[Int.random(in: 1..<15)])
        }
        let resultString = arrayString.joined()
        return resultString
    }
    
    
    
    
    
    @IBAction func hideCurrentScene() {
        self.dismiss(animated: true, completion: nil)
    }
    

    
    
    @IBOutlet weak var hexColorLabel: UILabel!
    
    @IBOutlet weak var buttonOption1: UIButton!
    @IBOutlet weak var buttonOption2: UIButton!
    @IBOutlet weak var buttonOption3: UIButton!
    @IBOutlet weak var buttonOption4: UIButton!
    
    
    
    @IBAction func option1() {
        self.hexColorLabel.text = randomHexGenerator()
        buttonOption1.backgroundColor = UIColor(hex: hexColorLabel.text ?? "0xff")
    }
    
    @IBAction func option2() {
        self.hexColorLabel.text = randomHexGenerator()
        buttonOption2.backgroundColor = UIColor(hex: hexColorLabel.text ?? "0xff")
    }
    
    @IBAction func option3() {
        self.hexColorLabel.text = randomHexGenerator()
        buttonOption3.backgroundColor = UIColor(hex: hexColorLabel.text ?? "0xff")
    }
    
    @IBAction func option4() {
        self.hexColorLabel.text = randomHexGenerator()
        buttonOption4.backgroundColor = UIColor(hex: hexColorLabel.text ?? "0xff")
    }

}
