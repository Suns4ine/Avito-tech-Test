//
//  MainPresenter.swift
//  Avito-tech Test
//
//  Created by Vyacheslav Pronin on 10.11.2022.
//  
//

import Foundation

final class MainPresenter {
    weak var view: MainViewInput?
    weak var moduleOutput: MainModuleOutput?
    
    private let router: MainRouterInput
    private let interactor: MainInteractorInput
    
    init(router: MainRouterInput, interactor: MainInteractorInput) {
        self.router = router
        self.interactor = interactor
    }
}

extension MainPresenter: MainModuleInput {}

extension MainPresenter: MainViewOutput {
    func setupData() {
        interactor.setupData()
    }
    
    func getData() {
        interactor.getData()
    }
}

extension MainPresenter: MainInteractorOutput {
    func returnStatusData(_ text: String) {
        DispatchQueue.main.async {
            self.view?.updateEmptyLabel(text)
        }
    }
    
    func dataDidRecieve(_ arr: [Company]) {
        let viewModel = MainTableViewModel()
        arr.forEach { viewModel.sections.append(MainTableSectionViewModel($0)) }
        DispatchQueue.main.async {
            self.view?.reloadData(for: viewModel)
        }
    }
}
