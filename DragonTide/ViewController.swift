import UIKit

class ViewController: UIViewController {

    @IBAction func LoginSequence(_ sender: Any) {
        performSegue(withIdentifier: "CampaignList", sender: Any?.self);
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        //let destination : CampaignListViewController = segue.destination as! CampaignListViewController;
        // Add data for transport, needed?
        //destination.str = "test";
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

