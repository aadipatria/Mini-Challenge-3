//
//  AppsTime.swift
//  MC3ProgMe
//
//  Created by Peter Andrew on 29/07/20.
//  Copyright © 2020 Peter Andrew. All rights reserved.
//

import Foundation

class AppsTime {
    static func generateTimeAgo(time:Date)->String{
        let timeRange = time.timeIntervalSinceNow * -1
        if timeRange > 86400 {
            return " \(Int(timeRange / 86400)) days ago"
        } else if timeRange > 3600 {
            return " \(Int(timeRange / 3600)) hours ago"
        } else if timeRange > 60 {
            return " \(Int(timeRange / 60)) minutes ago"
        }
        return " \(Int(timeRange / 60)) seconds ago"
    }
}
