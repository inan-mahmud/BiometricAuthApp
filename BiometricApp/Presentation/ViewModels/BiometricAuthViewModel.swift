//
//  BiometricAuthViewModel.swift
//  BiometricApp
//
//  Created by cefalo on 13/12/23.
//

import Foundation

final class BiometricAuthViewModel : ObservableObject {
    
    let biometricAuthService = BiometricAuthService()
    
    @Published var biometricState = BiometricState.initial
    
    func signInWithBioMetric() {
        biometricState = BiometricState.loading
        biometricAuthService.requestBiometricUnlock { [weak self] result in
            switch result {
            case .success(_):
                self?.biometricState = BiometricState.done
            case .failure(let error):
                if error == .fallback {
                    self?.biometricState = BiometricState.fallback
                } else {
                    self?.biometricState = BiometricState.error(error)
                }
            }
        }
    }
}
