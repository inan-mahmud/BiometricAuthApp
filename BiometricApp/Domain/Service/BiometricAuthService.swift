//
//  BiometricAuthService.swift
//  BiometricApp
//
//  Created by cefalo on 13/12/23.
//

import Foundation
import LocalAuthentication

final class BiometricAuthService {
    
     public func requestBiometricUnlock(completion: @escaping (Result<BiometricState, AuthenticationError>) -> Void) {
        let context = LAContext()
        var error: NSError?
        let canEvaluate = context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error)
        
        
        if let error  = error {
            switch error.code {
                case BioMetricErrorCode.deniedAccess.rawValue:
                    completion(.failure(.deniedAccess))
                case BioMetricErrorCode.noFingerPrintEnrolled.rawValue:
                    if context.biometryType == .faceID {
                        completion(.failure(.noFaceIdEnrolled))
                    } else {
                        completion(.failure(.noFingerprintEnrolled))
                }
                default:
                    completion(.failure(.biometrictError))
            }
            return
        }
        
        if canEvaluate {
            if context.biometryType != .none {
                context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: "Provide Face ID or Touch ID to Login") { success, error in
                    DispatchQueue.main.async {
                        if let error = error {
                            switch error._code {
                            case LAError.Code.systemCancel.rawValue:
                                completion(.failure(.sessionCancelled))
                            case LAError.Code.userCancel.rawValue:
                                completion(.failure(.userCancelled))
                            case LAError.userFallback.rawValue:
                                completion(.failure(.fallback))
                            default:
                                completion(.failure(.unknown))
                            }
                        } else {
                            completion(.success(.done))
                        }
                    }
                }
            }
        } else {
            completion(.failure(.fallback))
        }
    }
}
