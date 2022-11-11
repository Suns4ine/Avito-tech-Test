//
//  MainTableViewCellViewModel.swift
//  Avito-tech Test
//
//  Created by Vyacheslav Pronin on 10.11.2022.
//

import Foundation

final class MainTableViewModel: MainTableSectionPresentable {
    var sections: [MainTableSectionRowPresentable] = []
}

final class MainTableSectionViewModel: MainTableSectionRowPresentable {
    var titleName: String = ""
    var rows: [MainTableIdentifiable] = []
    
    init(_ model: Company) {
        self.titleName = "Company: " + model.name
        model.employees.forEach { self.rows.append(MainTableCellViewModel($0)) }
    }
}

final class MainTableCellViewModel: MainTableIdentifiable {
    let name: String
    let phoneNumber: String
    let skills: String
    
    init(_ model: Employee) {
        self.name = "Name: " + model.name
        self.phoneNumber = "Phone Number: " + model.phoneNumber
        self.skills = "Skills: " + model.skills.joined(separator: ", ")
    }
}
