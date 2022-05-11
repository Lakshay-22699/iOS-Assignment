//
//  DetailsViewModel.swift
//  Navi-Problem-Statement
//
//  Created by Lakshay Saini on 11/05/22.
//

import Foundation

protocol DetailsViewDelegate {
    func fetchedData(_ data: [Section])
}

class DetailsViewModel {
    private var networkManager = NetworkManager()
    private var data: [Section] = []
    
    var delegate: DetailsViewDelegate?
    
    func searchPullRequests(_ index: Int) {
        networkManager.delegate = self
        networkManager.fetchData(index)
    }
    
}

// MARK: - Network Manager Delegate
extension DetailsViewModel: NetworkManagerDelegate {
    func fetchedResult(_ result: [Results]) {
//        print(result.count)
//        print(result.description)
        if !data.isEmpty {
            data = []
        }
        for result in result {
            let section = Section(result: result)
            data.append(section)
        }
        
        delegate?.fetchedData(data)
    }
}
