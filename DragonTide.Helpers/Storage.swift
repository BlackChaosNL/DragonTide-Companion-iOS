import Foundation

func SetValue<T : Encodable>(_ object: T, key: String, saveType: saveType) {
    switch(saveType) {
    case .Persistent:
        let url = getUserDirectory()?.appendingPathExtension("\(key).json");
        let data = try? JSONEncoder().encode(object);
        do {
            try data?.write(to: url!, options: []);
        } catch {}
        break;
    case .Temporary:
        let data = try? JSONEncoder().encode(object);
        let defaults = UserDefaults.standard;
        defaults.set(data, forKey: key);
        break;
    };
};

func GetValue<T : Decodable>(key: String, loadType: saveType) -> T? {
    switch(loadType) {
    case .Persistent:
        let url = getUserDirectory()?.appendingPathExtension("\(key).json");
        return try? JSONDecoder().decode(T.self, from: Data(contentsOf: url!));

    case .Temporary:
        if let savedObject = UserDefaults.standard.object(forKey: key) as? Data {
            if let loadedObject = try? JSONDecoder().decode(T.self, from: savedObject) {
                return loadedObject;
            };
        };
        return nil;
    
    };
};

func DestroyValue(key: String, saveType: saveType) {
    switch(saveType){
    case .Persistent:
        try? FileManager.default.removeItem(at: (getUserDirectory()?.appendingPathExtension("\(key).json"))!);
        break;
    case .Temporary:
        UserDefaults.standard.removeObject(forKey: key);
        break;
    }
}
