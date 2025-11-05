//
//  View+Rotation.swift
//  CSWisual
//
//  Created by Cihan Emre Kisakurek on 28.06.24.
//

import SwiftUI

private struct VerticalLayout: Layout {

    func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) -> CGSize {
        let size = subviews.first!.sizeThatFits(.unspecified)
        return .init(width: size.height, height: size.width)
    }

    func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) {
        subviews.first!.place(at: .init(x: bounds.midX, y: bounds.midY), anchor: .center, proposal: .unspecified)
    }
}

private struct RotatedContent: ViewModifier {

    let angle: Angle

    func body(content: Content) -> some View {
        VerticalLayout {
            content
        }
        .rotationEffect(angle)
    }
}

extension View {

    func rotate(_ angle: Angle) -> some View {
        self.modifier(RotatedContent(angle: angle))
    }
}


extension View {
    func snapshot() -> UIImage {
        let controller = UIHostingController(rootView: self)
        let view = controller.view

        let targetSize = controller.view.intrinsicContentSize
        view?.bounds = CGRect(origin: .zero, size: targetSize)
        view?.backgroundColor = .clear

        let renderer = UIGraphicsImageRenderer(size: targetSize)

        return renderer.image { _ in
            view?.drawHierarchy(in: controller.view.bounds, afterScreenUpdates: true)
        }
    }
}
