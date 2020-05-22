//
//  CategorySettings.swift
//  Flashcards
//
//  Created by Valerie 👩🏼‍💻 on 15/05/2020.
//

import SwiftUI

struct CategorySettings: View {
    @Environment(\.presentationMode) var presentationMode
    
    @Binding var profile: Profile
    var category: Int
    
    let images = ["pencil.and.outline", "book", "pencil.tip", "map", "pin", "star", "heart", "helm", "ellipses.bubble", "paintbrush", "x.squareroot", "rosette", "flag", "safari"]
    
    var body: some View {
        ZStack {
            VStack {
                HStack {
                    Spacer()
                    Button(action: {
                        self.presentationMode.wrappedValue.dismiss()
                    }) {
                        Text("Dismiss")
                            .font(.custom("OpenSans-Regular", size: 15))
                            .foregroundColor(.magenta)
                    }
                }
                Spacer()
            }
            .padding(30)
            
            VStack {
                HStack {
                    ForEach(0..<7, id: \.self) { i in
                        Button(action: {
                            self.profile.categories[self.category].image = self.images[i]
                            self.presentationMode.wrappedValue.dismiss()
                        }) {
                            Image(systemName: self.images[i])
                                .font(.title)
                                .frame(width: 40, height: 40)
                                .foregroundColor(.goldDrk)
                                .padding(20)
                        }
                    }
                }
                
                HStack {
                    ForEach(7..<images.count, id: \.self) { i in
                        Button(action: {
                            self.profile.categories[self.category].image = self.images[i]
                            self.presentationMode.wrappedValue.dismiss()
                        }) {
                            Image(systemName: self.images[i])
                                .font(.title)
                                .frame(width: 40, height: 40)
                                .foregroundColor(.goldDrk)
                                .padding(20)
                        }
                    }
                }
            }
        }
    }
}

struct CategorySettings_Previews: PreviewProvider {
    static var previews: some View {
        CategorySettings(profile: Binding.constant(Profile()), category: 5)
            .previewLayout(.fixed(width: 896, height: 414))
    }
}
