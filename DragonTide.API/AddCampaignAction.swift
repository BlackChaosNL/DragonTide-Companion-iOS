import Foundation

func AddCampaign(campaignname: String, campaignDescription: String, campaignPassword: String, completion: ((_ ok: Bool, _ message: String?, _ error: Error?) -> Void)?) {
    var request = URLRequest(url: URL(string: "https://dragontide.herokuapp.com/campaign")!);
    request.httpMethod = "POST";
    if(campaignPassword.isEmpty) {
        request.httpBody = try? JSONSerialization.data(withJSONObject: ["name": campaignname, "description": campaignDescription], options: []);
    } else {
        request.httpBody = try? JSONSerialization.data(withJSONObject: ["name": campaignname, "description": campaignDescription, "password": campaignPassword], options: []);
    }
    request.addValue("", forHTTPHeaderField: "Accept-Encoding");
    request.addValue("application/json", forHTTPHeaderField: "Content-Type");
    let accessToken: Token = GetCacheValue(key: "AccessToken")!;
    request.addValue("Bearer " + accessToken.token, forHTTPHeaderField: "Authorization");
    let configuration = URLSessionConfiguration.default;
    configuration.requestCachePolicy = .reloadIgnoringLocalCacheData;
    configuration.urlCache = nil;
    let session = URLSession(configuration: configuration);
    
    let task = session.dataTask(with: request) {
        (Data, Response, Error) in
        DispatchQueue.main.async {
            if let error = Error {
                completion?(false, nil, error);
            } else if let jsonData = Data {
                let result = try? JSONSerialization.jsonObject(with: jsonData) as! [String: Any];
                let ok = result!["ok"] as? Bool;
                if(!ok!) {
                    completion?(ok!, nil, nil);
                }
                completion?(ok!, result!["message"] as? String, nil);
            } else {
                let err = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey : "Data could not be requested"]) as Error;
                completion?(false, nil, err);
            }
        };
    };
    task.resume();
};
