//
//  ThumbnailGenerator.swift
//  MediaStreamingAndDownload
//
//  Created by JUNHEE JO on 2023/03/20.
//

import UIKit
import AVFoundation

final class ThumbnailGenerator {
    private var generatingAssetMap: [URL: AVAsset] = [:]
    
    // MARK: Methods
    func generateThumbnailImageIfNeeded(from url: URL, completion: @escaping (UIImage?) -> Void) {
        DispatchQueue.global().async { [weak self] in
              guard let self = self else { return }
              
              if let asset = self.generatingAssetMap[url] {
                  self.generateThumbnail(from: asset, at: CMTimeMake(value: 2, timescale: 2)) { image in
                      DispatchQueue.main.async {
                          completion(image)
                      }
                  }
              } else {
                  let asset = AVAsset(url: url)
                  self.generatingAssetMap[url] = asset
                  self.generateThumbnail(from: asset, at: CMTimeMake(value: 2, timescale: 1)) { image in
                      DispatchQueue.main.async {
                          self.generatingAssetMap.removeValue(forKey: url)
                          completion(image)
                      }
                  }
              }
          }
      }
    
    private func generateThumbnail(from asset: AVAsset, at time: CMTime, completion: @escaping (UIImage?) -> Void) {
        let generator = AVAssetImageGenerator(asset: asset)
        
        do {
            let cgImage = try generator.copyCGImage(at: time, actualTime: nil)
            let image = UIImage(cgImage: cgImage)
            completion(image)
        } catch {
            print(error.localizedDescription)
            completion(nil)
        }
    }
}
