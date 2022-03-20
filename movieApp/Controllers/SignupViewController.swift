//
//  SignupViewController.swift
//  movieApp
//
//  Created by Mustafa on 21.02.2022.
//

import UIKit
import Firebase

class SignupViewController: UIViewController {

    //MARK: - Outlets
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var passwordAgainTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    //MARK: - Buttons
    @IBAction func signUpButtonClicked(_ sender: UIButton) {
      
        let email = emailTextField.text!
        let password = passwordTextField.text!
        let passwordAgain = passwordAgainTextField.text!
        
        if email.count > 0 && password.count >= 6 && passwordAgain.count >= 6 {
            if password == passwordAgain {
                //Create user
                Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                    if error != nil {
                        self.makeAlert(title: "Creating error", message: "Error was occured while creating new account. Error is: \(error!.localizedDescription)")
                    }else {
                        //SeguetoMainVC
                        self.performSegue(withIdentifier: K.toMainVC, sender: nil)
                    }
                }
            }else {
                //Passwords are not matching
                self.makeAlert(title: "Passwords", message: "Passwords are not matching.")
            }
        }else {
            //tell the user for filling all areas
            self.makeAlert(title: "Empty area", message: "Please fill the whole areas")
        }
    }
}
//MARK: - Alert
extension SignupViewController {
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
