//
//  AlamofireManager.swift
//  IMDBProject
//
//  Created by Yakup Demir on 15.04.2022.
//

import Alamofire
import Foundation


protocol RestApiProtocol {
    associatedtype T

    func getAllData(servicePath: URLConvertible, onSuccess: @escaping (T) -> Void, onFail: @escaping (String?) -> Void)
    func postData(servicePath: URLConvertible, parameters: Parameters?, onSuccess: @escaping (T) -> Void, onFail: @escaping (String?) -> Void)
}

class AlamofireManager<T: Codable>: RestApiProtocol {
    func postData(servicePath: URLConvertible, parameters: Parameters? = nil, onSuccess: @escaping (T) -> Void, onFail: @escaping (String?) -> Void) {
        let encoding: ParameterEncoding = JSONEncoding.default
        let headers: HTTPHeaders = ["Content-type": "application/json; charset=UTF-8"]

        AF.request(servicePath, method: .post, parameters: parameters, encoding: encoding, headers: headers).responseDecodable(of: T.self) { response in

            guard let item = response.value else {
                onFail("Post Error -> \(response.debugDescription)")
                return
            }

            onSuccess(item)
        }
    }

    func getAllData(servicePath: URLConvertible, onSuccess: @escaping (T) -> Void, onFail: @escaping (String?) -> Void) {
        AF.request(servicePath, method: .get).responseDecodable(of: T.self) { response in

            guard let items = response.value else {
                onFail("Get Error -> \(response.debugDescription)")
                return
            }
            onSuccess(items)
        }
    }
}
