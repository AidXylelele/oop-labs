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
    
    init(color: Color, lineWidth: CGFloat) {
        self.color = color
        self.lineWidth = lineWidth
    }
}

class Line: Tool {
    var points: [CGPoint]
    
    init(points: [CGPoint], color: Color, lineWidth: CGFloat) {
        self.points = points
        super.init(color: color, lineWidth: lineWidth)
    }
}

class Straight: Tool {
    var points: [CGPoint]
    
    init(points: [CGPoint], color: Color, lineWidth: CGFloat) {
        self.points = points
        super.init(color: color, lineWidth: lineWidth)
    }
}

class Ellipse: Tool {
    var origin: CGPoint
    var width: CGFloat
    var height: CGFloat
    var backgroundColor: Color
    
    init(origin: CGPoint, width: CGFloat, height: CGFloat, color: Color, lineWidth: CGFloat, backgroundColor: Color) {
        self.origin = origin
        self.width = width
        self.height = height
        self.backgroundColor = backgroundColor
        super.init(color: color, lineWidth: lineWidth)
    }
}

class Rectangle: Tool {
    var origin: CGPoint
    var width: CGFloat
    var height: CGFloat
    var backgroundColor: Color
    
    init(origin: CGPoint, width: CGFloat, height: CGFloat, color: Color, lineWidth: CGFloat, backgroundColor: Color) {
        self.origin = origin
        self.width = width
        self.height = height
        self.backgroundColor = backgroundColor
        super.init(color: color, lineWidth: lineWidth)
    }
}
