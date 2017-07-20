//
//  Bookmark+extension.swift
//  KSiShuHui
//
//  Created by Kevin Sum on 21/7/2017.
//  Copyright © 2017 Kevin iShuHui. All rights reserved.
//

import Foundation
import MagicalRecord
import SwiftyJSON

extension Bookmark {
    
    class func saveEntity(bookId: Int16, chapter: Chapter) {
        MagicalRecord.save(blockAndWait: { (localContext) in
            var entity = Bookmark.mr_findFirst(byAttribute: "bookId", withValue: bookId, in: localContext)
            if entity == nil {
                entity = Bookmark.mr_createEntity(in: localContext)
            }
            entity?.bookId = bookId
            entity?.chapter = Chapter.create(by: chapter, at: localContext)
        })
    }
    
    class func chapter(of bookId: Int16) -> Chapter? {
        return Bookmark.mr_findFirst(byAttribute: "bookId", withValue: bookId)?.chapter
    }
    
}
