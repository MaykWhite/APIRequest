//
//  DetailViewController.swift
//  APIRequest
//
//  Created by Boris Blanco Caceres on 12/12/22.
//

/*  NOTA: Por las limitaciones de la API las funciones ADD, UPDATE, DELETE solo se puede observar por consola.
    NOTE: For the limitations of de API the ADD, UPDATE, DELETE functions can only be observed by console.
    Para la Eleminar un usuario solo debes mantener presionado el nombre de usuario que deseas eliminar.
    To delete an user you have only long press the username you want to delete. */

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var userLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var genderLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    
    var data: Displayable?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        commonInit()
    }
}

// MARK: - Extension
    extension DetailViewController {
        
        func commonInit() {
            guard let data = data else { return }
            
            idLabel.text = data.idTextLabel
            userLabel.text = data.nameTextLabel
            emailLabel.text = data.emailTextLabel
            genderLabel.text = data.genderTextLabel
            statusLabel.text = data.statusTextLabel
        }
        
        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            
            guard let editDestinationVC = segue.destination as? EditUserViewController else {
                return
            }
            editDestinationVC.editData = data
        }
    }
