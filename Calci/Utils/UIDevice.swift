//
//  UIDevice.swift
//  Calci
//
//  Created by Syed Wajahat Ali on 08/04/2023.
//

import Foundation
import UIKit

extension UIDevice {
    var iPhoneX: Bool { UIScreen.main.nativeBounds.height == 2436 }
    var iPhone: Bool { UIDevice.current.userInterfaceIdiom == .phone }
    var iPad: Bool { UIDevice().userInterfaceIdiom == .pad }
    var iPhone8Plus: Bool { UIScreen.main.nativeBounds.height == 2208 }
    enum ScreenType: String {
        case iPhones_6_6s_7_8 = "iPhone 6, iPhone 6S, iPhone 7 or iPhone 8"
        case iPhones_6Plus_6sPlus_7Plus_8Plus = "iPhone 6 Plus, iPhone 6S Plus, iPhone 7 Plus or iPhone 8 Plus"
        case iPhones_6Plus_6sPlus_7Plus_8Plus_Simulators = "iPhone 6 Plus, iPhone 6S Plus, iPhone 7 Plus or iPhone 8 Plus Simulators"
        case iPhones_X_XS_12MiniSimulator = "iPhone X or iPhone XS or iPhone 12 Mini Simulator"
        case iPhone_XR_11 = "iPhone XR or iPhone 11"
        case iPhone_XSMax_ProMax = "iPhone XS Max or iPhone Pro Max"
        case iPhone_11Pro = "iPhone 11 Pro"
        case iPhone_12Mini_13Mini = "iPhone 12 Mini or iPhone 13 Mini"
        case iPhone_12_12Pro_13Pro_14 = "iPhone 12 or iPhone 12 Pro or iPhone 13 Pro or iPhone 14"
        case iPhone_12ProMax_13ProMax_14Plus = "iPhone 12 Pro Max or iPhone 13 Pro Max or iPhone 14 Plus"
        case iPhone_14Pro = "iPhone 14 Pro"
        case iPhone_14ProMax = "iPhone 14 Pro Max"
        case unknown
    }
    var screenType: ScreenType {
        switch UIScreen.main.nativeBounds.height {
        case 1334:
            return .iPhones_6_6s_7_8
        case 1792:
            return .iPhone_XR_11
        case 1920:
            return .iPhones_6Plus_6sPlus_7Plus_8Plus
        case 2208:
            return .iPhones_6Plus_6sPlus_7Plus_8Plus_Simulators
        case 2340:
            return .iPhone_12Mini_13Mini
        case 2426:
            return .iPhone_11Pro
        case 2436:
            return .iPhones_X_XS_12MiniSimulator
        case 2532:
            return .iPhone_12_12Pro_13Pro_14
        case 2556:
            return .iPhone_14Pro
        case 2688:
            return .iPhone_XSMax_ProMax
        case 2778:
            return .iPhone_12ProMax_13ProMax_14Plus
        case 2796:
            return .iPhone_14ProMax
        default:
            return .unknown
        }
    }
}
