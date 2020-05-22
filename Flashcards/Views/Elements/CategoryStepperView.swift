//
//  CategoryStepperView.swift
//  Flashcards
//
//  Created by Valerie 👩🏼‍💻 on 20/05/2020.
//

import SwiftUI

struct CategoryStepperView: View {
    @Binding var category: Int
    @State private var min = false
    @State private var max = false
    
    var body: some View {
        HStack {
            Text("Category:")
                .font(.custom("OpenSans-Regular", size: 15))
                .foregroundColor(.secondary)
                .padding(.trailing, 5)
            
            Button(action: {
                withAnimation {
                    if self.category > 0 {
                        self.category -= 1
                        self.validation()
                    } else {
                        self.category = 0
                        self.validation()
                    }
                }
            }) {
                Image(systemName: "chevron.left")
                    .foregroundColor(min ? .secondary : .magenta)
                    .frame(width: 40, height: 40)
            }
            
            RoundedRectangle(cornerRadius: 5)
                .fill(Color.gradients[category])
                .frame(width: 30, height: 30)
                .padding(.horizontal, 15)
      
            Button(action: {
                withAnimation {
                    if self.category < Color.gradients.count - 1 {
                        self.category += 1
                        self.validation()
                    } else {
                        self.category = Color.gradients.count - 1
                         self.validation()
                    }
                }
            }) {
                Image(systemName: "chevron.right")
                    .foregroundColor(max ? .secondary : .magenta)
                    .frame(width: 40, height: 40)
            }
        }
        .onAppear(perform: validation)
    }
    
    func validation() {
        if category == 0 {
            min = true
            max = false
        } else if category == Color.gradients.count - 1 {
            min = false
            max = true
        } else {
            min = false
            max = false
        }
    }
}

struct CategoryStepperView_Previews: PreviewProvider {
    static var previews: some View {
        CategoryStepperView(category: Binding.constant(4))
    }
}
