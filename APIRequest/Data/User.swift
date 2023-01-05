//
//  User.swift
//  APIRequest
//
//  Created by Boris Blanco Caceres on 5/12/22.
//

/*  NOTA: Por las limitaciones de la API las funciones ADD, UPDATE, DELETE solo se puede observar por consola.
    NOTE: For the limitations of de API the ADD, UPDATE, DELETE functions can only be observed by console.
    Para la Eleminar un usuario solo debes mantener presionado el nombre de usuario que deseas eliminar.
    To delete an user you have only long press the username you want to delete. */

struct User: Decodable {
    let id: Int
    let name: String
    let email: String
    let gender: String
    let status: String
}

extension User: Displayable {
    var idTextLabel: String {
        "\(id)"
    }
    
    var nameTextLabel: String {
        name
    }
    
    var emailTextLabel: String {
        email
    }
    
    var genderTextLabel: String {
        gender
    }
    
    var statusTextLabel: String {
        status
    }
    
    
}
