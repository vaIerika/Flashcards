//
//  CategorySettings.swift
//  Flashcards
//
//  Created by Valerie 👩🏼‍💻 on 15/05/2020.
//

import SwiftUI

struct CategorySettings: View {
    @Environment(\.presentationMode) var presentationMode
    var setNewName: (String) -> Void
    
    private let imageNames = ["pencil.and.outline", "book", "pencil.tip", "map", "pin", "star", "heart", "helm", "ellipses.bubble", "paintbrush", "x.squareroot", "rosette", "flag", "safari"]
    
    private let rows = [ GridItem(.flexible(minimum: 40, maximum: 100)), GridItem(.flexible(minimum: 40, maximum: 100))]
    
    var body: some View {
        VStack {
            LazyHGrid(rows: rows, spacing: 50) {
                ForEach(imageNames, id: \.self) { image in
                    Button(action: {
                        setNewName(image)
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        Image(systemName: image)
                            .font(.title)
                            .foregroundColor(.goldDrk)
                    }
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .overlay(
                Button("Dismiss") {
                    presentationMode.wrappedValue.dismiss()
                }
                .padding([.top, .trailing], 40)
                .fontOpenSansModifier(color: .magenta),
                alignment: .topTrailing
            )
        }
    }
}

struct CategorySettings_Previews: PreviewProvider {
    static var previews: some View {
        CategorySettings() { _ in }
            .previewLayout(.fixed(width: 896, height: 414))
    }
}
