//
//  ViewController.swift
//  GitTestProject
//
//  Created by finports_dev on 2020/02/19.
//  Copyright © 2020 finports_dev. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import SwiftKeychainWrapper

import LocalAuthentication

class ViewController: UIViewController {
    
    @IBOutlet var label: UILabel!
    @IBOutlet var button: UIButton!
    
    @IBOutlet weak var field1: UITextField!
    @IBOutlet weak var field2: UITextField!
    
    @IBOutlet weak var lbl: UILabel! 
    
    
    var viewModel : ViewModel!
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let inputs = ViewModel.Inputs(tap: button.rx.tap.map{ _ in})
        
        viewModel = ViewModel(inputs)
        viewModel.number.drive(label.rx.text).disposed(by: disposeBag)
        
        if let ID = KeychainWrapper.standard.string(forKey: "ID") {
            if let PW = KeychainWrapper.standard.string(forKey: "PW") {
                print("\(ID)---\(PW)")
            }
        }
        
    }
    @IBAction func btnFace(_ sender: Any) {
        let authContext = LAContext()
        
        var error: NSError?
        
        var description: String!
        
        if authContext.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            
            switch authContext.biometryType {
            case .faceID:
                description = "계정 정보를 열람하기 위해서 Face ID로 인증 합니다."
                break
            case .touchID:
                description = "계정 정보를 열람하기 위해서 Touch ID로 인증 사용합니다."
                break
            case .none:
                description = "계정 정보를 열람하기 위해서는 로그인하십시오."
                break
            }
            
            authContext.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: description) { (success, error) in
                
                if success {
                    print("인증 성공")
                } else {
                    print("인증 실패")
                    if let error = error {
                        print(error.localizedDescription)
                    }
                }
            }
        }  else {
            // Touch ID・Face ID를 사용할 수없는 경우
            let errorDescription = error?.userInfo["NSLocalizedDescription"] ?? ""
            print(errorDescription)
            description = "계정 정보를 열람하기 위해서는 로그인하십시오."
            
            let alertController = UIAlertController(title: "Authentication Required", message: description, preferredStyle: .alert)
            weak var usernameTextField: UITextField!
            alertController.addTextField(configurationHandler: { textField in
                textField.placeholder = "User ID"
                usernameTextField = textField
            })
            weak var passwordTextField: UITextField!
            alertController.addTextField(configurationHandler: { textField in
                textField.placeholder = "Password"
                textField.isSecureTextEntry = true
                passwordTextField = textField
            })
            alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            alertController.addAction(UIAlertAction(title: "Log In", style: .destructive, handler: { action in
                // 를
                print(usernameTextField.text! + "\n" + passwordTextField.text!)
            }))
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
    func auth() {
        let authContext = LAContext()
        
        var error: NSError?
        var description = ""
        
        if authContext.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            switch authContext.biometryType {
            case .faceID:
                print("faceID")
                description = "faceID"
                break
            case .touchID:
                print("touchID")
                description = "touchID"
                break
            case .none:
                print("none")
                description = "none"
                break
            }
        }
        
        authContext.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: description, reply: { (success, error) in
            if success {
                print("인증성공")
            } else {
                print("인증실패")
                if let error = error {
                    print(error.localizedDescription)
                }
            }
        })
    }
    
    @IBAction func btnLogin(_ sender: Any) {
        print(field1.text)
        print(field2.text)
        let saveID : Bool = KeychainWrapper.standard.set(field1.text!, forKey: "ID")
        let savePW : Bool = KeychainWrapper.standard.set(field2.text!, forKey: "PW")
    }
    
    //rebase test 02
    
    //33
    
    //44
}

