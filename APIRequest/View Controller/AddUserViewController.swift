//
//  AddUserViewController.swift
//  APIRequest
//
//  Created by Boris Blanco Caceres on 14/12/22.
//

/*  NOTA: Por las limitaciones de la API las funciones ADD, UPDATE, DELETE solo se puede observar por consola.
    NOTE: For the limitations of de API the ADD, UPDATE, DELETE functions can only be observed by console.
    Para la Eleminar un usuario solo debes mantener presionado el nombre de usuario que deseas eliminar.
    To delete an user you have only long press the username you want to delete. */

import UIKit

class AddUserViewController: UIViewController {
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var genderTextField: UITextField!
    @IBOutlet weak var statusTextField: UITextField!
    @IBOutlet weak var idTextField: UITextField!
    @IBOutlet weak var completeButtom: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func emailTextFieldAction(_ sender: Any) {
        var counter: Int = 0
        
        for i in emailTextField.text! {
            if i == "@" || i == "." {
                counter += 1
                print(counter)
            }
        }
        
        if counter == 2 {
            return
        } else {
            let alertEmail = UIAlertController(title: "Error!", message: "Unknoed email format", preferredStyle: .alert)
            let okButtomAlert = UIAlertAction(title: "Ok", style: .default, handler: nil)
            alertEmail.addAction(okButtomAlert)
            self.present(alertEmail, animated: true, completion: nil)
        }
    }
    
    @IBAction func genderTextFieldAction(_ sender: Any) {
        
        if genderTextField.text?.lowercased() == "male" || genderTextField.text?.lowercased() == "female" {
            return
        } else {
            let alertGender = UIAlertController(title: "Error!", message: "Unknowed gender", preferredStyle: .alert)
            let okButtomAlert = UIAlertAction(title: "Ok", style: .default, handler: nil)
            alertGender.addAction(okButtomAlert)
            self.present(alertGender, animated: true, completion: nil)
        }
    }
    
    @IBAction func statusTextFieldAction(_ sender: Any) {
        
        if statusTextField.text?.lowercased() == "active" || statusTextField.text?.lowercased() == "inactive" {
            return
        } else {
            let alertStatus = UIAlertController(title: "Error!", message: "Unknowed status", preferredStyle: .alert)
            let okButtomAlert = UIAlertAction(title: "Ok", style: .default, handler: nil)
            alertStatus.addAction(okButtomAlert)
            self.present(alertStatus, animated: true, completion: nil)
        }
    }
    
    @IBAction func completeButtomAction(_ sender: Any) {
        addNewUser()
        
        let alertCompletionButtom = UIAlertController(title: "Succesful!", message: "New User Added", preferredStyle: .alert)
        let okButtomAlert = UIAlertAction(title: "Ok", style: .default)
        alertCompletionButtom.addAction(okButtomAlert)
        self.present(alertCompletionButtom, animated: true, completion: nil)
    }
}

// MARK: - Extension

extension AddUserViewController {
    
    func addNewUser() {
        
        let nameNewUser: String? = nameTextField.text
        let emailNewUser: String? = emailTextField.text
        let genderNewUser: String? = genderTextField.text
        let statusNewUser: String? = statusTextField.text
        
        let user = NewUser(name: nameNewUser, email: emailNewUser, gender: genderNewUser, status: statusNewUser)
        
        NetworkingProvider.shared.addUser(user: user) { response in
            print(response)
            print(response.all.id.description)
            self.idTextField.text = response.all.id.description
        } failure: { error in
            print(error!)
        }
        
        print(nameNewUser!)
        print(emailNewUser!)
        print(genderNewUser!)
        print(statusNewUser!)
    }
}
