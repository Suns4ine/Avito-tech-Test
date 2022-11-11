//
//  MainProtocols.swift
//  Avito-tech Test
//
//  Created by Vyacheslav Pronin on 10.11.2022.
//  
//

import Foundation

protocol MainModuleInput {
	var moduleOutput: MainModuleOutput? { get }
}

protocol MainModuleOutput: AnyObject {}

protocol MainViewInput: AnyObject {
    func updateEmptyLabel(_ text: String)
    func reloadData(for viewModel: MainTableViewModel)
}

protocol MainViewOutput: AnyObject {
    func getData()
    func setupData()
}

protocol MainInteractorInput: AnyObject {
    func getData()
    func setupData()
}

protocol MainInteractorOutput: AnyObject {
    func dataDidRecieve(_ arr: [Company])
    func returnStatusData(_ text: String)
}

protocol MainRouterInput: AnyObject {}
