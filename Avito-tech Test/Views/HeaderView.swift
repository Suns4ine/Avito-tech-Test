//
//  HeaderView.swift
//  Avito-tech Test
//
//  Created by Vyacheslav Pronin on 11.11.2022.
//

import UIKit

final class HeaderView: UIView {
    
    //MARK: Private Properties
    private let textLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 22, weight: .bold)
        label.textColor = .text
        return label
    }()
    
    //MARK: Inits
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Public Methods
    func updateText(_ text: String) {
        textLabel.text = text
    }
    
    //MARK: Private Methods
    private func setup() {
        [textLabel].forEach { addSubview($0) }
        self.backgroundColor = .backgroundController
    }
}
