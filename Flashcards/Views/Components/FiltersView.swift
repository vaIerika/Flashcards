//
//  FiltersView.swift
//  Flashcards
//
//  Created by Valerie 👩🏼‍💻 on 09/07/2021.
//

import SwiftUI

struct FiltersView: View {
    var categories: [Category]
    @Binding var filterByCategories: Set<CategoryColor.RawValue>
    @Binding var showCategorySettings: Category?
    
    var body: some View {
        HStack(spacing: 25) {
            ForEach(categories) { category in
                ZStack {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(category.color)
                        .frame(width: 50, height: 50)
                        .opacity(filterByCategories.contains(category.id) ? 1 : 0.7)
                    
                    Image(systemName: category.image)
                        .foregroundColor(.white)
                }
                .scaleEffect(filterByCategories.contains(category.id) ? 1.2 : 1)
                .onTapGesture {
                    withAnimation {
                        if filterByCategories.contains(category.id) {
                            if let index = filterByCategories.firstIndex(of: category.id) {
                                filterByCategories.remove(at: index)
                            }
                        } else {
                            filterByCategories.insert(category.id)
                        }
                    }
                    print(filterByCategories)
                    print(category)
                    print(category.id)
                }
                .onLongPressGesture {
                    showCategorySettings = category
                }
            }
            
            Button(action: {
                withAnimation {
                    filterByCategories = []
                }
            }) {
                ZStack {
                    RoundedRectangle(cornerRadius: 10)
                        .stroke()
                        .foregroundColor(Color.grapeDrk.opacity(0.3))
                        .frame(width: 50, height: 50)
                    Image(systemName: "xmark")
                        .frame(width: 30, height: 30)
                        .foregroundColor(.magenta)
                }
            }
        }
        .padding(.vertical, 15)
    }
}

struct FiltersView_Previews: PreviewProvider {
    static var previews: some View {
        FiltersViewWrapper()
            .previewLayout(.fixed(width: 568, height: 320))
    }
    
    struct FiltersViewWrapper: View {
        let categories = Profile().categories
        @State private var filterByCategories: Set<Category.ID> = []
        @State private var showCategorySettings: Category?
        
        var body: some View {
            FiltersView(categories: categories, filterByCategories: $filterByCategories, showCategorySettings: $showCategorySettings)
        }
    }
}
