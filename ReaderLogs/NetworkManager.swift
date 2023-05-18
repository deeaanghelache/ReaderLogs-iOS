//
//  NetworkManager.swift
//  ReaderLogs
//
//  Created by Maria Duțu on 03.04.2023.
//


import Foundation

class NetworkManager {

    private let baseURL = "https://www.googleapis.com/books/v1/volumes"
    
    func getURLForBooks(word: String) -> URL? {
       guard var urlComponents = URLComponents(string: baseURL) else {
           return nil
       }
       
       let searchQueryItem = URLQueryItem(name: "q", value: word)
       urlComponents.queryItems = [searchQueryItem]
       
       return urlComponents.url
    }

    func fetchBooks(_ word: String, _ cb: @escaping (_ results: [GoogleBookModel]) -> Void) {
        guard let url = getURLForBooks(word: word) else {
            return
        }

        var urlRequest = URLRequest(url: url)
        urlRequest.addValue(String(ApiKey.value), forHTTPHeaderField: String(ApiKey.key))
        urlRequest.httpMethod = "GET"
        
        print("""
             \n--------------------------------------------------------------
             Request: \(url.absoluteString)
             Methode: \(urlRequest.httpMethod ?? "N/A")
             ----------------------------------------------------------------\n
             """)
        
        let dataTask = URLSession.shared.dataTask(with: urlRequest) { responseData, urlResponse, error in

            if let error = error {
                print("Request failed due to: \(error.localizedDescription)")
                return
            }
            
            guard let httpUrlResponse = urlResponse as? HTTPURLResponse,
                  let data = responseData,
                  let responseString = String(data: data, encoding: String.Encoding.utf8) else {
                print("No data received or response is not HTTP response")
                return
            }

            print("""
                 \n--------------------------------------------------------------
                 Response for: \(url.absoluteString)
                 Staatus code: \(httpUrlResponse.statusCode)
                 Body:\n\(responseString)
                 ----------------------------------------------------------------\n
                 """)
            
            DispatchQueue.main.async {

                do {
                    let bookResponse = try JSONDecoder().decode(GoogleBookResponse.self, from: data)
                    cb(bookResponse.items)
                } catch {
                    print("Failed to deserialize json data")
                }
            }
        }

        dataTask.resume()
    }
}
