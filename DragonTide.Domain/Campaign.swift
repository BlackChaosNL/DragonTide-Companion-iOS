import Foundation

class Campaign: Codable {
    var title: String;
    var description: String;
    var dm: User?;
    var active: Bool;
    var prive: Bool;
    var password: String;
    
    public init(titl: String, desc: String, DM: User?, act: Bool, priv: Bool, pass: String) {
        title = titl;
        description = desc;
        dm = DM;
        active = act;
        prive = priv;
        password = pass;
    }
}
