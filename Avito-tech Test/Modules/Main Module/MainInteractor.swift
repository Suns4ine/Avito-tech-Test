//
//  MainInteractor.swift
//  Avito-tech Test
//
//  Created by Vyacheslav Pronin on 10.11.2022.
//  
//

import Foundation

final class MainInteractor {
    
    //MARK: Public Properties
    weak var output: MainInteractorOutput?
    static let keyCache = "MainInteractorKeyCache"
    
    //MARK: Private Properties
    private var cache = Cache<String, [Company]>()
    private let networkService = NetworkService()
    private var arrayData: [Company] = [] {
        didSet {
            output?.dataDidRecieve(self.arrayData)
        }
    }
    
    private func updateCache() {
        self.cache[MainInteractor.keyCache] = arrayData
        try? self.cache.saveToDisk(withName: MainInteractor.keyCache)
    }
}

extension MainInteractor: MainInteractorInput {
    func setupData() {
        if let cahce = try? Cache<String, [Company]>.readToDisk(withName: MainInteractor.keyCache),
           let arrayData = cahce[MainInteractor.keyCache] {
            self.cache = cahce
            self.arrayData = arrayData
        } else {
            getData()
        }
    }
    
    func getData() {
        if let cached = cache[MainInteractor.keyCache] {
            arrayData = cached
        } else {
            networkService.getData() { [weak self] (data, error) in
                guard let self = self else { return }
                
                if let error = error {
                    self.output?.returnStatusData(error.errorDescription)
                } else if let data = data {
                    self.arrayData = [data.company]
                    self.updateCache()
                }
            }
        }
    }
}
