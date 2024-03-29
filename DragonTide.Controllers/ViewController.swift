import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var email: UITextField!
    
    let notFilledInCorrectly = UIAlertController(title: "Problem", message: "Account could not be found or credentials are incorrect.", preferredStyle: .alert);
    let OK = UIAlertAction(title: "OK", style: .default);
    
    @IBAction func LoginSequence(_ sender: Any) {
        let temp = UIViewController.displaySpinner(onView: self.view);
        loginAction(email: self.email.text!, password: self.password.text!) { (ok: Bool, token: Token?, error: Error?) in
            UIViewController.removeSpinner(spinner: temp);
            if (!ok) {
                self.present(self.notFilledInCorrectly, animated: true, completion: nil);
                self.password.text = nil;
            } else {
                SetValue(token, key: "AccessToken", saveType: .Persistent);
                self.performSegue(withIdentifier: "CampaignList", sender: Any?.self);
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad();
        notFilledInCorrectly.addAction(OK);
        
    }

    override func viewDidAppear(_ animated: Bool) {
        let item: Token? = GetValue(key: "AccessToken", loadType: .Persistent);
        if(item != nil && (item?.expires!)! <= Date.init()) {
            self.performSegue(withIdentifier: "CampaignList", sender: Any?.self);
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

