import UIKit

class CampaignAddController : UIViewController {
    
    @IBOutlet weak var CampaignName: UITextField!
    @IBOutlet weak var CampaignDescription: UITextField!
    @IBOutlet weak var CampaignPassword: UITextField!
    
    let fail = UIAlertController(title: "Failure", message: "Campaign has not been created due to an error.", preferredStyle: .alert);
    let success = UIAlertController(title: "Done", message: "Campaign has been successfully created.", preferredStyle: .alert);
    let empty = UIAlertController(title: "Empty", message: "An item has not been filled in.", preferredStyle: .alert);
    let OKAction = UIAlertAction(title: "OK", style: .default);
    
    @IBAction func AddAction(_ sender: Any) {
        if(CampaignName.text == nil || CampaignDescription == nil) {
            self.present(self.empty, animated: true);
        } else {
            AddCampaign(campaignname: CampaignName.text!, campaignDescription: CampaignDescription.text!, campaignPassword: CampaignPassword.text!, completion: {
                (ok: Bool, message: String?, error: Error?) in
                if(ok) {
                    self.present(self.success, animated: true, completion: {
                        self.emptyEverything();
                    });
                } else {
                    self.present(self.fail, animated: true);
                }
            });
        }
    }
    
    @IBAction func CancelItem(_ sender: Any) {
        dismiss(animated: true, completion: nil);
    }
    
    func emptyEverything() {
        CampaignName.text = nil;
        CampaignDescription.text = nil;
        CampaignPassword.text = nil;
    }
    
    override func viewDidLoad() {
        super.viewDidLoad();
        fail.addAction(OKAction);
        success.addAction(OKAction);
        empty.addAction(OKAction);
        self.emptyEverything();
    }
}
