//
//  NetworkingProvider.swift
//  APIRequest
//
//  Created by Boris Blanco Caceres on 5/12/22.

/*  NOTA: Por las limitaciones de la API las funciones ADD, UPDATE, DELETE solo se puede observar por consola.
    NOTE: For the limitations of de API the ADD, UPDATE, DELETE functions can only be observed by console.
    Para la Eleminar un usuario solo debes mantener presionado el nombre de usuario que deseas eliminar.
    To delete an user you have only long press the username you want to delete. */

import UIKit
import Alamofire

class NetworkingProvider: UITableViewController {
    static let shared = NetworkingProvider()
    var items: [Displayable] = []
    var selectedItem: Displayable?
    var users: [User] = []
    let token = "ea04ad2814fe074484adbc6772036670c1930b077fb5148b00b2c8c03bfb4a79"
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        getUser()
        
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress(sender:)))
        tableView.addGestureRecognizer(longPress)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //print(items.count)
        return items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "dataCell", for: indexPath)
        let item = items[indexPath.row]
        cell.textLabel?.text = item.nameTextLabel
        return cell
    }
    
    override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        selectedItem = items[indexPath.row]
        return indexPath
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destinationVC = segue.destination as? DetailViewController else { return }
        destinationVC.data = selectedItem
    }
    
    @objc private func handleLongPress(sender: UILongPressGestureRecognizer) {

        let idToDelete = Int(selectedItem!.idTextLabel)!
        
        if sender.state == .began {
            
            let touchPoint = sender.location(in: tableView)
            if let indexPath = tableView.indexPathForRow(at: touchPoint) {
                let menuDeleteEdit = UIAlertController(title: "Delete", message: "Dou you want delete this item?", preferredStyle: .alert)
                menuDeleteEdit.addAction(UIAlertAction(title: "Yes", style: .default, handler: {_ in
                    self.deleteUser(id: idToDelete) {
                    } failure: { (error) in }
                    print("Delete succes!")}))
                present(menuDeleteEdit, animated: true, completion: nil)
                print(indexPath)
            }
        }
        
        if sender.state == .ended {
            tableView.reloadData()
        }
    }
}

// MARK: - UISearchBarDelegate
extension NetworkingProvider: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let name = searchBar.text else { return }
        searchUser(for: name)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = nil
        searchBar.resignFirstResponder()
        items = users
        tableView.reloadData()
    }
}

// MARK: - Alamofire

extension NetworkingProvider {
    
    func getUser() {
        AF.request("https://gorest.co.in/public/v1/users")
            .validate(statusCode: 200...299)
            .responseDecodable(of: Users.self) { (response) in
                guard let usuarios = response.value else { return }
                self.users = usuarios.all
                self.items = usuarios.all
                self.tableView.reloadData()
                print(usuarios.all)
            }
    }
    
    func addUser(user: NewUser, succes: @escaping (_ user: UserToAdd) -> (), failure: @escaping (_ error: Error?) -> ()) {
        let headers: HTTPHeaders = [.authorization(bearerToken: token)]
        AF.request("https://gorest.co.in/public/v1/users", method: .post, parameters: user, encoder: JSONParameterEncoder.default, headers: headers).validate().responseDecodable(of: UserToAdd.self) {
            response in
            
            print(response.debugDescription)
            
            if let userResponse = response.value {
                succes(userResponse)
            } else {
                failure(response.error)
            }
        }
        
    }
    
    func updateUser(id: Int, user: NewUser, succes: @escaping (_ user: UserToAdd) -> (), failure: @escaping (_ error: Error?) -> ()) {
        let headers: HTTPHeaders = [.authorization(bearerToken: token)]
        AF.request("https://gorest.co.in/public/v1/users/\(id)", method: .put, parameters: user, encoder:  JSONParameterEncoder.default, headers: headers).validate().responseDecodable(of: UserToAdd.self) {
            response in
            
            print(response.debugDescription)
            
            if let userResponse = response.value {
                succes(userResponse)
            } else {
                failure(response.error)
            }
        }
    }
    
    func deleteUser(id: Int, succes: @escaping () -> (), failure: @escaping (_ error: Error?) -> ()) {
        let headers: HTTPHeaders = [.authorization(bearerToken: token)]
        AF.request("https://gorest.co.in/public/v1/users/\(id)", method: .delete, headers: headers).validate().response {
            response in
            
            if let error = response.error {
                failure(error)
            } else {
                succes()
            }
        }
    }
    
    func searchUser(for name: String) {
        let parameters: [String: String] = ["search" : name]
        AF.request("https://gorest.co.in/public/v1/users", parameters: parameters).validate()
            .responseDecodable(of: Users.self) { response in
                guard let usuario = response.value else { return }
                self.items = usuario.all
                self.tableView.reloadData()
                print(usuario.all)
            }
    }
}
