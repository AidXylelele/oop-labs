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
            with: .color(figure.color))
        
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
        path.addRect(CGRect(origin: CGPoint(x: figure.points[0].x - width/2, y: figure.points[0].y - height/2), size: CGSize(width: figure.width * 1.5, height: figure.height * 1.5)))

        context.fill(
            path,
            with: .color(figure.backgroundColor))
        
        context.stroke(
            path,
            with: .color(figure.color),
            lineWidth: figure.lineWidth)
    }
}

class LineOO: Tool {
  let circleSize: CGFloat = 30

    override init(points: [CGPoint], color: Color, lineWidth: CGFloat, width: CGFloat, height: CGFloat, backgroundColor: Color) {
        super.init(points: points, color: color, lineWidth: lineWidth, width: width, height: height, backgroundColor: backgroundColor)
    }
    
  override func show(figure: Tool, context: GraphicsContext) {
    var path = Path()
    
    let firstPoint = figure.points[0]
    let firstCircleX = firstPoint.x - circleSize / 2
    let firstCircleY = firstPoint.y - circleSize / 2
    
    var secondPoint = firstPoint
    if figure.points.count != 1 { secondPoint = figure.points[1] }
    let secondCircleX = secondPoint.x - circleSize / 2
    let secondCircleY = secondPoint.y - circleSize / 2
    
    path.addLines(figure.points)
    path.addEllipse(in: CGRect(origin: CGPoint(x: firstCircleX, y: firstCircleY), size: CGSize(width: circleSize, height: circleSize)))
    path.addEllipse(in: CGRect(origin: CGPoint(x: secondCircleX, y: secondCircleY), size: CGSize(width: circleSize, height: circleSize)))
    context.stroke(path, with: .color(figure.color), lineWidth: figure.lineWidth)
    context.fill(path, with: .color(figure.color))
  }
}

class Cube: Tool {
 
    override init(points: [CGPoint], color: Color, lineWidth: CGFloat, width: CGFloat, height: CGFloat, backgroundColor: Color) {
        super.init(points: points, color: color, lineWidth: lineWidth, width: width, height: height, backgroundColor: backgroundColor)
    }

  override func show(figure: Tool, context: GraphicsContext) {
    var path = Path()

    let firstFrontPoint = figure.points[0]
    let firstFrontX = firstFrontPoint.x
    let firstFrontY = firstFrontPoint.y

    let secondFrontPoint = CGPoint(x: firstFrontX + figure.width, y: firstFrontY + figure.width)
    let secondFrontX = secondFrontPoint.x
    let secondFrontY = secondFrontPoint.y

    let firstBackPoint = CGPoint(x: firstFrontX + figure.width / 2, y: firstFrontY - figure.width / 2)
    let firstBackX = firstBackPoint.x
    let firstBackY = firstBackPoint.y

    let secondBackPoint = CGPoint(x: secondFrontX + figure.width / 2, y: secondFrontY - figure.width / 2)

    path.addRect(CGRect(origin: firstFrontPoint, size: CGSize(width: figure.width, height: figure.width)))
    path.addRect(CGRect(origin: firstBackPoint, size: CGSize(width: figure.width, height: figure.width)))

    path.addLines([firstFrontPoint, firstBackPoint])
    path.addLines([CGPoint(x: firstFrontX, y: firstFrontY + figure.width), CGPoint(x: firstBackX, y: firstBackY + figure.width)])
    path.addLines([secondFrontPoint, secondBackPoint])
    path.addLines([CGPoint(x: firstFrontX + figure.width, y: firstFrontY), CGPoint(x: firstBackX + figure.width, y: firstBackY)])

    context.stroke(path, with: .color(figure.color), lineWidth: figure.lineWidth)
  }
}
