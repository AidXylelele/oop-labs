import SwiftUI
import Foundation

struct DrawingView: View {
    @ObservedObject var figures: ObservableArray<Tool> = ObservableArray(array: [])
    @State private var selectedTool: String = "Point"
    @State private var selectedColor: Color = .black
    @State private var selectedWidth: CGFloat = 2
    @State private var selectedRule: String = "True"
    @State private var selectedColorFill: Color = .red
    
    var body: some View {
        VStack {
            VStack {
                Picker(selection: $selectedTool, label: Text("Выберите инструмент")) {
                    Text("Точка").tag("Point")
                    Text("Кривая").tag("Line")
                    Text("Прямая").tag("Straight")
                    Text("Эллипс").tag("Ellipse")
                    Text("Квадрат").tag("Rectangle")
                }
                .pickerStyle(SegmentedPickerStyle())
                .frame(minHeight: 40)
                
                HStack {
                    Text("Цвет обводки")
                    Spacer()
                    ColorPicker("Выберите цвет", selection: $selectedColor)
                        .labelsHidden()
                }
                .frame(minHeight: 40)
                
                HStack {
                    Text("Толщина обводки")
                    Spacer()
                    Text("\(Int(selectedWidth))")
                    Spacer()
                    Slider(value: $selectedWidth, in: 1...15) {
                    }
                    .frame(maxWidth: 170)
                }
                .frame(minHeight: 40)
                
                if selectedTool == "Ellipse" || selectedTool == "Rectangle" {
                    HStack {
                        Text("Цвет наполнения")
                        Spacer()
                        ColorPicker("Выберите цвет", selection: $selectedColorFill)
                            .labelsHidden()
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
                }
                HStack {
                    Button("Очистить", action: {
                        figures.array = []
                    })
                    .foregroundColor(.red)
                    Spacer()
                    Button("Отменить", action: {
                        _ = figures.array.popLast()
                    })
                    .foregroundColor(.blue)
                }
                .frame(minHeight: 40)
            }
            .padding()
            
            Divider()
            
            Canvas { context, size in
                for figure in figures.array {
                    figure.show(figure: figure, context: context)
                }
                
            }
            .gesture(DragGesture(minimumDistance: 0, coordinateSpace: .local).onChanged({ value in
                switch selectedTool {
                    
                case "Point":
                    if value.translation.width + value.translation.height == 0  {
                        let firstPoint = value.startLocation
                        figures.array.append(Point(points: [firstPoint],color: selectedColor, lineWidth: selectedWidth, width: 0, height: 0, backgroundColor: selectedColorFill))
                        
                    } else {
                        let index = figures.array.count - 1
                        figures.objectWillChange.send()
                        figures.array[index].width = value.translation.width
                        figures.array[index].height = figures.array[index].width
                        
                    }
                    
                case "Straight":
                    let lastPoint = value.location
                    if value.translation.width + value.translation.height == 0 {
                        let firstPoint = value.location
                        figures.array.append(Line(points: [firstPoint],
                                                  color: selectedColor,
                                                  lineWidth: selectedWidth))
                    } else {
                        let index = figures.array.count - 1
                        
                        if figures.array[index].points.count == 2 {
                            figures.objectWillChange.send()
                            figures.array[index].points[1] = lastPoint
                        } else {
                            figures.array[index].points.append(lastPoint)
                        }
                    }
                    
                case "Ellipse":
                    if value.translation.width + value.translation.height == 0  {
                        let firstPoint = value.startLocation
                        figures.array.append(Ellipse(points: [firstPoint],color: selectedColor, lineWidth: selectedWidth, width: 0, height: 0, backgroundColor: selectedColorFill))
                        
                    } else {
                        let index = figures.array.count - 1
                        figures.objectWillChange.send()
                        figures.array[index].width = value.translation.width
                        if selectedRule == "True" {
                            figures.array[index].height = figures.array[index].width
                        } else {
                            figures.array[index].height = value.translation.height
                        }
                    }
                    
                case "Rectangle":
                    if value.translation.width + value.translation.height == 0 {
                        let firstPoint = value.startLocation
                        figures.array.append(Rectangle(points: [firstPoint],color: selectedColor, lineWidth: selectedWidth, width: 0, height: 0, backgroundColor: selectedColorFill))
                    } else {
                        let index = figures.array.count - 1
                        figures.objectWillChange.send()
                        figures.array[index].width = value.translation.width
                        if selectedRule == "True" {
                            figures.array[index].height = figures.array[index].width
                        } else {
                            figures.array[index].height = value.translation.height
                        }
                    }
                default:
                    let newPoint = value.location
                    if value.translation.width + value.translation.height == 0 {
                        figures.array.append(contentsOf: [Line(points: [newPoint],
                                                               color: selectedColor,
                                                               lineWidth: selectedWidth)])
                    } else {
                        let index = figures.array.count - 1
                        figures.objectWillChange.send()
                        figures.array[index].points.append(newPoint)
                    }
                }
            }))
            Divider()
            
        }.background(Color(.systemMint))
    }
}

struct DrawingView_Previews: PreviewProvider {
    static var previews: some View {
        DrawingView()
    }
}
