//
//  DownloadView.swift
//  ProgressAnimationSwiftUI
//
//  Created by Evandro Hoffmann on 22/08/22.
//

import SwiftUI
import UIKit
import Lottie

struct DownloadView: UIViewRepresentable {
    var url: URL
    var animationView: AnimationView = .init()
    @Binding var state: State
    
    enum State {
        case normal
        case prepareForDownload
        case downloading(progress: Double)
        case downloaded
    }
    
    func makeUIView(context: Context) -> UIView {
        let view = UIView()
        view.addSubview(animationView)
        animationView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            animationView.topAnchor.constraint(equalTo: view.topAnchor),
            animationView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            animationView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            animationView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
        Animation.loadedFrom(url: url, closure: { animation in
            animationView.animation = animation
        }, animationCache: LRUAnimationCache.sharedCache)
        
        return view
    }
    
    func updateUIView(_ view: UIViewType, context: Context) {
        switch state {
        case .normal:
            animationView.currentFrame = 0
        case .prepareForDownload:
            animationView.play(toFrame: 120)
        case .downloading(let progress):
            animationView.currentFrame = 120+((189-120)*progress)
        case .downloaded:
            animationView.play(toFrame: 245)
        }
    }
}
