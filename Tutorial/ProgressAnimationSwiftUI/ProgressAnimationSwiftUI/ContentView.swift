//
//  ContentView.swift
//  ProgressAnimationSwiftUI
//
//  Created by Evandro Hoffmann on 22/08/22.
//

import SwiftUI

struct ContentView: View {
    @State var state: DownloadView.State = .normal
    
    var body: some View {
        DownloadView(url: URL(string: "https://assets3.lottiefiles.com/packages/lf20_ovrobmwj.json")!, state: $state)
            .frame(width: 300, height: 300)
            .onTapGesture {
                state = .prepareForDownload
                
                DownloadManager(url: URL(string: "https://source.unsplash.com/random/10000x10000")!).startDownload { progress in
                    state = .downloading(progress: progress)
                } onCompleted: {
                    state = .downloaded
                }
            }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

