//
//  BiometricState.swift
//  BiometricApp
//
//  Created by cefalo on 13/12/23.
//

import Foundation


enum BiometricState {
    case initial
    case loading
    case done
    case error(AuthenticationError)
    case fallback
}
