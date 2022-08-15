//
//  TextFieldModifier.swift
//  BooksData
//
//  Created by Sebastian Hajduk on 31/07/2022.
//

import SwiftUI

extension View {
    func bdTextField() -> some View {
        modifier(TextFieldModifier())
        
    }
}

struct TextFieldModifier: ViewModifier {
    let c = Const()
    
    func body(content: Content) -> some View {
        content
            .padding(10)
            .background(.white)
            .clipShape(RoundedRectangle(cornerRadius: 50))
            .shadow(color: c.mainPink.opacity(0.4), radius: 5, x: 0, y: 5)
            .padding(.top, 20)
    }
}


