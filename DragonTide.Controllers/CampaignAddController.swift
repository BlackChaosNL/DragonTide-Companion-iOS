import UIKit

class CampaignAddController : UIViewController {
    
    @IBOutlet weak var CampaignName: UITextField!
    @IBOutlet weak var CampaignDescription: UITextField!
    @IBOutlet weak var CampaignPassword: UITextField!
    
    let failed = UIAlertController(title: "Failure", message: "Campaign has not been created due to an error.", preferredStyle: .alert);
    let success = UIAlertController(title: "Done", message: "Campaign has been successfully created.", preferredStyle: .alert);
    let empty = UIAlertController(title: "Empty", message: "An item has not been filled in.", preferredStyle: .alert);
    let OKAction = UIAlertAction(title: "OK", style: .default);
    
    @IBAction func AddAction(_ sender: Any) {
        if(CampaignName.text == nil || CampaignDescription.text == nil) {
            self.present(self.empty, animated: false, completion: nil);
        } else {
            let temp = UIViewController.displaySpinner(onView: self.view);
            AddCampaign(campaignname: CampaignName.text!, campaignDescription: CampaignDescription.text!, campaignPassword: CampaignPassword.text!, completion: {
                (ok: Bool, message: String?, error: Error?) in
                UIViewController.removeSpinner(spinner: temp);
                if(ok) {
                    self.present(self.success, animated: true, completion: {
                        self.emptyEverything();
                    });
                } else {
                    self.present(self.failed, animated: true, completion: nil);
                }
            });
        }
    }
    
    @IBAction func CancelItem(_ sender: Any) {
        dismiss(animated: true, completion: nil);
    }
    
    func emptyEverything() {
        CampaignName.text = "";
        CampaignDescription.text = "";
        CampaignPassword.text = "";
    }
    
    override func viewDidLoad() {
        super.viewDidLoad();
        failed.addAction(OKAction);
        success.addAction(OKAction);
        empty.addAction(OKAction);
        self.emptyEverything();
    }
}
