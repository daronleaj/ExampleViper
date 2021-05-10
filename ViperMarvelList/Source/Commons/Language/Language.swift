import UIKit

class Language {
    
    class func translate(key: String) -> String {
        return NSLocalizedString(key, comment: "")
    }
}
