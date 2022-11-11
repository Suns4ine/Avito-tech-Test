//
//  MainViewController.swift
//  Avito-tech Test
//
//  Created by Vyacheslav Pronin on 10.11.2022.
//  
//

import UIKit

final class MainViewController: UIViewController {
    
    //MARK: Private Properties
    private let output: MainViewOutput
    private var tableViewModel: MainTableSectionPresentable = MainTableViewModel() {
        didSet {
            emptyLabel.isHidden = tableViewModel.sections.isEmpty ? false : true
        }
    }
    
    private let emptyLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.isUserInteractionEnabled = false
        label.font = UIFont.systemFont(ofSize: 40, weight: .medium)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = .text
        return label
    }()
    
    private let tableView: UITableView = {
        let table = UITableView()
        table.backgroundColor = .clear
        table.tableFooterView = UIView()
        table.separatorStyle = .none
        table.showsVerticalScrollIndicator = false
        table.translatesAutoresizingMaskIntoConstraints = false
        table.allowsSelection = false
        table.sectionHeaderHeight = 35
        return table
    }()
    
    private let refreshControl: UIRefreshControl = {
        let refresh = UIRefreshControl()
        refresh.addTarget(self, action: #selector(refreshControlUpdate), for: .valueChanged)
        return refresh
    }()
    
    //MARK: Inits
    init(output: MainViewOutput) {
        self.output = output
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .backgroundController
        
        output.setupData()
        setupTableView()
        addSubviewsInView()
        setupConstraint()
        addSubviewsInView()
    }
    
    //MARK: Private Methods
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(MainTableCell.self, forCellReuseIdentifier: MainTableCell.identifier)
    }
    
    private func addSubviewsInView() {
        view.addSubview(tableView)
        view.addSubview(emptyLabel)
        tableView.addSubview(refreshControl)
    }
    
    private func setupConstraint() {
        let constant: CGFloat = isDeviceIPad() ? 100 : 10
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: constant/8),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: constant),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -constant),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -constant/8),
            
            emptyLabel.topAnchor.constraint(equalTo: refreshControl.bottomAnchor, constant: 44),
            emptyLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            emptyLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24)
        ])
    }
    
    @objc
    private func refreshControlUpdate() {
        output.getData()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 15.0) {
            self.refreshControl.endRefreshing()
        }
    }
}

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableViewModel.sections[section].rows.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return tableViewModel.sections.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let viewModel = tableViewModel.sections[indexPath.section].rows[indexPath.row]
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MainTableCell.identifier,
                                                       for: indexPath) as? MainTableCell else { return .init() }
        
        cell.viewModel = viewModel
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = HeaderView()
        headerView.updateText(tableViewModel.sections[section].titleName)
        return headerView
    }
}

extension MainViewController: MainViewInput {
    func updateEmptyLabel(_ text: String) {
        emptyLabel.text = text
        refreshControl.endRefreshing()
    }
    
    func reloadData(for viewModel: MainTableViewModel) {
        tableViewModel = viewModel
        tableView.reloadData()
        refreshControl.endRefreshing()
    }
}
