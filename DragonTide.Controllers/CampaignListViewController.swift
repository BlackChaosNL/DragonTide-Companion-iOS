import UIKit

class CampaignListViewController: UITableViewController {
    
    var Campaigns: [Campaign] = [];
    
    @IBAction func LogoutAction(_ sender: Any) {
        // Remove key and pop view.
        
        dismiss(animated: true, completion: nil);
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Campaigns.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LabelCell", for: indexPath);
        cell.textLabel?.text = Campaigns[indexPath.row].title;
        cell.detailTextLabel?.text = Campaigns[indexPath.row].description;
        return cell;
    }
    
    override func viewDidLoad() {
        super.viewDidLoad();
        let temp = UIViewController.displaySpinner(onView: self.view);
        retrieveCampaignListAction(completion: {
            (ok: Bool, campaigns: [Campaign]?, error: Error?) in
            if(ok) {
                self.Campaigns = campaigns!;
                tableView.reloadData();
            }
            UIViewController.removeSpinner(spinner: temp);
        });
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning();
    }
}
