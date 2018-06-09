import Foundation

class Campaign: Codable {
    var title: String;
    var description: String;
    var dm: User?;
    var active: Bool;
    var prive: Bool;
    var password: String;
    
    public init(title: String, description: String, dm: User?, active: Bool, privat: Bool, password: String) {
        self.title = title;
        self.description = description;
        self.dm = dm;
        self.active = active;
        self.prive = privat;
        self.password = password;
    }
}
