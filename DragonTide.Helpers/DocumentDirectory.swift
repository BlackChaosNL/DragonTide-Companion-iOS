import Foundation

func getUserDirectory() -> URL? {
    if let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
        return url;
    }
    return nil;
};
