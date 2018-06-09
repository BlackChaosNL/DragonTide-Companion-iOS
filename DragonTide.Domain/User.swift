import Foundation

class User: Codable {
    var email: String;
    var username: String;
    var password: String;
    var admin: Bool;
    
    public init(email: String, username: String, password: String, admin: Bool) {
        self.email = email;
        self.username = username;
        self.password = password;
        self.admin = admin;
    }
}
