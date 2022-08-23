//
//  DownloadManager.swift
//  ProgressAnimation
//
//  Created by Evandro Hoffmann on 22/08/22.
//

import Foundation

class DownloadManager: NSObject, URLSessionDataDelegate, URLSessionDelegate {
    
    var session: URLSession?
    var dataTask: URLSessionDataTask?
    var buffer: NSMutableData = NSMutableData()
    var expectedContentLength = 0
    var url: URL
    var onProgress: ((Double) -> Void)?
    var onCompleted: (() -> Void)?
    
    init(url: URL) {
        self.url = url
        super.init()
    }
    
    func startDownload(onProgress: @escaping (Double) -> Void,
                       onCompleted: @escaping () -> Void) {
        self.onProgress = onProgress
        self.onCompleted = onCompleted
        
        let configuration = URLSessionConfiguration.default
        let queue = OperationQueue.main
        session = URLSession(configuration: configuration, delegate: self, delegateQueue: queue)
        dataTask = session?.dataTask(with: URLRequest(url: url))
        dataTask?.resume()
    }
    
    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive data: Data) {
        buffer.append(data)
        let progress = Double(buffer.length) / Double(expectedContentLength)
        onProgress?(progress)
    }
    
    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive response: URLResponse, completionHandler: (URLSession.ResponseDisposition) -> Void) {
        expectedContentLength = Int(response.expectedContentLength)
        completionHandler(URLSession.ResponseDisposition.allow)
    }
    
    func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
        onCompleted?()
    }
}
