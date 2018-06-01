import Foundation

class User: Codable {
    var email: String;
    var username: String;
    var password: String;
    var admin: Bool;
    
    public init(mail: String, uname: String, pass: String, adm: Bool) {
        email = mail;
        username = uname;
        password = pass;
        admin = adm;
    }
}
