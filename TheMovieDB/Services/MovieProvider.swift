//
//  MovieProvider.swift
//  TheMovieDB
//
//  Created by ibrahim on 25/07/20.
//  Copyright © 2020 ibrahim. All rights reserved.
//

import Foundation

public class MovieProvider: MovieService {
    
    public static let shared = MovieProvider()
    private init() {}
    
    // get api key and base url from user defined setting
    private let baseUrl = "https://api.themoviedb.org/3"
    private let apiKey = "ae7267467a0d6f00ec648b7dd3e93b32"
    
    private let urlSession = URLSession.shared
    
    private let jsonDecoder: JSONDecoder = {
        let jsonDecoder = JSONDecoder()
        jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-mm-dd"
        jsonDecoder.dateDecodingStrategy = .formatted(dateFormatter)
        return jsonDecoder
    }()
    
    func list(endpoint: MovieEndpoint, params: [String : String]?, onSuccess: @escaping (MovieResponse) -> Void, onError: @escaping (Error) -> Void) {
        self.handeRequest(requestedObjectType: MovieResponse.self, endpoint: "/movie/\(endpoint.rawValue)", params: params, onSuccess: onSuccess, onError: onError)
    }
    
    func detail(id: Int, params: [String : String]?, onSuccess: @escaping (MovieDetailResponse) -> Void, onError: @escaping (Error) -> Void) {
        self.handeRequest(requestedObjectType: MovieDetailResponse.self, endpoint: "/movie/\(id)", params: params, onSuccess: onSuccess, onError: onError)
    }
    
    func review(id: Int, params: [String : String]?, onSuccess: @escaping (ReviewResponse) -> Void, onError: @escaping (Error) -> Void) {
        self.handeRequest(requestedObjectType: ReviewResponse.self, endpoint: "/movie/\(id)/reviews", params: params, onSuccess: onSuccess, onError: onError)
    }
    
    // function for handling api Request with generic type, so it can always be used later
    private func handeRequest<T:Codable>(requestedObjectType:T.Type, endpoint: String, params: [String : String]?, onSuccess: @escaping (T) -> Void, onError: @escaping (Error) -> Void){
        
        guard var urlComponents = URLComponents(string: "\(self.baseUrl)\(endpoint)") else {
            onError(MovieError.invalidEndpoint)
            return
        }
        
        var queryItems = [URLQueryItem(name: "api_key", value: apiKey)]
        if let params = params {
            queryItems.append(contentsOf: params.map { URLQueryItem(name: $0.key, value: $0.value) })
        }
        
        urlComponents.queryItems = queryItems
        
        guard let url = urlComponents.url else {
            onError(MovieError.invalidEndpoint)
            return
        }
        
        urlSession.dataTask(with: url) { (data, response, error) in
            if error != nil {
                self.errorHandler(onErrorCallback: onError, error: MovieError.errorFromApi)
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, 200..<300 ~= httpResponse.statusCode else {
                self.errorHandler(onErrorCallback: onError, error: MovieError.invalidResponse)
                return
            }
            
            guard let data = data else {
                self.errorHandler(onErrorCallback: onError, error: MovieError.noData)
                return
            }
            
            do {
                
                let response = try self.jsonDecoder.decode(T.self, from: data)
                DispatchQueue.main.async {
                    onSuccess(response)
                }
            } catch let DecodingError.dataCorrupted(context) {
                   print(context)
               } catch let DecodingError.keyNotFound(key, context) {
                   print("Key '\(key)' not found:", context.debugDescription)
                   print("codingPath:", context.codingPath)
               } catch let DecodingError.valueNotFound(value, context) {
                   print("Value '\(value)' not found:", context.debugDescription)
                   print("codingPath:", context.codingPath)
               } catch let DecodingError.typeMismatch(type, context)  {
                   print("Type '\(type)' mismatch:", context.debugDescription)
                   print("codingPath:", context.codingPath)
               } catch {
                   print("error: ", error)
               }
            }.resume()
    }
    
    // handle error here
    private func errorHandler(onErrorCallback: @escaping(_ error: Error) -> Void, error: Error) {
        DispatchQueue.main.async {
            onErrorCallback(error)
        }
    }
    
}
