//
//  MenuView.swift
//  Lab2
//
//  Created by Владислав Шевырёв on 29.09.2022.
//

import SwiftUI

struct MenuView: View {
    init (selectedTool, selectedColor, selectedWidth, selectedRule, lines, straights, ellipses, rectangles) {
        self.lines = lines
        self.straights = straights
        self.ellipses = ellipses
        
    }
    var body: some View {
        VStack {
            VStack {
                Picker(selection: $selectedTool, label: Text("Выберите инструмент")) {
                    Text("Кривая").tag("Line")
                    Text("Прямая").tag("Straight")
                    Text("Эллипс").tag("Ellipse")
                    Text("Квадрат").tag("Rectangle")
                }
                .pickerStyle(SegmentedPickerStyle())
                .frame(minHeight: 40)
                
                HStack {
                    Text("Выберите цвет")
                    Spacer()
                    ColorPicker("Выберите цвет", selection: $selectedColor)
                        .labelsHidden()
                }
                .frame(minHeight: 40)
                
                HStack {
                    Text("Выберите толщину")
                    Spacer()
                    Text("\(Int(selectedWidth))")
                    Spacer()
                    Slider(value: $selectedWidth, in: 1...15) {
                    }
                    .frame(maxWidth: 170)
                }
                .frame(minHeight: 40)
                
                HStack {
                    Text("Правильные фигуры")
                    Spacer()
                    Picker(selection: $selectedRule, label: Text("Выберите правило")) {
                        Text("Да").tag("True")
                        Text("Нет").tag("False")
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .frame(minHeight: 40)
                }
                .frame(minHeight: 40)
                
                HStack {
                    Button("Очистить", action: {
                        lines = [Line]()
                        straights = [Straight]()
                        ellipses = [Ellipse]()
                        rectangles = [Rectangle]()
                    })
                        .foregroundColor(.red)
                    Spacer()
                    Button("Undo", action: {
                        _ = lines.popLast()
                       _ = straights.popLast()
                        _ = ellipses.popLast()
                        _ = rectangles.popLast()
                    })
                        .foregroundColor(.blue)
                }
                .frame(minHeight: 40)
            }
            .padding()
    }
}

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView()
    }
}
