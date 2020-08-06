//
//  TextFieldCustom.swift
//  MC3ProgMe
//
//  Created by Peter Andrew on 03/08/20.
//  Copyright © 2020 Peter Andrew. All rights reserved.
//

import Foundation
import UIKit
class TextFieldCustom: UITextField {

    let padding = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)

    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
}
