import SwiftUI
import Foundation

struct DrawingView: View {
    @ObservedObject var figures: ObservableArray<Tool> = ObservableArray(array: [])
    @State private var selectedColor: Color = .black
    @State private var selectedWidth: CGFloat = 2
    @State private var selectedRule: String = "True"
    @State private var selectedColorFill: Color = .red
    
    @State private var label = "Выберите фигуру"
    @State private var flag = ""
    
    @State private var showingAlert: [Bool] = [ false, false, false, false, false ]
    @State private var colors: [Color] = [ .black, .black, .black, .black, .black ]
    
    var body: some View {
        VStack {
            Text(label).foregroundColor(.blue).font(Font.headline.weight(.semibold))
            
            HStack {
                
                Button (action: {}) {
                    VStack {
                        Image(systemName: "dot.circle").font(.system(size: 30))
                            .onTapGesture {
                                label = "Точка"
                                flag = "point"
                                print(label)
                                colors = [ .blue, .black, .black, .black, .black]
                            }
                            .onLongPressGesture(minimumDuration: 0.5) {
                                self.showingAlert[0] = true
                            }
                    }
                }.alert("Точка", isPresented: $showingAlert[0]) {
                    Button("OK", role: .cancel) {
                        self.showingAlert[0] = false
                    }
                }.foregroundColor(colors[0])
                
                Button (action: {}) {
                    VStack {
                        Image(systemName: "scribble").font(.system(size: 30))
                            .onTapGesture {
                                label = "Кривая линия"
                                flag = "line"
                                print(label)
                                colors = [.black, .blue, .black, .black, .black ]
                            }
                            .onLongPressGesture(minimumDuration: 0.5) {
                                self.showingAlert[1] = true
                            }
                    }
                }.alert("Кривая линия", isPresented: $showingAlert[1]) {
                    Button("OK", role: .cancel) {
                        self.showingAlert[1] = false
                    }
                }.foregroundColor(colors[1])
                
                Button (action: {}) {
                    VStack {
                        Image(systemName: "line.diagonal").font(.system(size: 30))
                            .onTapGesture {
                                label = "Прямая линия"
                                flag = "straight line"
                                print(label)
                                colors = [.black, .black, .blue, .black, .black]
                            }
                            .onLongPressGesture(minimumDuration: 0.5) {
                                self.showingAlert[2] = true
                            }
                    }
                }.alert("Прямая линия", isPresented: $showingAlert[2]) {
                    Button("OK", role: .cancel) {
                        self.showingAlert[2] = false
                    }
                }.foregroundColor(colors[2])
                
                Button (action: {}) {
                    VStack {
                        Image(systemName: "oval").font(.system(size: 30))
                            .onTapGesture {
                                label = "Еллипс"
                                flag = "ellipse"
                                print(label)
                                colors = [.black, .black, .black, .blue, .black]
                            }
                            .onLongPressGesture(minimumDuration: 0.5) {
                                self.showingAlert[3] = true
                            }
                    }
                }.alert("Еллипс", isPresented: $showingAlert[3]) {
                    Button("OK", role: .cancel) {
                        self.showingAlert[3] = false
                    }
                }.foregroundColor(colors[3])
                
                Button (action: {}) {
                    VStack {
                        Image(systemName: "square").font(.system(size: 30))
                            .onTapGesture {
                                label = "Прямоугольник"
                                flag = "rectangle"
                                print(label)
                                colors = [.black, .black, .black, .black, .blue]
                            }
                            .onLongPressGesture(minimumDuration: 0.5) {
                                self.showingAlert[4] = true
                            }
                    }
                    
                }.alert("Прямоугольник", isPresented: $showingAlert[4]) {
                    Button("OK", role: .cancel) {
                        self.showingAlert[4] = false
                    }
                }.foregroundColor(colors[4])
                
                Menu {
                    Button("Точка") {
                        label = "Точка"
                        flag = "point"
                        print(label)
                        colors = [.blue, .black, .black, .black, .black]
                    }
                    Button("Кривая линия") {
                        label = "Кривая линия"
                        flag = "line"
                        print(label)
                        colors = [.black, .blue, .black, .black, .black]
                    }
                    Button("Прямая линия") {
                        label = "Прямая линия"
                        flag = "straight line"
                        print(label)
                        colors = [.black, .black, .blue, .black, .black]
                    }
                    Button("Еллипс") {
                        label = "Еллипс"
                        flag = "ellipse"
                        print(label)
                        colors = [.black, .black, .gray, .black, .black]
                    }
                    Button("Прямоугольник") {
                        label = "Прямоугольник"
                        flag = "rectangle"
                        print(label)
                        colors = [.black, .black, .black, .black, .blue]
                    }
                } label: {
                    Image(systemName: "square.grid.3x3.fill").font(.system(size: 30))
                }.foregroundColor(.gray)
                
            }
            
            Divider()
            
            Canvas { context, size in
                for figure in figures.array {
                    figure.show(figure: figure, context: context)
                }
            }
            .gesture(DragGesture(minimumDistance: 0, coordinateSpace: .local).onChanged({ value in
                if flag == "point" {
                    
                    if value.translation.width + value.translation.height == 0  {
                        let firstPoint = value.startLocation
                        figures.array.append(Point(points: [firstPoint],color: selectedColor, lineWidth: selectedWidth, width: 0, height: 0, backgroundColor: .clear))
                    } else {
                        let index = figures.array.count - 1
                        figures.objectWillChange.send()
                        figures.array[index].width = value.translation.width
                        figures.array[index].height = figures.array[index].width
                    }
                    
                } else if flag == "line" {
                    
                    let firstPoint = value.location
                    if value.translation.width + value.translation.height == 0 {
                        figures.array.append(contentsOf: [Line(points: [firstPoint],color: selectedColor, lineWidth: selectedWidth)])
                    } else {
                        let index = figures.array.count - 1
                        figures.objectWillChange.send()
                        figures.array[index].points.append(firstPoint)
                    }
                    
                } else if flag == "straight line" {
                    
                    let lastPoint = value.location
                    if value.translation.width + value.translation.height == 0 {
                        let firstPoint = value.location
                        figures.array.append(Line(points: [firstPoint],color: selectedColor, lineWidth: selectedWidth))
                    } else {
                        let index = figures.array.count - 1
                        if figures.array[index].points.count == 2 {
                            figures.objectWillChange.send()
                            figures.array[index].points[1] = lastPoint
                        } else {
                            figures.array[index].points.append(lastPoint)
                        }
                    }
                    
                } else if flag == "ellipse" {
                    
                    if value.translation.width + value.translation.height == 0  {
                        let firstPoint = value.startLocation
                        figures.array.append(Ellipse(points: [firstPoint],color: selectedColor, lineWidth: selectedWidth, width: 0, height: 0, backgroundColor: .clear))
                        
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
                    
                } else if flag == "rectangle" {
                    if value.translation.width + value.translation.height == 0 {
                        let firstPoint = value.startLocation
                        figures.array.append(Rectangle(points: [firstPoint],color: selectedColor, lineWidth: selectedWidth, width: 0, height: 0, backgroundColor: .clear))
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
                }
            }).onEnded(
                { _ in
                    figures.objectWillChange.send()
                    if (figures.array.count != 0) {
                        figures.array[figures.array.count - 1].backgroundColor = selectedColorFill
                        figures.array[figures.array.count - 1].lineWidth = selectedWidth
                    }
                }
            ))
            Divider()
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
            
            if flag == "ellipse" || flag == "rectangle" {
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
            Divider()
            HStack {
                Button("Очистить", action: {
                    label = "Выберите фигуру"
                    flag = ""
                    figures.array = []
                    colors = [ .black, .black, .black, .black, .black ]
                }).foregroundColor(.red)
                Spacer()
                Button("Отменить", action: {
                    _ = figures.array.popLast()
                })
                .foregroundColor(.blue)
            }
        }.padding().background(Color(.systemMint))
        
    }
}




struct DrawingView_Previews: PreviewProvider {
    static var previews: some View {
        DrawingView()
    }
}
