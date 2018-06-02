import Foundation

func loginAction(email: String, password: String, completion: ((_ ok: Bool, _ message: Token?, _ error: Error?) -> Void)?) {
    setenv("CFNETWORK_DIAGNOSTICS", "3", 1);
    var request = URLRequest(url: URL(string: "https://dragontide.herokuapp.com/auth/login")!);
    request.httpMethod = "POST";
    let jsonBody = ["email": email, "password": password];
    request.httpBody = try? JSONSerialization.data(withJSONObject: jsonBody, options: []);
    NSLog(String(data: request.httpBody!, encoding: .utf8)!);
    request.setValue("application/json", forHTTPHeaderField: "Content-Type");
    let session = URLSession(configuration: URLSessionConfiguration.default);
    
    let task = session.dataTask(with: request) { (Data, Response, Error) in
        DispatchQueue.main.async {
            if let error = Error {
                completion?(false, nil, error);
            } else if let jsonData = Data {
                NSLog(String(data: jsonData, encoding: String.Encoding.utf8)!);
            } else {
                let err = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey : "Data could not be requested"]) as Error;
                completion?(false, nil, err);
            }
        }
    };
    task.resume();
}
