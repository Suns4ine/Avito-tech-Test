//
//  PublicMethods.swift
//  Avito-tech Test
//
//  Created by Vyacheslav Pronin on 11.11.2022.
//

import Foundation
import UIKit

public func isDeviceIPad() -> Bool {
    return UIDevice.current.userInterfaceIdiom == .pad
}
