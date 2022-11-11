//
//  MainTableViewCellProtocol.swift
//  Avito-tech Test
//
//  Created by Vyacheslav Pronin on 10.11.2022.
//

import Foundation

protocol MainTableIdentifiable {}

protocol MainTableSectionPresentable {
    var sections: [MainTableSectionRowPresentable] { get set }
}

protocol MainTableSectionRowPresentable {
    var titleName: String { get set }
    var rows: [MainTableIdentifiable] { get set }
}

protocol MainTableModelRepresentable {
    var viewModel: MainTableIdentifiable? { get set }
}
