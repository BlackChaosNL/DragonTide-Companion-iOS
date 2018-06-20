import UIKit

class CampaignListViewController: UITableViewController {
    
    var Campaigns: [Campaign] = [];
    
    @IBAction func LogoutAction(_ sender: Any) {
        DestroyValue(key: "AccessToken", saveType: .Persistent);
        dismiss(animated: true, completion: nil);
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1;
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Campaigns.count;
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LabelCell", for: indexPath);
        cell.textLabel?.text = Campaigns[indexPath.row].title;
        cell.detailTextLabel?.text = Campaigns[indexPath.row].description;
        return cell;
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        tableView.deselectRow(at: indexPath, animated: true);
        SetValue(Campaigns[indexPath.row], key: "SelectedCampaign", saveType: .Temporary);
        self.performSegue(withIdentifier: "CampaignDetail", sender: Any?.self);
    }
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let delete = UITableViewRowAction(style: .destructive, title: "Delete") { (action, indexPath) in
            NSLog("Delete tapped on: " + self.Campaigns[indexPath.row].title);
            // Request deletion
            deleteCampaignAction(campaign: self.Campaigns[indexPath.row], completion: {
                (ok: Bool, deleted: Bool?, error: Error?) in
                if(ok) {
                    // delete item at indexPath
                    self.Campaigns.remove(at: indexPath.row);
                    tableView.deleteRows(at: [indexPath], with: .fade);
                    // Refresh tableView
                    tableView.reloadData();
                }
            });
        };
        return [delete];
    }

    override func viewDidLoad() {
        super.viewDidLoad();
        let temp = UIViewController.displaySpinner(onView: self.view);
        retrieveCampaignListAction(completion: {
            (ok: Bool, campaigns: [Campaign]?, error: Error?) in
            if(ok) {
                self.Campaigns = campaigns!;
                self.tableView.reloadData();
            }
            UIViewController.removeSpinner(spinner: temp);
        });
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning();
    }
}
