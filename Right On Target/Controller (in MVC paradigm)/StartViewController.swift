import UIKit

class StartViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
 
    @IBAction func showNumberGameScreen() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewControllerGame = storyboard.instantiateViewController(identifier: "ViewController")
        self.present(viewControllerGame, animated: true, completion: nil)
    }
    
    @IBAction func showColorsGameScreen(){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewControllerGame = storyboard.instantiateViewController(identifier: "ColorsGame")
        self.present(viewControllerGame, animated: true, completion: nil)
    }
    
}
