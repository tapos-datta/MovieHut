//
//  ScreenUtils.swift
//  MovieHut
//
//  Created by Optimus Prime on 14/11/24.
//
import Foundation
import UIKit

struct ScreenUtils {
    
    static let refWidth = 414.0
    static let refHeight = 896.0
    
    static func responsiveWidth(_ width: Double) -> Double {
        let screenWidth = UIScreen.main.bounds.width
        return width / refWidth * screenWidth
    }
    
    static func responsiveHeight(_ height: Double) -> Double {
        let screenHeight = UIScreen.main.bounds.height
        return height / refHeight * screenHeight
    }
    
}
