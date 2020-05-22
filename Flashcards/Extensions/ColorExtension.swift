//
//  ColorExtension.swift
//  Flashcards
//
//  Created by Valerie 👩🏼‍💻 on 13/05/2020.
//

import Foundation
import SwiftUI

extension Color {
    static let navyBrt = Color(red: 126/255, green: 200/255, blue: 244/255)
    static let navyDrk = Color(red: 85/255, green: 120/255, blue: 153/255)
    static let goldBrt = Color(red: 255/255, green: 203/255, blue: 74/255)
    static let goldDrk = Color(red: 244/255, green: 137/255, blue: 55/255)
    static let rougeBrt = Color(red: 237/255, green: 86/255, blue: 147/255)
    static let rougeDrk = Color(red: 224/255, green: 54/255, blue: 132/255)
    static let grapeBrt = Color(red: 166/255, green: 134/255, blue: 173/255)
    static let grapeDrk = Color(red: 49/255, green: 44/255, blue: 58/255)
    static let forestBrt = Color(red: 193/255, green: 176/255, blue: 54/255)
    static let forestDrk = Color(red: 139/255, green: 147/255, blue: 64/255)
    
    static let magenta = Color(red: 255/255, green: 62/255, blue: 62/255)
    static let cloud = Color(red: 251/255, green: 248/255, blue: 245/255)
    
    static let navyGrdnt = LinearGradient(gradient: Gradient(colors: [.navyDrk, .navyBrt]), startPoint: .topLeading, endPoint: .bottomTrailing)
    static let goldGrdnt = LinearGradient(gradient: Gradient(colors: [.goldDrk, .goldBrt]), startPoint: .topLeading, endPoint: .bottomTrailing)
    static let rougeGrdnt = LinearGradient(gradient: Gradient(colors: [.rougeDrk, .rougeBrt]), startPoint: .topLeading, endPoint: .bottomTrailing)
    static let grapeGrdnt = LinearGradient(gradient: Gradient(colors: [.grapeDrk, .grapeBrt]), startPoint: .topLeading, endPoint: .bottomTrailing)
    static let forestGrdnt = LinearGradient(gradient: Gradient(colors: [.forestDrk, .forestBrt]), startPoint: .topLeading, endPoint: .bottomTrailing)
    
    static let gradients = [Color.rougeGrdnt, Color.goldGrdnt, Color.grapeGrdnt, Color.forestGrdnt, Color.navyGrdnt]
}

struct ColorExtension_Previews: PreviewProvider {
    static let colors = [Color.navyBrt, Color.navyDrk, Color.goldBrt, Color.goldDrk, Color.rougeBrt, Color.rougeDrk, Color.magenta, Color.grapeBrt, Color.grapeDrk, Color.forestBrt, Color.forestDrk, Color.cloud]
    static let gradients = [Color.navyGrdnt, Color.goldGrdnt, Color.rougeGrdnt, Color.grapeGrdnt, Color.forestGrdnt]
    
    static var previews: some View {
        VStack(spacing: 80) {
            HStack {
                ForEach(0..<colors.count) { i in
                    Circle()
                        .fill(colors[i])
                        .frame(width: 90, height: 90)
                        .padding(.horizontal, 10)
                }
            }
            HStack {
                ForEach(0..<gradients.count) { i in
                    Circle()
                        .fill(gradients[i])
                        .frame(width: 90, height: 90)
                        .padding(.horizontal, 10)
                }
            }
        }
        .previewLayout(.fixed(width: 1500, height: 500))
    }
}


extension UIColor {
    static let goldDrk = UIColor(red: 244/255, green: 137/255, blue: 55/255, alpha: 1)
    static let goldBrt = UIColor(red: 255/255, green: 203/255, blue: 74/255, alpha: 1)
    static let cloud = UIColor(red: 251/255, green: 248/255, blue: 245/255, alpha: 1)
}
