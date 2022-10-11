//
//  ListContactScreen.swift
//  Interview
//
//  Created by Henrique Marques on 04/10/22.
//

import UIKit

class ListContactScreen: UIView {
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundView = activity
        tableView.register(ContactCell.self, forCellReuseIdentifier: ContactCell.identifier)
        return tableView
    }()
    
    lazy var activity: UIActivityIndicatorView = {
        let activity = UIActivityIndicatorView()
        activity.translatesAutoresizingMaskIntoConstraints = false
        activity.hidesWhenStopped = true
        activity.startAnimating()
        return activity
    }()
    
    public func configTableViewProtocols(delegate: UITableViewDelegate, dataSource: UITableViewDataSource) {
        self.tableView.delegate = delegate
        self.tableView.dataSource = dataSource
    }
    
    private func setUpUIElements() {
        self.addSubview(self.tableView)
    }
    
    private func setUpUIConstraints() {
        self.configTableViewConstraints()
        self.configActivityConstraints()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setUpUIElements()
        self.setUpUIConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func configTableViewConstraints() {
        NSLayoutConstraint.activate([
        
            self.tableView.topAnchor.constraint(equalTo: self.topAnchor),
            self.tableView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.tableView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.tableView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
    
    private func configActivityConstraints() {
        NSLayoutConstraint.activate([
        
            self.activity.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            self.activity.centerYAnchor.constraint(equalTo: self.centerYAnchor),
        
        ])
    }
}
