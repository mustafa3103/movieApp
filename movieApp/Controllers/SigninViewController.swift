//
//  SigninViewController.swift
//  movieApp
//
//  Created by Mustafa on 21.02.2022.
//

import UIKit
import Firebase

class SigninViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func signinButtonClicked(_ sender: UIButton) {
        let email = emailTextField.text!
        let password = passwordTextField.text!
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            if error != nil {
                self.makeAlert(title: "Sign in Error", message: "Error is: \(error!.localizedDescription)")
            }else {
                self.performSegue(withIdentifier: K.toMainVC, sender: self)
            }
        }
    }
}
//MARK: - Alert
extension SigninViewController {
    func makeAlert(title: String, message: String) {
        
        //Uyarı mesajını oluşturma
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "Okay", style: UIAlertAction.Style.destructive, handler: nil)
        
        //Ok butonunu uyarı mesajımıza ekleme
        alert.addAction(okButton)
        //Uyarı mesajını gösterme
        self.present(alert, animated: true, completion: nil)
    }
}
