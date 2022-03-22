//
//  UIViewExt.swift
//  DropdownTextField
//
//  Created by Duy Tran N. VN.Danang on 12/25/21.
//

import UIKit.UIView

extension UIView {

    var globalFrame: CGRect? {
        return superview?.convert(frame, to: nil)
    }

    class func fromNib<T: UIView>() -> T {
        return Bundle(for: T.self).loadNibNamed(String(describing: T.self), owner: nil, options: nil)![0] as! T
    }
}
