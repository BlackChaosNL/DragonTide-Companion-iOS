import UIKit

class RegistrationViewController: UIViewController {

    @IBOutlet weak var EMailAddress: UITextField!
    @IBOutlet weak var Username: UITextField!
    @IBOutlet weak var FirstPassword: UITextField!
    @IBOutlet weak var SecondPassword: UITextField!
    
    let notFilledInCorrectly = UIAlertController(title: "Problem", message: "Something went wrong sending the information, E-Mail or username might exist already, thanks.", preferredStyle: .alert);
    let error = UIAlertController(title: "Problem", message: "Fields are not filled correctly", preferredStyle: .alert);
    let success = UIAlertController(title: "Done", message: "Account has been successfully created", preferredStyle: .alert);
    let OKAction = UIAlertAction(title: "OK", style: .default);
    
    @IBAction func KillSegue(_ sender: Any) {
        dismiss(animated: true, completion: nil);
    }
    
    @IBAction func CreateAccount(_ sender: Any) {
        let temp = UIViewController.displaySpinner(onView: self.view);
        if(verifyAccount() && verifyPassword())
        {
            registerAction(email: EMailAddress.text!, username: Username.text!, password: FirstPassword.text!) {
                (ok: Bool, result: Bool?, error: Error?) in
                UIViewController.removeSpinner(spinner: temp);
                if(result == false) {
                    self.present(self.notFilledInCorrectly, animated: true, completion: nil);
                } else {
                    self.present(self.success, animated: true, completion: { () in
                        self.emptyEverything();
                    });
                }
            }
        }else{
            self.present(self.error, animated: true, completion: nil);
        }
    }
    
    func verifyAccount() -> Bool {
        if(EMailAddress.text == "" && Username.text == "") {
            return false;
        }
        
        return true;
    }
    
    func verifyPassword() -> Bool {
        if(FirstPassword.text == "" || SecondPassword.text == "" || FirstPassword.text != SecondPassword.text)
        {
            return false;
        }
        
        return true;
    }
    
    func emptyEverything() {
        self.EMailAddress.text = nil;
        self.Username.text = nil;
        self.FirstPassword.text = nil;
        self.SecondPassword.text = nil;
    }
    
    override func viewDidLoad() {
        super.viewDidLoad();
        self.emptyEverything();
        error.addAction(OKAction);
        success.addAction(OKAction);
        notFilledInCorrectly.addAction(OKAction);
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning();
    }

}
