//
//  NetworkService.swift
//  Avito-tech Test
//
//  Created by Vyacheslav Pronin on 11.11.2022.
//

import Foundation

enum NetworkServiceError: LocalizedError {
    case invalidURL
    case noNetwork
    case invalidData
    case noDownloadData
    
    var errorDescription: String {
        switch self {
        case .invalidURL:
            return "Не валидный адрес, возможно он уже не действителен"
        case .noNetwork:
            return "Ошибка скачивания данных, проверьте соединение с сетью"
        case .invalidData:
            return "Не валидные данные, попробуйте сделать запрос позже"
        case .noDownloadData:
            return "Данные не были загружены,\n потяните палец вниз"
        }
    }
}

final class NetworkService {
    
    //MARK: Private Properties
    private let url = URL(string: "https://run.mocky.io/v3/1d1cb4ec-73db-4762-8c4b-0b8aa3cecd4c")
    
    //MARK: Public Methods
    func getData(completion: @escaping (ModelData?, NetworkServiceError?) -> Void) {
        fetchData() { (data, error) in
            if let error = error {
                completion(nil, error)
            } else if let data = data {
                do {
                    var modelData = try JSONDecoder().decode(ModelData.self, from: data)
                    modelData.company.employees = modelData.company.employees.sorted(by: { $0.name < $1.name })
                    completion(modelData, nil)
                } catch {
                    completion(nil, NetworkServiceError.invalidData)
                }
            }
        }
    }
    
    //MARK: Private Methods
    private func fetchData(completion: @escaping (Data?, NetworkServiceError?) -> Void) {
        guard let url = url else { completion(nil, NetworkServiceError.invalidURL); return }
        
        let request = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if error != nil {
                completion(nil, NetworkServiceError.noNetwork)
            } else if let data = data {
                completion(data, nil)
            }
        }
        task.resume()
    }
}
