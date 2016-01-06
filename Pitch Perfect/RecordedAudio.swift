//
//  RecordedAudio.swift
//  AudioSlave
//
//  Created by Eduardo Prats on 1/4/16.
//  Copyright © 2016 edprats. All rights reserved.
//

import Foundation

class RecordedAudio: NSObject {
    var filePathURL: NSURL!
    var title: String!
    
    init(filePathUrl: NSURL!, title: String!) {
        self.filePathURL = filePathUrl
        self.title = title
    }
    
}