//
//  Subscription+extension.swift
//  KSiShuHui
//
//  Created by Kevin Sum on 30/7/2017.
//  Copyright © 2017 Kevin iShuHui. All rights reserved.
//

import Foundation
import MagicalRecord
import SwiftyJSON

extension Subscription {
    
    class func subscribe(bookId: Int16, YesOrNo: Bool) {
        MagicalRecord.save(blockAndWait: { (localContext) in
            var entity = Subscription.mr_findFirst(byAttribute: "bookId", withValue: bookId, in: localContext)
            if entity == nil, YesOrNo {
                entity = Subscription.mr_createEntity(in: localContext)
                entity?.bookId = bookId
            } else if entity != nil, !YesOrNo {
                entity?.mr_deleteEntity(in: localContext)
            }
        })
    }
    
    class func isSubscribe(bookId: Int16?) -> Bool {
        if Subscription.mr_findFirst(byAttribute: "bookId", withValue: bookId ?? -1) == nil {
            return false
        } else {
            return true
        }
    }
    
}
