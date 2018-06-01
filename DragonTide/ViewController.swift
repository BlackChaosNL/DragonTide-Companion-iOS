import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var email: UITextField!
    
    @IBAction func LoginSequence(_ sender: Any) {
        loginAction(email: self.email.text!, password: self.password.text!) { (ok: Bool, token: Token?, error: Error?) in
            if (!ok) {
                fatalError(error.debugDescription);
            } else {
                self.performSegue(withIdentifier: "CampaignList", sender: Any?.self);
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

