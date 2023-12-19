//
//  ViewController.swift
//  BiometricApp
//
//  Created by cefalo on 12/12/23.
//

import UIKit
import Combine

class ViewController: UIViewController {
    
    
    @IBOutlet weak var biometricButton: UIButton!
    @IBOutlet weak var touchIDImage: UIImageView!
    @IBOutlet weak var faceIdImage: UIImageView!
    
    private var biometricAuthViewModel = BiometricAuthViewModel()
    private var subscriptions = Set<AnyCancellable>()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpBindings()
    }
    
    private func setUpBindings() {
        biometricAuthViewModel.$biometricState.sink {  biometricState in
            DispatchQueue.main.async { [weak self] in
                self?.updateViews(biometricState: biometricState)
            }
        }.store(in: &subscriptions)
    }
    
    private func updateViews(biometricState state : BiometricState) {
        switch state {
            case .initial:
                break
            case .loading:
                break
            case .done:
                showWelcomeModalSheet(for: "Success", with: "Signed In Successfully")
            case .error(let error):
                notifyUser("Inavlid Login", error.errorDescription)
            case .fallback:
                navigateToWelcomeScreen()
        }
    }
    
    
    private func showWelcomeModalSheet(for title: String, with message: String) {
        let modal = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
        modal.addAction(UIAlertAction(title: "Okay", style: .cancel,handler: { [weak self] action in
            self?.dismissOnTapOutside()
        }))
        self.present(modal,animated: true,completion: nil)
    }
    
    private func navigateToWelcomeScreen() {
        let storyboard = self.storyboard?.instantiateViewController(withIdentifier: "WelcomeViewController") as! WelcomeViewController
        self.navigationController?.pushViewController(storyboard, animated: true)
    }
    
    func notifyUser(_ title: String, _ message: String) {
        let alert = UIAlertController(title: title,
            message: message,
            preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "OK",
            style: .cancel)
        alert.addAction(cancelAction)
        self.present(alert, animated: true)
    }
    
    
    @IBAction func onButtonClick(_ sender: UIButton) {
        self.biometricAuthViewModel.signInWithBioMetric()
        
    }
    
    @objc func dismissOnTapOutside(){
        self.dismiss(animated: true, completion: nil)
    }
}








