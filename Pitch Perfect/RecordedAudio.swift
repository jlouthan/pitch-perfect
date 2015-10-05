//
//  RecordedAudio.swift
//  Pitch Perfect
//
//  Created by Jennifer Louthan on 10/1/15.
//  Copyright (c) 2015 JennyLouthan. All rights reserved.
//

import Foundation

class RecordedAudio: NSObject {
    
    var filePathUrl: NSURL
    var title: String
    
    init(filePathUrl: NSURL, title: String) {
        self.filePathUrl = filePathUrl
        self.title = title
    }
    
}
