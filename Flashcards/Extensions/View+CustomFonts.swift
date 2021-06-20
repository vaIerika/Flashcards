//
//  View+CustomFonts.swift
//  Carat
//
//  Created by Valerie 👩🏼‍💻 on 16/06/2021.
//

import SwiftUI

struct HerculanumFontModifier: ViewModifier {
    var style: UIFont.TextStyle
    var color: Color
    
    private let fontName = "Herculanum"
    
    func body(content: Content) -> some View {
        content
            .font(.custom(fontName, size: UIFont.preferredFont(forTextStyle: style).pointSize))
            .foregroundColor(color)
    }
}

struct OpenSansModifier: ViewModifier {
    var style: UIFont.TextStyle
    var color: Color

    private let fontName = "OpenSans-Regular"
    
    func body(content: Content) -> some View {
        content
            .font(.custom(fontName, size: UIFont.preferredFont(forTextStyle: style).pointSize))
            .foregroundColor(color)
    }
}

extension View {
    func fontHerculanum(_ style: UIFont.TextStyle = .title2, color: Color = .grapeDrk) -> some View {
        self.modifier(HerculanumFontModifier(style: style, color: color))
    }
    func fontOpenSansModifier(_ style: UIFont.TextStyle = .body, color: Color = .grapeDrk) -> some View {
        self.modifier(OpenSansModifier(style: style, color: color))
    }
}
