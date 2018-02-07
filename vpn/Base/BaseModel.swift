//
//  BaseModel.swift
//  QuanZai
//
//  Created by i-chou on 6/17/16.
//  Copyright © 2016 i-chou. All rights reserved.
//

import ObjectMapper

class BaseModel: NSObject, Mappable {
    
    var id            : NSNumber?
    var create_time   : String?
    var type          : NSNumber = 0
    var status        : NSNumber?
    
    override init() {
        super.init()
    }
    
    required init?(map: Map){
        
    }
    
    func mapping(map: Map) {
        
        id <- map["id"]
        create_time <- map["create_time"]
        type <- map["type"]
        status <- map["status"]
    }
}
