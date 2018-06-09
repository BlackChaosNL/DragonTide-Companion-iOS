import Foundation

class Token: Codable {
    var userId: String?;
    var token: String;
    var expires: Date?;

    public init(userId: String?, token: String, expires: Date?) {
        self.userId = userId;
        self.token = token;
        self.expires = expires;
    }
    
}
