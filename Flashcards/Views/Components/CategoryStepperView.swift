//
//  CategoryStepperView.swift
//  Flashcards
//
//  Created by Valerie 👩🏼‍💻 on 20/05/2020.
//

import SwiftUI

struct CategoryStepperView: View {
    @Binding var categoryColor: CategoryColor
    
    var body: some View {
        HStack {
            Text("Category:")
                .fontOpenSansModifier(color: .secondary)
                .padding(.trailing, 5)
            
            StepperArrowView(categoryColor: $categoryColor, forward: false)
            
            RoundedRectangle(cornerRadius: 5)
                .fill(categoryColor.color)
                .frame(width: 30, height: 30)
                .padding(.horizontal, 15)
            
            StepperArrowView(categoryColor: $categoryColor)
        }
    }
}

struct CategoryStepperView_Previews: PreviewProvider {
    static var previews: some View {
        CategoryStepperViewWrapper()
    }
    
    struct CategoryStepperViewWrapper: View {
        @State private var category = CategoryColor.grape

        var body: some View {
            CategoryStepperView(categoryColor: $category)
        }
    }
}
