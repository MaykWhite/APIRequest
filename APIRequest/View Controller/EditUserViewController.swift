//
//  EditUserViewController.swift
//  APIRequest
//
//  Created by Boris Blanco Caceres on 23/12/22.
//

/*  NOTA: Por las limitaciones de la API las funciones ADD, UPDATE, DELETE solo se puede observar por consola.
    NOTE: For the limitations of de API the ADD, UPDATE, DELETE functions can only be observed by console.
    Para la Eleminar un usuario solo debes mantener presionado el nombre de usuario que deseas eliminar.
    To delete an user you have only long press the username you want to delete. */

import UIKit

class EditUserViewController: UIViewController {
    
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var userNameTextLabel: UITextField!
    @IBOutlet weak var emailTextLabel: UITextField!
    @IBOutlet weak var genderTextLabel: UITextField!
    @IBOutlet weak var statusTextLabel: UITextField!
    
    var editData: Displayable?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        commonInitEdit()
    }
    
    
    @IBAction func saveBttmAction(_ sender: Any) {
        updateUser()
        
        let alertCompleteBttm = UIAlertController(title: "Update Succesfull!", message: "User Update", preferredStyle: .alert)
        let okButtomAlert = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alertCompleteBttm.addAction(okButtomAlert)
        self.present(alertCompleteBttm, animated: true, completion: nil)
    }
}

// MARK: - Extension

extension EditUserViewController {
    
    func commonInitEdit() {
        
        guard let data = editData else { return }
        
        idLabel.text = data.idTextLabel
        userNameTextLabel.text = data.nameTextLabel
        emailTextLabel.text = data.emailTextLabel
        genderTextLabel.text = data.genderTextLabel
        statusTextLabel.text = data.statusTextLabel
    }
    
    func updateUser() {
        
        guard let data = editData else { return }
        
        idLabel.text = data.idTextLabel
        let idReference = Int(idLabel.text!)
        print(idReference!)
        
        let userNameUpdate: String? = userNameTextLabel.text
        let emailUpdate: String? = emailTextLabel.text
        let genderUpdate: String? = genderTextLabel.text
        let statusUpdate: String? = statusTextLabel.text
        
        let userUpdate = NewUser(name: userNameUpdate, email: emailUpdate, gender: genderUpdate, status: statusUpdate)
        
        NetworkingProvider.shared.updateUser(id: idReference!, user: userUpdate) { response in
            print(response)
        } failure: { error in
            print(error!)
        }
        
        print(userNameUpdate!)
        print(emailUpdate!)
        print(genderUpdate!)
        print(statusUpdate!)
    }
}
