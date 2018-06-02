import Foundation

class Token: Codable {
    var userId: Int?;
    var token: String;
    var expires: Date?;

    public init(user: Int?, tok: String, exp: Date?) {
        userId = user;
        token = tok;
        expires = exp;
    }
    
}