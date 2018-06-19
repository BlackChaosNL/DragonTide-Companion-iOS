import UIKit

class CampaignDetailController : UIViewController {
    @IBOutlet weak var Qr: UIImageView!
    @IBOutlet weak var Description: UILabel!
    @IBOutlet weak var TitleVar: UINavigationItem!
    let c: Campaign = GetValue(key: "SelectedCampaign", loadType: .Temporary)!;
    
    @IBAction func DismissDetailView(_ sender: Any) {
        UserDefaults.standard.removeObject(forKey: "SelectedCampaign");
        dismiss(animated: true, completion: nil);
    }
    
    override func viewDidLoad() {
        super.viewDidLoad();
        TitleVar.title = c.title;
        Description.text = c.description;
        Qr.image = generateQRCode(from: c.id + ":" + c.password);
    }
}
