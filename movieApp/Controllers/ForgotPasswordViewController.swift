//
//  ForgotPasswordViewController.swift
//  movieApp
//
//  Created by Mustafa on 22.02.2022.
//

import UIKit
import Firebase

class ForgotPasswordViewController: UIViewController {

    //MARK: - Outlets
    @IBOutlet weak var emailTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    //MARK: - Buttons
    @IBAction func sendButtonClicked(_ sender: UIButton) {
        if let email = emailTextField.text {
            //Reset password
            Auth.auth().sendPasswordReset(withEmail: email) { error in
              // ...
                if let e = error {
                    self.makeAlert(title: "Error", message: "Error is: \(e.localizedDescription)", backButton: false)
                }else {
                    self.makeAlert(title: "Check Your Email", message: "We sent a code for reseting your password.", backButton: true)
                }
            }
        }
    }
}
//MARK: - Alert
extension ForgotPasswordViewController {
    func makeAlert(title: String, message: String, backButton: Bool) {
        
        let okButton: UIAlertAction?
        //Uyarı mesajını oluşturma
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        
        if backButton {
            okButton = UIAlertAction(title: "Okay", style: UIAlertAction.Style.destructive, handler: { alert in
                self.navigationController?.popToRootViewController(animated: true)
            })
        }else {
            okButton = UIAlertAction(title: "Okay", style: UIAlertAction.Style.destructive, handler: nil)
        }

        //Ok butonunu uyarı mesajımıza ekleme
        alert.addAction(okButton!)
        //Uyarı mesajını gösterme
        self.present(alert, animated: true, completion: nil)
    }
}

