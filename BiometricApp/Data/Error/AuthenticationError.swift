//
//  AuthenticationError.swift
//  BiometricApp
//
//  Created by cefalo on 13/12/23.
//

import Foundation


enum AuthenticationError: Error, LocalizedError, Identifiable {
    case invalidCredentials
    case deniedAccess
    case noFaceIdEnrolled
    case noFingerprintEnrolled
    case biometrictError
    case fallback
    case sessionCancelled
    case userCancelled
    case unknown
    
    var id: String {
        self.localizedDescription
    }
    
    var errorDescription: String {
        switch self {
            case .invalidCredentials:
                return "Either your email or password are incorrect. Please try again."
            case .deniedAccess:
                return "You have denied access. Please go to the settings app and locate this application and turn Face ID on."
            case .noFaceIdEnrolled:
                return "You have not registered any Face Ids yet"
            case .noFingerprintEnrolled:
                return "You have not registered any fingerprints yet."
            case .biometrictError:
                return "Your face or fingerprint were not recognized."
            case .fallback:
                return "Device doesn't support biometric authentication "
            case .sessionCancelled:
                return "Session Expired. Please try again"
            case .userCancelled:
                return "Authentication cancelled. Please login with touch id or face id"
            case .unknown:
                return "Something went wrong!!! Please try again"
        }
    }
}
