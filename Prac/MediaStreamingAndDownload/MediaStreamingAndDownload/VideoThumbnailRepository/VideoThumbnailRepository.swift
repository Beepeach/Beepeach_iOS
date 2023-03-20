//
//  VedioThumbnailRepository.swift
//  MediaStreamingAndDownload
//
//  Created by JunHeeJo on 3/19/23.
//

import UIKit
import AVFoundation

final class VedioThumbnailRepository {
    // MARK: Properties
    static let shared = VedioThumbnailRepository()
    private let diskCache: ThumbnailDiskCache = ThumbnailDiskCache.shared
  
    // MARK: Methods
    func generateThumbnailImageFrom(url: URL, completion: @escaping ((_ image: UIImage?)->Void)) {
        DispatchQueue.global().async { [weak self] in
            guard let self = self else { return }
            
            let asset = AVAsset(url: url)
            let assetImageGenerator = AVAssetImageGenerator(asset: asset)
            
            let thumbnailTime = CMTimeMake(value: 2, timescale: 1)
            
            do {
                self.diskCache.enqueue(url: url)
                let cgThumbnailImage = try assetImageGenerator.copyCGImage(at: thumbnailTime, actualTime: nil)
                let thumbnailImage = UIImage(cgImage: cgThumbnailImage)
                DispatchQueue.main.async {
                    self.diskCache.dequeue(url: url)
                    completion(thumbnailImage)
                }
            } catch {
                print(error.localizedDescription)
                DispatchQueue.main.async {
                    self.diskCache.dequeue(url: url)
                    completion(nil)
                }
            }
        }
    }
    
    // MARK: Init
    private init() { }
}

final class ThumbnailDiskCache {
    static let shared = ThumbnailDiskCache()
    
    private var downloadQueue: Set<URL> = []
    private let cacheDirectoryURL: URL
    
    func enqueue(url: URL) {
        downloadQueue.insert(url)
    }
    
    func dequeue(url: URL) {
        downloadQueue.remove(url)
    }
    
    func isDownloading(url: URL) -> Bool {
        return downloadQueue.contains(url)
    }
    
    func store() {
        
    }
    
    func fetch(for url: String) -> UIImage {
          return Observable.create { observer in
              guard let url = URL(string: url) else {
                  LogManager.api.logError(MediaCacheError.invalidURL(url: url))
                  observer.onCompleted()
                  return Disposables.create()
              }
              let cacheURL = self.cacheDirectoryURL.appendingPathComponent(url.lastPathComponent)
              let avAsset = AVAsset(url: cacheURL)
              let avAssetMetaData = AVAssetMetadata(sourceURL: url, fileURL: cacheURL, asset: avAsset)
              if FileManager.default.fileExists(atPath: cacheURL.path) {
                  observer.onNext(avAssetMetaData)
                  observer.onCompleted()
                  return Disposables.create()
              }
              
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


