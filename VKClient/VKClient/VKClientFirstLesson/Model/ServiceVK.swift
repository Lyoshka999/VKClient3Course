//
//  ServiceVK.swift
//  VKClientFirstLesson
//
//  Created by Алексей on 25.06.2022.
//

import Foundation
import Alamofire
import RealmSwift

class ServiceVK {
    
    let session = SessionMyApp.instance
    
    let baseUrl = "https://api.vk.com"
    
    enum MethodsRequest: String {

        case users = "/method/friends.get"
        case photos = "/method/photos.getAll"
        case groups = "/method/groups.get"
        
        var parameters: [String: String] {
            switch self {
            case .users:
                return [
                    "access_token": SessionMyApp.instance.token,
                    "v": "5.131",
                    "fields": "photo_100",
                    "extended": "1",
                ]
            case .photos:
                return [
                    "access_token": SessionMyApp.instance.token,
                    "v": "5.131",
                    "type": "s"
                ]
            case .groups:
                return [
                    "access_token": SessionMyApp.instance.token,
                    "v": "5.131",
                    "fields": "photo_100",
                    "extended": "1"
                ]
            }
        }
        
    }

    
    func loadFriendsData(method: MethodsRequest, completion: @escaping () -> Void) {
        let path = method.rawValue
                let parameters: Parameters = method.parameters
                let url = baseUrl + path
        
        AF.request(url, method: .get, parameters: parameters).responseData { [weak self] response in
            switch response.result {
            case .success(let data):
                do {
                    let friends = try JSONDecoder().decode(Users.self, from: data).items
                    self?.saveToRealmFriends(friends)
                    completion()
                } catch {
                    print("Failed to decode")
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    
    private func saveToRealmFriends(_ friends: [User]) {

        do {
           // var configuration = Realm.Configuration.defaultConfiguration
           // configuration.deleteRealmIfMigrationNeeded = true
            let realm = try Realm()
          //  print(realm.configuration.fileURL)
            try realm.write {
                let oldFriends = realm.objects(User.self)
                realm.delete(oldFriends)
                realm.add(friends, update: .all)
            }
        } catch {
            print(error)
        }
    }
     
    
    
    
    func loadGroupsData(method: MethodsRequest, completion: @escaping ([Group]) -> Void) {
        let path = method.rawValue
                let parameters: Parameters = method.parameters
                let url = baseUrl + path
        
        AF.request(url, method: .get, parameters: parameters).responseData { [weak self] response in
            switch response.result {
            case .success(let data):
                do {
                    let groups = try JSONDecoder().decode(Groups.self, from: data).items
                    self?.saveToRealmGroups(groups)
                    completion(groups)
                } catch {
                    print("Failed to decode")
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func saveToRealmGroups(_ groups: [Group]) {
        do {
            var configuration = Realm.Configuration.defaultConfiguration
            configuration.deleteRealmIfMigrationNeeded = true
            let realm = try Realm()
            try realm.write({
                realm.add(groups)
            })
        } catch {
            print(error)
        }
    }

    
    func loadVKData(method: MethodsRequest, searchText: String, completion: @escaping ([DataJSON]) -> Void ) {
        let path = method.rawValue
        
        var parameters: Parameters = method.parameters
        parameters["q"] = searchText
        let url = baseUrl + path
        print(url)
        print(session.token, session.userId)
        
        AF.request(url, method: .get, parameters: parameters).responseData { response in
            switch response.result {
            case .success(let data):
                do {
                    let fromJSON = try JSONSerialization.jsonObject(with: data)
                  //  print(fromJSON)
                } catch {
                    print("Decoding error from data: \(data)")
                }
            case .failure(let error):
                print(error)
            }
        }
    }
   
    func autorisationVK() -> URLRequest {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "oauth.vk.com"
        urlComponents.path = "/authorize"
        urlComponents.queryItems = [
            URLQueryItem(name: "client_id", value: "8194844"),
            URLQueryItem(name: "display", value: "mobile"),
            URLQueryItem(name: "redirect_uri", value: "https://oauth.vk.com/blank.html"),
            URLQueryItem(name: "scope", value: "262150"),
            URLQueryItem(name: "response_type", value: "token"),
            URLQueryItem(name: "v", value: "5.131") ]
        let request = URLRequest(url: urlComponents.url!)
        return request
    }
}
