//
//  ZeeVideoPlayerDelegate.swift
//
//
//  Created by BizBrolly on 13/03/24.
//

import Foundation

@objc public protocol ZeeVideoPlayerDelegate: AnyObject{
    @objc optional func play()
    @objc optional func pause()
    @objc optional func replay()
}
