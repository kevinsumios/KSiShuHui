//
//  Chapter+extension.swift
//  KSiShuHui
//
//  Created by Kevin Sum on 21/7/2017.
//  Copyright © 2017 Kevin iShuHui. All rights reserved.
//

import Foundation
import MagicalRecord
import SwiftyJSON

extension Chapter {
    
    var chapterTitle: String {
        get {
            return "第\(chapterNo)\(chapterType > 0 ? "卷" : "話")"
        }
    }
    
    class func create(by chapter: Chapter, at context: NSManagedObjectContext) -> Chapter? {
        let entity = Chapter.mr_createEntity(in: context)
        entity?.chapterNo = chapter.chapterNo
        entity?.chapterType = chapter.chapterType
        entity?.cover = chapter.cover
        entity?.id = chapter.id
        entity?.refreshTime = chapter.refreshTime
        entity?.title = chapter.title
        return entity
    }
    
    class func serialize(_ json: JSON) -> Chapter? {
        if let data = json.dictionary {
            let chapter = Chapter.mr_createEntity()
            chapter?.id = data["Id"]?.int16 ?? 0
            chapter?.title = data["Title"]?.string
            chapter?.cover = data["FrontCover"]?.string
            chapter?.chapterNo = data["ChapterNo"]?.int16 ?? 0
            chapter?.chapterType = data["ChapterType"]?.int16 ?? 0
            let refresh = data["RefreshTime"]?.string ?? ""
            let range = refresh.index(refresh.startIndex, offsetBy: 6)..<refresh.index(refresh.endIndex, offsetBy: -2)
            let refreshTime = (Double(refresh.substring(with: range)) ?? 0)/1000
            chapter?.refreshTime = NSDate(timeIntervalSince1970: refreshTime)
            return chapter
        }
        return nil
    }
}
