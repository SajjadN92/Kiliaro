//
//  MediaEntity.swift
//  Kiliaro
//
//  Created by Sajjad Najafi on 8/1/22.
//

import CoreData

@objc(MediaEntity)
public class MediaEntity: ManagedObject {
    
    override public func update<T>(with model: T) where T : Decodable {
        guard let model = model as? Media else {
            return
        }
        
        self.thumbnail_url = model.thumbnail_url.absoluteString
        self.download_url = model.download_url.absoluteString
        self.resy = model.resy
        self.resx = model.resx
        self.id = model.id
        self.created_at = model.created_at
    }
    
}
