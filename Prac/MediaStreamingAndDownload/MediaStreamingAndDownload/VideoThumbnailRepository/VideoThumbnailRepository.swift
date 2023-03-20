//
//  VideoThumbnailRepository.swift
//  MediaStreamingAndDownload
//
//  Created by JunHeeJo on 3/19/23.
//

import UIKit
import AVFoundation

final class VideoThumbnailRepository {
    // MARK: Properties
    static let shared = VideoThumbnailRepository()
    private let generator: ThumbnailGenerator = ThumbnailGenerator()
    private let diskCache: ThumbnailDiskCache = ThumbnailDiskCache.shared
  
   
    
    // MARK: Init
    private init() { }
}

final class ThumbnailDiskCache {
    static let shared = ThumbnailDiskCache()
    private let cacheDirectoryURL: URL
    
    func store() {
        
    }
    
    func fetch(for url: URL) -> UIImage {
        let cacheURL = self.cacheDirectoryURL.appendingPathComponent(url.lastPathComponent)
        let thumbnailImage = AVAsset(url: cacheURL)
        let avAssetMetaData = AVAssetMetadata(sourceURL: url, fileURL: cacheURL, asset: avAsset)
        if FileManager.default.fileExists(atPath: cacheURL.path) {
            observer.onNext(avAssetMetaData)
            observer.onCompleted()
            return Disposables.create()
        }
        
        
          return Observable.create { observer in
              
              
              observer.onNext(nil)
              observer.onCompleted()
              return Disposables.create()
          }
      }
    
    private init() {
        let cacheDirectoryName = "ThumbnailDiskCache"
        
        if let cachesDirectory = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first {
            cacheDirectoryURL = cachesDirectory.appendingPathComponent(cacheDirectoryName, isDirectory: true)
            createThumbnailDiskCacheDirectory()
        } else {
            let temporaryDirectoryURL = FileManager.default.temporaryDirectory
            cacheDirectoryURL = temporaryDirectoryURL
        }
    }
    
    private func createThumbnailDiskCacheDirectory() {
        do {
            try FileManager.default.createDirectory(at: cacheDirectoryURL, withIntermediateDirectories: true)
        } catch let error {
            print(error.localizedDescription)
        }
    }
}


