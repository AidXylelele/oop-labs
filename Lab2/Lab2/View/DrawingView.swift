import SwiftUI

struct DrawingView: View {
    @ObservedObject var lines: ObservableArray<Line> = ObservableArray(array: [])
    @ObservedObject var straights: ObservableArray<Straight> = ObservableArray(array: [])
    @ObservedObject var ellipses: ObservableArray<Ellipse> = ObservableArray(array: [])
    @ObservedObject var rectangles: ObservableArray<Rectangle> = ObservableArray(array: [])
    
    @State private var selectedTool: String = "Line"
    @State private var selectedColor: Color = .black
    @State private var selectedWidth: CGFloat = 2
    @State private var selectedRule: String = "True"
    @State private var selectedColorFill: Color = .red
    
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
                
                if selectedTool != "Line" && selectedTool != "Straight" {
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
                        lines.array = []
                        straights.array = []
                        ellipses.array = []
                        rectangles.array = []
                    })
                    .foregroundColor(.red)
                    Spacer()
                    Button("Undo", action: {
                        switch selectedTool {
                        case "Line":
                            _ = lines.array.popLast()
                        case "Straight":
                            _ = straights.array.popLast()
                        case "Ellipse":
                            _ = ellipses.array.popLast()
                        case "Rectangle":
                            _ = rectangles.array.popLast()
                        default: return
                        }
                    })
                    .foregroundColor(.blue)
                }
                .frame(minHeight: 40)
            }
            .padding()
            
            Divider()
            
            Canvas { context, size in
                for line in lines.array {
                    var path = Path()
                    path.addLines(line.points)
                    
                    context.stroke(path,
                                   with: .color(line.color),
                                   lineWidth: line.lineWidth)
                }
                
                for straight in straights.array {
                    var path = Path()
                    path.addLines(straight.points)
                    
                    context.stroke(path,
                                   with: .color(straight.color),
                                   lineWidth: straight.lineWidth)
                }
                
                for ellipse in ellipses.array {
                    let width = ellipse.width
                    let height = ellipse.height
                    
                    var path = Path()
                    path.addEllipse(in: CGRect(origin: ellipse.origin,
                                               size: CGSize(width: width,
                                                            height: height)))
                    context.fill(
                        path,
                        with: .color(ellipse.backgroundColor))
                    
                    context.stroke(
                        path,
                        with: .color(ellipse.color),
                        lineWidth: ellipse.lineWidth)
                }
                
                for rectangle in rectangles.array {
                    let width = rectangle.width
                    let height = rectangle.height
                    
                    var path = Path()
                    path.addRect(CGRect(origin: rectangle.origin,
                                        size: CGSize(width: width,
                                                     height: height)))
                    
                    
                    context.fill(
                        path,
                        with: .color(rectangle.backgroundColor))
                    
                    context.stroke(
                        path,
                        with: .color(rectangle.color),
                        lineWidth: rectangle.lineWidth)
                }
            }
            .gesture(DragGesture(minimumDistance: 0, coordinateSpace: .local).onChanged({ value in
                
                
                switch selectedTool {
                case "Straight":
                    let lastPoint = value.location
                    if value.translation.width + value.translation.height == 0 {
                        let firstPoint = value.location
                        straights.array.append(Straight(points: [firstPoint],
                                                        color: selectedColor,
                                                        lineWidth: selectedWidth))
                    } else {
                        let index = straights.array.count - 1
                        
                        if straights.array[index].points.count == 2 {
                            straights.objectWillChange.send()
                            straights.array[index].points[1] = lastPoint
                        } else {
                            straights.array[index].points.append(lastPoint)
                        }
                    }
                    
                case "Ellipse":
                    if value.translation.width + value.translation.height == 0 {
                        let firstPoint = value.startLocation
                        ellipses.array.append(Ellipse(origin: firstPoint,
                                                      width: 0,
                                                      height: 0,
                                                      color: selectedColor,
                                                      lineWidth: selectedWidth,
                                                      backgroundColor: selectedColorFill))
                    } else {
                        let index = ellipses.array.count - 1
                        ellipses.objectWillChange.send()
                        ellipses.array[index].width = value.translation.width
                        if selectedRule == "True" {
                            ellipses.array[index].height = ellipses.array[index].width
                        } else {
                            ellipses.array[index].height = value.translation.height
                        }
                    }
                    
                case "Rectangle":
                    if value.translation.width + value.translation.height == 0 {
                        let firstPoint = value.startLocation
                        rectangles.array.append(Rectangle(origin: firstPoint,
                                                          width: 0,
                                                          height: 0,
                                                          color: selectedColor,
                                                          lineWidth: selectedWidth,
                                                          backgroundColor: selectedColorFill))
                    } else {
                        let index = rectangles.array.count - 1
                        rectangles.objectWillChange.send()
                        rectangles.array[index].width = value.translation.width
                        if selectedRule == "True" {
                            rectangles.array[index].height = rectangles.array[index].width
                        } else {
                            rectangles.array[index].height = value.translation.height
                        }
                    }
                    
                default:
                    let newPoint = value.location
                    if value.translation.width + value.translation.height == 0 {
                        lines.array.append(Line(points: [newPoint],
                                                color: selectedColor,
                                                lineWidth: selectedWidth))
                    } else {
                        let index = lines.array.count - 1
                        lines.objectWillChange.send()
                        lines.array[index].points.append(newPoint)
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
