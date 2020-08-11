//
//  ImageConverter.swift
//  MC3
//
//  Created by Peter Andrew on 11/08/20.
//  Copyright © 2020 Aghawidya Adipatria. All rights reserved.
//

import Foundation
import UIKit
import SwiftUI

class ImageConverter {
    static func convURLtoData(url:URL)->UIImage{
        do
         {
            let data = try Data.init(contentsOf: url)
            return UIImage(data: data) ?? #imageLiteral(resourceName: "OverviewLarge")
         }
        catch {
            return #imageLiteral(resourceName: "moduleCover")
        }
    }
}
