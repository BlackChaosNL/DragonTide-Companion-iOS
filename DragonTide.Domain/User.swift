import Foundation

class User: Codable {
    var id: String;
    var email: String;
    var username: String;
    var password: String;
    var admin: Bool;
    
    public init(id: String, email: String, username: String, password: String, admin: Bool) {
        self.id = id;
        self.email = email;
        self.username = username;
        self.password = password;
        self.admin = admin;
    }
}
