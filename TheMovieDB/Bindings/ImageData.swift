//
//  ImageData.swift
//  TheMovieDB
//
//  Created by ibrahim on 25/07/20.
//  Copyright © 2020 ibrahim. All rights reserved.
//

import Combine
import SwiftUI
import UIKit

final class ImageDowloader: ObservableObject {
    
    private static let imageCache = NSCache<AnyObject, AnyObject>()
    private var cancellable: AnyCancellable?
    let objectWillChange = PassthroughSubject<UIImage?, Never>()

    func load(url: URL) {
        
        // check cache first, if image exist, use from cache
        if let imageFromCache = ImageDowloader.imageCache.object(forKey: url.absoluteURL as AnyObject) as? UIImage {
                self.objectWillChange.send(imageFromCache)
            return
        }
        
        self.cancellable = URLSession.shared
            .dataTaskPublisher(for: url)
            .map({ $0.data })
            .eraseToAnyPublisher()
            .receive(on: RunLoop.main)
            .map({ UIImage(data: $0) })
            .replaceError(with: nil)
            .sink(receiveValue: { image in
                guard let imageData = image else {
                    return
                }
                
                ImageDowloader.imageCache.setObject(imageData, forKey: url.absoluteURL  as AnyObject)
                self.objectWillChange.send(imageData)
            })
    }

    func cancel() {
        cancellable?.cancel()
    }
    
    deinit {
        cancel()
    }
}
