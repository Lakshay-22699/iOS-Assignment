//
//  NetworkManager.swift
//  Navi-Problem-Statement
//
//  Created by Lakshay Saini on 11/05/22.
//

import Foundation

protocol NetworkManagerDelegate {
    func fetchedResult(_ result: [Results])
}

struct NetworkManager {
    var delegate: NetworkManagerDelegate?
    
    mutating func fetchData(_ index: Int) {
        var urlString = "https://api.github.com/repos/kyoheiG3/TableViewDragger/pulls?state="
        switch index {
        case 1:
            urlString += "closed"
        case 2:
            urlString += "open"
        default:
            urlString += "all"
        }
        performRequest(urlString: urlString)
    }
    
    func performRequest(urlString: String) {
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { data, _, error in
                if error != nil {
                    print(error!)
                    return
                }
                if let safeData = data {
                    if let result = self.parseJSON(data: safeData) {
                        delegate?.fetchedResult(result)
                    }
                }
            }
            task.resume()
        }
    }
    
    func parseJSON(data: Data) -> [Results]? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode([Results].self, from: data)
            return decodedData
        } catch {
            print(error)
            return nil
        }
    }
    
}
