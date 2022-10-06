import Foundation
import SwiftUI

struct Line {
    var points: [CGPoint]
    var color: Color
    var lineWidth: CGFloat
}

struct Straight {
    var points: [CGPoint]
    var color: Color
    var lineWidth: CGFloat
}

struct Ellipse {
    var origin: CGPoint
    var width: CGFloat
    var height: CGFloat
    var color: Color
    var lineWidth: CGFloat
    var backgroundColor: Color
}

struct Rectangle {
    var origin: CGPoint
    var width: CGFloat
    var height: CGFloat
    var color: Color
    var lineWidth: CGFloat
    var backgroundColor: Color
}
