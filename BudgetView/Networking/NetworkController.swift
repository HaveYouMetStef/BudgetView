//
//  NetworkController.swift
//  BudgetView
//
//  Created by Stef Castillo on 3/11/23.
//

import Foundation

///Object to manage api calls
class APICaller {
    
    ///Singleton
    public static let shared = APICaller()
    
    //MARK: - Constants
    private struct Constants {
        static let apiKey = "cfqjagpr01qigsfjtkp0cfqjagpr01qigsfjtkpg"
        static let baseURL = "https://finnhub.io/api/v1/"
        static let day: TimeInterval = 3600 * 24
    }
    
    ///private constructor
    private init() {}
    
    //MARK: - Public
    
    /*Search for a company
     Parameters:
     -query: Query String (symbol or name)
     -completion: Callback for result */
    public func search(
        query: String,
        completion: @escaping (Result<SearchResponse, Error>) -> Void) {
            
            guard let safeSearch = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else { return }
                        request(
                            url: url(
                                for: .search,
                                queryParams: ["q" : safeSearch]
                            ),
                            expecting: SearchResponse.self,
                            completion: completion
                        )
        }
    
    /* Get stock data
     -Parameters:
        symbol:
        completion:
     */
    public func stockPrice(
        for symbol: String,
        completion: @escaping (Result<QuoteServerModel, Error>) -> Void
    ) {
        print(symbol)
        print(url(for: .stockPrice, queryParams: ["symbol" : symbol]))
        request(url: url(
                        for: .stockPrice,
                        queryParams: ["symbol": symbol]),
                expecting: QuoteServerModel.self,
                completion: completion)
        
    }
        
    
    //MARK: - Private
    
    ///API Endpoints
    private enum Endpoints: String {
        case search
        case stockPrice = "quote"
    }
    
    ///API Errors
    private enum APIError: Error {
        case noDataReturned
        case InvalidURL
    }
    
    private func url(for endpoint: Endpoints,
                     queryParams: [String: String] = [:]
    ) -> URL? {
        var urlString = Constants.baseURL + endpoint.rawValue
        var queryItems = [URLQueryItem]()
        
        //Add any parameters
        for (name, value) in queryParams {
            queryItems.append(.init(name: name, value: value))
        }
        //Add your token
        queryItems.append(.init(name: "token", value: Constants.apiKey))
        
        //Converting your query items to suffix string
        urlString += "?" + queryItems.map { "\($0.name)=\($0.value ?? "")"}.joined(separator: "&")
        print(urlString)
        return URL(string: urlString)
    }
    
    ///Perform api call
    private func request<T: Codable> (
        url: URL?,
        expecting: T.Type,
        completion: @escaping (Result<T, Error>) -> Void
    ) {
        guard let url = url else {
            completion(.failure(APIError.InvalidURL))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data , _ , error in
            guard let data = data, error == nil else {
                if let error = error {
                    completion(.failure(error))
                } else {
                    completion(.failure((APIError.noDataReturned)))
                }
                return
            }
            do {
                let result = try JSONDecoder().decode(expecting, from: data)
                completion(.success(result))
            }
            catch {
                completion(.failure(error))
            }
        }
        task.resume()
        
    }
}
