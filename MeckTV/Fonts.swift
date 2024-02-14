import SwiftUI

struct MeckFont {
    func loadFont() -> String {
        let cfURL = Bundle.main.url(forResource: "Merriweather-Regular", withExtension: "ttf")! as CFURL
        CTFontManagerRegisterFontsForURL(cfURL, CTFontManagerScope.process, nil)
        var fontNames: [[AnyObject]] = []
        for name in UIFont.familyNames {
            print(name)
            fontNames.append(UIFont.fontNames(forFamilyName: name) as [AnyObject])
        }
        return "Success!"
    }
}

let meckfont = MeckFont().loadFont()
