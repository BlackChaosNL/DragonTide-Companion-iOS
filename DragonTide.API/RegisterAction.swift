import Foundation

func registerAction(email: String, username: String, password: String, completion: ((_ ok: Bool, _ message: Bool?, _ error: Error?) -> Void)?) {
    var request = URLRequest(url: URL(string: "https://dragontide.herokuapp.com/auth/register")!);
    request.httpMethod = "POST";
    request.httpBody = try? JSONSerialization.data(withJSONObject: ["email": email, "username": username, "password": password], options: []);
    request.addValue("", forHTTPHeaderField: "Accept-Encoding");
    request.addValue("application/json", forHTTPHeaderField: "Content-Type");
    let session = URLSession(configuration: URLSessionConfiguration.default);
    
    let task = session.dataTask(with: request) { (Data, Response, Error) in
        DispatchQueue.main.async {
            if let error = Error {
                completion?(false, nil, error);
            } else if let jsonData = Data {
                let result = try? JSONSerialization.jsonObject(with: jsonData) as! [String: AnyObject];
                if let jsonResult = result!["ok"] as? Bool {
                    completion?(true, jsonResult, nil);
                }
            } else {
                let err = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey : "Data could not be requested"]) as Error;
                completion?(false, nil, err);
            }
        }
    };
    task.resume();
}
