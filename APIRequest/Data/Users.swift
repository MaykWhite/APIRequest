//
//  Users.swift
//  APIRequest
//
//  Created by Boris Blanco Caceres on 5/12/22.
//

/*  NOTA: Por las limitaciones de la API las funciones ADD, UPDATE, DELETE solo se puede observar por consola.
    NOTE: For the limitations of de API the ADD, UPDATE, DELETE functions can only be observed by console.
    Para la Eleminar un usuario solo debes mantener presionado el nombre de usuario que deseas eliminar.
    To delete an user you have only long press the username you want to delete. */

struct Users: Decodable {
    let meta: Meta
    let all: [User]
    
    enum CodingKeys: String, CodingKey {
        case meta
        case all = "data"
    }
}

struct Meta: Decodable {
}

struct UserToAdd: Decodable {
    let meta: Meta
    let all: User
    
    enum CodingKeys: String, CodingKey {
        case meta
        case all = "data"
    }
}
