//
//  CornerRadius.swift
//
//  Created by  kabliveru
//

import SwiftUI

enum CornersSet: CaseIterable {
    static var allCases: [CornersSet] {
        [.topL(0), .topR(0), .bottomL(0), .bottomR(0)]
    }

    case topL(CGFloat)
    case topR(CGFloat)
    case bottomL(CGFloat)
    case bottomR(CGFloat)
}

struct CornerRadiusShape: Shape {
    var corners: CornersSet.AllCases

    func path(in rect: CGRect) -> Path {
        Path { path in

            let w = rect.size.width
            let h = rect.size.height
            var tL: CGFloat = 0
            var tR: CGFloat = 0
            var bL: CGFloat = 0
            var bR: CGFloat = 0

            corners.forEach { corner in
                switch corner {
                case .topL(let topL): return tL = min(min(topL, h/2), w/2)
                case .topR(let topR): return tR = min(min(topR, h/2), w/2)
                case .bottomL(let bottomL): return bL = min(min(bottomL, h/2), w/2)
                case .bottomR(let bottomR): return bR = min(min(bottomR, h/2), w/2)
                }
            }

            path.move(to: CGPoint(x: w/2.0, y: 0))
            path.addLine(to: CGPoint(x: w - tR, y: 0))
            path.addArc(center: CGPoint(x: w - tR, y: tR), radius: tR, startAngle: Angle(degrees: -90), endAngle: Angle(degrees: 0), clockwise: false)
            path.addLine(to: CGPoint(x: w, y: h - bR))
            path.addArc(center: CGPoint(x: w - bR, y: h - bR), radius: bR, startAngle: Angle(degrees: 0), endAngle: Angle(degrees: 90), clockwise: false)
            path.addLine(to: CGPoint(x: bL, y: h))
            path.addArc(center: CGPoint(x: bL, y: h - bL), radius: bL, startAngle: Angle(degrees: 90), endAngle: Angle(degrees: 180), clockwise: false)
            path.addLine(to: CGPoint(x: 0, y: tL))
            path.addArc(center: CGPoint(x: tL, y: tL), radius: tL, startAngle: Angle(degrees: 180), endAngle: Angle(degrees: 270), clockwise: false)
        }
    }
}

struct CornerRadiusStyle: ViewModifier {
    var corners: CornersSet.AllCases

    func body(content: Content) -> some View {
        content.clipShape(CornerRadiusShape(corners: corners))
    }
}

extension View {
    func cornerRadius(_ corners: CornersSet.AllCases) -> some View {
        modifier(CornerRadiusStyle(corners: corners))
    }
}
