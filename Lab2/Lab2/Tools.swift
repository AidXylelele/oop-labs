import Foundation
import SwiftUI
import Combine

class ObservableArray<T>: ObservableObject {
    @Published var array:[T] = []
    
    init(array: [T]) {
        self.array = array
    }
}

class Tool: ObservableObject {
    var color: Color
    var lineWidth: CGFloat
    var points: [CGPoint]
    var width: CGFloat
    var height: CGFloat
    var backgroundColor: Color
    
    init(points: [CGPoint], color: Color, lineWidth: CGFloat, width: CGFloat, height: CGFloat, backgroundColor: Color) {
        self.color = color
        self.lineWidth = lineWidth
        self.points = points
        self.height = height
        self.width = width
        self.backgroundColor = backgroundColor
    }
    
    func show(figure: Tool, context: GraphicsContext) {}
}

class Line: Tool {
    init(points: [CGPoint], color: Color, lineWidth: CGFloat) {
        super.init(points: points, color: color, lineWidth: lineWidth, width: 0, height: 0, backgroundColor: .clear)
    }
    
    override func show(figure: Tool, context: GraphicsContext) {
        var path = Path()
        path.addLines(figure.points)
        context.stroke(path,
                       with: .color(figure.color),
                       lineWidth: figure.lineWidth)
    }
    
}

class Point: Tool {
    override init(points: [CGPoint], color: Color, lineWidth: CGFloat, width: CGFloat, height: CGFloat, backgroundColor: Color) {
        super.init(points: points, color: color, lineWidth: lineWidth, width: width, height: height, backgroundColor: backgroundColor)
    }
    
    override func show(figure: Tool, context: GraphicsContext) {
        var path = Path()
        path.addEllipse(in: CGRect(origin: figure.points[0],
                                   size: CGSize(width: 3,
                                                height: 3)))
        context.fill(
            path,
            with: .color(.black))
        
        context.stroke(
            path,
            with: .color(figure.color),
            lineWidth: figure.lineWidth)
    }
}

class Ellipse: Tool {
    override init(points: [CGPoint], color: Color, lineWidth: CGFloat, width: CGFloat, height: CGFloat, backgroundColor: Color) {
        super.init(points: points, color: color, lineWidth: lineWidth, width: width, height: height, backgroundColor: backgroundColor)
    }
    
    override func show(figure: Tool, context: GraphicsContext) {
        var path = Path()
        path.addEllipse(in: CGRect(origin: figure.points[0],
                                   size: CGSize(width: figure.width,
                                                height: figure.height)))
        context.fill(
            path,
            with: .color(figure.backgroundColor))
        
        context.stroke(
            path,
            with: .color(figure.color),
            lineWidth: figure.lineWidth)
    }
}

class Rectangle: Tool {
    override init(points: [CGPoint], color: Color, lineWidth: CGFloat, width: CGFloat, height: CGFloat, backgroundColor: Color) {
        super.init(points: points, color: color, lineWidth: lineWidth, width: width, height: height, backgroundColor: backgroundColor)
    }
    
    override func show(figure: Tool, context: GraphicsContext) {
        var path = Path()
        path.addRect(CGRect(origin: figure.points[0],
                            size: CGSize(width: width,
                                         height: height)))
        context.fill(
            path,
            with: .color(figure.backgroundColor))
        
        context.stroke(
            path,
            with: .color(figure.color),
            lineWidth: figure.lineWidth)
    }
}
