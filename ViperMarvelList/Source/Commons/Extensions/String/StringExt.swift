import Foundation
import UIKit

enum FontType {
    case black
    case bold
    case book
    case bookItalic
    case light
    case medium
    case thin
    case ultra
    case xLight
    case mediumItalic
}

enum FontSize: CGFloat {
    case tiny = 2.0
    case ten = 10.0
    case eleven = 11.0
    case twelve = 12.0
    case thirteen = 13.0
    case fourteen = 14.0
    case fifteen = 15.0
    case sixteen = 16.0
    case seventeen = 17.0
    case eighteen = 18.0
    case twenty = 20.0
    case twentytwo = 22.0
    case twentyfour = 24.0
    case twentysix = 26.0
    case twentyeight = 28.0
    case thirtysix = 36.0
    case fourtyFive = 45.0
}

extension UIFont {

    class func mainFont(size: FontSize, fontType: FontType) -> UIFont {
        let fontSizeScale: CGFloat = 1.0

        let fontSizeScaled = size.rawValue * fontSizeScale

        switch fontType {
        case .black:
            return UIFont.systemFont(ofSize: fontSizeScaled, weight: .black)
        case .bold:
            return UIFont.systemFont(ofSize: fontSizeScaled, weight: .bold)
        case .book:
            return UIFont.systemFont(ofSize: fontSizeScaled, weight: .regular)
        case .bookItalic:
            return UIFont.italicSystemFont(ofSize: fontSizeScaled)
        case .light:
            return UIFont.systemFont(ofSize: fontSizeScaled, weight: .light)
        case .medium:
            return UIFont.systemFont(ofSize: fontSizeScaled, weight: .medium)
        case .thin:
            return UIFont.systemFont(ofSize: fontSizeScaled, weight: .thin)
        case .ultra:
            return UIFont.systemFont(ofSize: fontSizeScaled, weight: .ultraLight)
        case .xLight:
            return UIFont.systemFont(ofSize: fontSizeScaled, weight: .ultraLight)
        case .mediumItalic:
            return UIFont.italicSystemFont(ofSize: fontSizeScaled)
        }
    }
}
