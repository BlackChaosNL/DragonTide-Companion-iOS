import Foundation

func loginAction(email: String, password: String, completion: ((_ ok: Bool, _ message: Token?, _ error: Error?) -> Void)?) {
    var request = URLRequest(url: URL(string: "https://dragontide.herokuapp.com/auth/login")!);
    request.httpMethod = "POST";
    request.httpBody = try? JSONSerialization.data(withJSONObject: ["email": email, "password": password], options: []);
    request.addValue("", forHTTPHeaderField: "Accept-Encoding");
    request.addValue("application/json", forHTTPHeaderField: "Content-Type");
    let session = URLSession(configuration: URLSessionConfiguration.default);
    
    let task = session.dataTask(with: request) { (Data, Response, Error) in
        DispatchQueue.main.async {
            if let error = Error {
                completion?(false, nil, error);
            } else if let jsonData = Data {
                do {
                    let jsDataResult = try JSONSerialization.jsonObject(with: jsonData) as! [String: Any];
                    let token = jsDataResult["message"] as! String;
                    completion?(jsDataResult["ok"] as! Bool, Token(userId: nil, token: token, expires: Date.init()), nil);
                } catch let error as NSError {
                    completion?(false, nil, error);
                }
            } else {
                let err = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey : "Data could not be requested"]) as Error;
                completion?(false, nil, err);
            }
        }
    };
    task.resume();
}
