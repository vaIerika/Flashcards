//
//  StepperArrowView.swift
//  Flashcards
//
//  Created by Valerie 👩🏼‍💻 on 28/06/2021.
//

import SwiftUI

struct StepperArrowView: View {
    @Binding var categoryColor: CategoryColor
    var forward: Bool = true
    
    private var isDisabled: Bool {
        forward
            ? categoryColor.rawValue >= CategoryColor.allCases.count - 1
            : categoryColor.rawValue <= 0
    }
    private var bgColor: Color {
        isDisabled ? .secondary : .magenta
    }
    
    var body: some View {
        Button(action: {
            withAnimation {
                forward
                    ? categoryColor.next()
                    : categoryColor.previous()
            }
        }) {
            Image(systemName: forward ? "chevron.right" : "chevron.left")
                .foregroundColor(bgColor)
                .frame(width: 40, height: 40)
        }.disabled(isDisabled)
    }
}

struct StepperArrowView_Previews: PreviewProvider {
    static var previews: some View {
        StepperArrowViewWrapper()
    }
    
    struct StepperArrowViewWrapper: View {
        @State private var category = CategoryColor.grape
        
        var body: some View {
            HStack {
                StepperArrowView(categoryColor: $category, forward: false)
                Text("\(category.rawValue)")
                StepperArrowView(categoryColor: $category)
            }
        }
    }
}
