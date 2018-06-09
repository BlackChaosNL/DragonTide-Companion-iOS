import Foundation

func retrieveCampaignListAction(completion: ((_ ok: Bool, _ message: [Campaign]?, _ error: Error?) -> Void)?) {
    var request = URLRequest(url: URL(string: "https://dragontide.herokuapp.com/campaign")!);
    request.httpMethod = "GET";
    request.addValue("", forHTTPHeaderField: "Accept-Encoding");
    request.addValue("application/json", forHTTPHeaderField: "Content-Type");
    let accessToken: Token = GetCacheValue(key: "AccessToken")!;
    request.addValue("Bearer " + accessToken.token, forHTTPHeaderField: "Authorization");
    let session = URLSession(configuration: URLSessionConfiguration.default);
    
    let task = session.dataTask(with: request) { (Data, Response, Error) in
        DispatchQueue.main.async {
            if let error = Error {
                completion?(false, nil, error);
            } else if let jsonData = Data {
                let result = try? JSONSerialization.jsonObject(with: jsonData) as! [String: Any];
                let ok = result!["ok"] as? Bool;
                
                if(!ok!) {
                    completion?(ok!, nil, nil);
                }
                
                var c: [Campaign] = [];
                
                let campaigns = result!["campaigns"] as! [[String : Any]];
                
                for campaign in campaigns {
                    let title = campaign["title"] as! String;
                    let description = campaign["description"] as! String;
                    let dm = campaign["dm"] as! User;
                    let active = campaign["active"] as! Bool;
                    let prive = campaign["private"] as! Bool;
                    let password = campaign["password"] as! String;
                    c.append(Campaign(title: title, description: description, dm: dm, active: active, privat: prive, password: password));
                }
                
                completion?(ok!, c, nil);
            } else {
                let err = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey : "Data could not be requested"]) as Error;
                completion?(false, nil, err);
            }
        }
    };
    task.resume();
}
