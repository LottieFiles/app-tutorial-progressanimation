//
//  ViewController.swift
//  ProgressAnimation
//
//  Created by Evandro Hoffmann on 22/08/22.
//

import UIKit
import Lottie

class ViewController: UIViewController {

    private lazy var animationView: AnimationView = {
        let animationView = AnimationView()
        animationView.contentMode = .scaleAspectFit
        animationView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(startDownload)))
        return animationView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        view.addSubview(animationView)
        animationView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            animationView.widthAnchor.constraint(equalToConstant: 300),
            animationView.heightAnchor.constraint(equalToConstant: 300),
            animationView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            animationView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
        
        Animation.loadedFrom(url: URL(string: "https://assets3.lottiefiles.com/packages/lf20_ovrobmwj.json")!, closure: { [animationView] animation in
            animationView.animation = animation
        }, animationCache: LRUAnimationCache.sharedCache)
    }
    
    // MARK: - Download

    @objc func startDownload() {
        animationView.play(toFrame: 120) { [animationView] _ in
            DownloadManager(url: URL(string: "https://source.unsplash.com/random/10000x10000")!).startDownload { progress in
                animationView.currentFrame = 120+((189-120)*progress)
            } onCompleted: {
                animationView.play(toFrame: 245)
            }
        }
    }
}
