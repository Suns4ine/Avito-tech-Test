//
//  MainTableViewCell.swift
//  Avito-tech Test
//
//  Created by Vyacheslav Pronin on 10.11.2022.
//

import UIKit

final class MainTableCell: UITableViewCell {
    
    //MARK: Public Properties
    static let identifier = "MainTableViewCell"
    
    var viewModel: MainTableIdentifiable? {
         didSet {
             updateViews()
         }
     }
    
    //MARK: Private Properties
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        label.numberOfLines = 2
        label.textColor = .text
        return label
    }()
    
    private let phoneNumberLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        label.numberOfLines = 1
        label.textColor = .text
        return label
    }()
    
    private let skillsLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        label.numberOfLines = 0
        label.textColor = .text
        return label
    }()
    
    private let backgroundCellView: UIView = {
        let view = UIView()
        view.backgroundColor = .backgroundCell
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.shadowColor = UIColor.shadow.cgColor
        view.layer.borderColor = UIColor.shadow.cgColor
        view.layer.shadowOffset = CGSizeMake(5.0, 5.0)
        view.layer.cornerRadius = 10
        view.layer.shadowRadius = 2
        view.layer.shadowOpacity = 1
        view.layer.borderWidth = 3
        return view
    }()
    
    private let stackView: UIStackView = {
        let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.alignment = .leading
        view.axis = .vertical
        view.spacing = 10
        return view
    }()
    
    //MARK: Inits
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Private Methods
    private func setup() {
        self.backgroundColor = .clear
        
        addSubviewsInView()
        setupConstraint()
    }
    
    private func addSubviewsInView() {
        [nameLabel, phoneNumberLabel, skillsLabel].forEach { stackView.addArrangedSubview($0) }
        self.addSubview(backgroundCellView)
        backgroundCellView.addSubview(stackView)
    }
    
    private func setupConstraint() {
        let constant = CGFloat(10)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: backgroundCellView.topAnchor, constant: constant),
            stackView.leadingAnchor.constraint(equalTo: backgroundCellView.leadingAnchor, constant: constant),
            stackView.trailingAnchor.constraint(equalTo: backgroundCellView.trailingAnchor, constant: -constant),
            stackView.bottomAnchor.constraint(equalTo: backgroundCellView.bottomAnchor, constant: -constant),
            
            backgroundCellView.topAnchor.constraint(equalTo: self.topAnchor, constant: constant),
            backgroundCellView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: constant),
            backgroundCellView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -constant),
            backgroundCellView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -constant)
        ])
    }
    
    private func updateViews() {
        guard let viewModel = viewModel as? MainTableCellViewModel else { return }
        nameLabel.text = viewModel.name
        phoneNumberLabel.text = viewModel.phoneNumber
        skillsLabel.text = viewModel.skills
    }
}
