//
//  CustomPicker.swift
//  BooksData
//
//  Created by Sebastian Hajduk on 07/07/2022.
//

import SwiftUI

struct CustomPicker: View {
    let c = Const()
    
    @Binding var selection: String
    @State var picker1: String
    @State var picker2: String
    
    var body: some View {
        customPicker(picker1: picker1, picker2: picker2, selection: &selection)
    }
}

struct CustomPicker_Previews: PreviewProvider {
    static var previews: some View {
        CustomPicker(selection: .constant("First"), picker1: "First", picker2: "Second")
    }
}

extension CustomPicker {
    private func customPicker(picker1: String, picker2: String, selection: inout String) -> some View {
        HStack {
            Text(picker1.isEmpty ? "" : picker1)
                .padding(5)
                .frame(width: 150)
                .background(picker1 == selection ? c.mainGreen : .white)
                .foregroundColor(picker1 == selection ? .white : c.mainGreen)
                .clipShape(RoundedRectangle(cornerRadius: 5))
                .onTapGesture {
                    withAnimation {
                        self.selection = picker1
                    }
                    
                }
                .animation(.default, value: selection)
            
            Text(picker2.isEmpty ? "" : picker2)
                .padding(5)
                .frame(width: 150)
                .background(picker2 == selection ? c.mainGreen : .white)
                .foregroundColor(picker2 == selection ? .white : c.mainGreen)
                .clipShape(RoundedRectangle(cornerRadius: 5))
                .onTapGesture {
                    withAnimation {
                        self.selection = picker2
                    }
                }
                .animation(.default, value: selection)
            
        }
        .padding(6)
        .cornerRadius(10)
        .shadow(color: Color.black.opacity(0.3), radius: 10, x: 0, y: 5)
        .padding()

    }
}
