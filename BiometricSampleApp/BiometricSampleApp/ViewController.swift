//
//  ViewController.swift
//  BiometricSampleApp
//
//  Created by Field Employee on 08/11/21.
//

import UIKit
import LocalAuthentication

class ViewController: UIViewController {

    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 200, height: 75))
        view.addSubview(button)
        button.center = view.center
        button.setTitle("Xu Li! Do the thing!!", for: .normal)
        button.backgroundColor = .systemBlue
        button.addTarget(self, action: #selector(XuLiDoTheThing), for: .touchUpInside)
    }

    @objc func XuLiDoTheThing() {
        let context = LAContext()
        var error: NSError? = nil
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            let reason = "Please authorize touch-id"
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) {[weak self] success, error in
                DispatchQueue.main.async {
                    guard success, error == nil else {
                        // failed
                        let alert = UIAlertController(title: "Failed to authenticate", message: "Please try again", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
                        self?.present(alert, animated: true)
                        return
                    }
                    // Success, show other screen
                    let XuLi = UIViewController()
                    XuLi.title = "Welcome Xu Li!"
                    XuLi.view.backgroundColor = .systemGray
                    self?.present(UINavigationController(rootViewController: XuLi), animated: true, completion: nil)
                }
            }
        }
        else {
            // device does not support
            let alert = UIAlertController(title: "Unavailable", message: "Feature unavailable", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
            present(alert, animated: true)
        }
    }

}
