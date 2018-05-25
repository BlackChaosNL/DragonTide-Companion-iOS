import UIKit

class RegistrationViewController: UIViewController {

    @IBOutlet weak var EMailAddress: UITextField!
    @IBOutlet weak var Username: UITextField!
    @IBOutlet weak var FirstPassword: UITextField!
    @IBOutlet weak var SecondPassword: UITextField!
    let error = UIAlertController(title: "Problem", message: "Something went wrong sending the information, please fix the marked fields and try again, thanks.", preferredStyle: .alert);
    let OKAction = UIAlertAction(title: "OK", style: .default);
    
    @IBAction func KillSegue(_ sender: Any) {
        dismiss(animated: true, completion: nil);
    }
    
    @IBAction func CreateAccount(_ sender: Any) {
        if(verifyAccount() && verifyPassword())
        {
            dismiss(animated: true, completion: nil);
        }
        present(error, animated: true, completion: nil);
    }
    
    func verifyAccount() -> Bool {
        // Check if account exists, maybe through
        if(EMailAddress.text != "" && Username.text != "") {
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
    
    override func viewDidLoad() {
        super.viewDidLoad();
        EMailAddress.text = nil;
        Username.text = nil;
        FirstPassword.text = nil;
        SecondPassword.text = nil;
        error.addAction(OKAction);
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning();
    }

}
