import Foundation

func SetCacheValue<T : Encodable>(_ object: T, key: String) {
    let data = try? JSONEncoder().encode(object);
    let defaults = UserDefaults.standard;
    defaults.set(data, forKey: key);
};

func GetCacheValue<T : Decodable>(key: String) -> T? {
    if let savedObject = UserDefaults.standard.object(forKey: key) as? Data {
        let decodable = JSONDecoder();
        if let loadedObject = try? decodable.decode(T.self, from: savedObject) {
            return loadedObject;
        };
    };
    return nil;
};

