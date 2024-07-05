//
//  SplitView.swift
//  CSWisual
//
//  Created by Cihan Emre Kisakurek on 28.06.24.
//

import Foundation
import SwiftUI

public struct SlideableDivider: View {
    @Binding var dimension: Double
    @State private var dimensionStart: Double?
    
    let minDimension: Double = 50.0
    let width: CGFloat

    public init(dimension: Binding<Double>, width: CGFloat) {
        self._dimension = dimension
        self.width = width
    }
    
    public var body: some View {
        Rectangle().background(Color.gray).frame(width: 2)
            .onHover { inside in
                if inside {
//                    NSCursor.resizeLeftRight.push()
                } else {
//                    NSCursor.pop()
                }
            }
            .gesture(drag(maxWidth: width))
            
//            .readSize { newSize in
//                width = newSize.width
//            }
    }
    
    func drag(maxWidth: CGFloat) -> some Gesture {
        DragGesture(minimumDistance: 10, coordinateSpace: CoordinateSpace.global)
            .onChanged { val in
                if dimensionStart == nil {
                    dimensionStart = dimension
                }
                let delta = val.location.x - val.startLocation.x
                dimension = dimensionStart! + Double(delta)
                print(maxWidth)
                dimension = max(dimension, minDimension)
                dimension = min(dimension, maxWidth - minDimension)
            }
            .onEnded { val in
                dimensionStart = nil
            }

    }
}

extension View {
    func getWidth(_ width: Binding<CGFloat>) -> some View {
        modifier(GetWidthModifier(width: width))
    }
}

struct GetWidthModifier: ViewModifier {
    @Binding var width: CGFloat
    func body(content: Content) -> some View {
        content
            .overlay(
                GeometryReader { proxy in
                    let proxyWidth = proxy.size.width
                    Color.clear
                        .task(id: proxy.size.width) {
                            $width.wrappedValue = max(proxyWidth, 0)
                        }
                }
            )
    }
}

struct ContentView1: View {
    @AppStorage("ContentView.draggableWidth") var draggableWidth: Double = 185.0
    @State var width: CGFloat = .zero
    var body: some View {
        HStack(spacing: 0) {
            Text("Panel 1")
            .frame(width: CGFloat(draggableWidth))
            .frame(maxHeight: .infinity)
            .background(Color.blue.opacity(0.5))
            
            SlideableDivider(dimension: $draggableWidth, width: width)
            
            Text("Panel 2")
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.red.opacity(0.5))
            
        }
        .frame(maxWidth: .infinity)
        .getWidth($width)
    }
}
