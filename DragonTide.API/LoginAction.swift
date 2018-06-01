import Foundation

func loginAction(email: String, password: String, completion: ((_ ok: Bool, _ message: Token?, _ error: Error?) -> Void)?) {
    var request = URLRequest(url: URL(string: "https://dragontide.herokuapp.com/auth/login")!);
    request.httpMethod = "POST";
    request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type");
    let dataThing = "email=\(email)&password=\(password)".data(using: .utf8);
    request.httpBody = dataThing;
    let session = URLSession(configuration: URLSessionConfiguration.default);
    
    let task = session.dataTask(with: request) { (Data, Response, Error) in
        DispatchQueue.main.async {
            if let error = Error {
                completion?(false, nil, error);
            } else if let jsonData = Data {
                NSLog(String(data: jsonData, encoding: String.Encoding.utf8)!);
//                let decoder = JSONDecoder();
//                do {
//                    //let dec = try decoder.decode([DefaultResponse].type, from: jsonData);
//                    //completion?(.success(jsonData));
//                } catch {
//                    completion?(false, nil, error);
//                    //completion?(.fail(error));
//                }
            } else {
                let err = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey : "Data could not be requested"]) as Error;
                completion?(false, nil, err);
            }
        }
    };
    task.resume();
}
