//
//  ViewController.swift
//  Interview
//
//  Created by Henrique Marques on 04/10/22.
//

import UIKit

class ListContactController: UIViewController {
    
    var listContactScreen: ListContactScreen?
    // Bom, aqui nós devemos instaciar nossa ViewModel respectiva.
    var viewModel: ListContactViewModel?
    
    override func loadView() {
        self.listContactScreen = ListContactScreen()
        self.view = listContactScreen
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.listContactScreen?.configTableViewProtocols(delegate: self, dataSource: self)
        // Criamos a variável e assinamos o delegate da ViewModel, que fizemos anteriormente.
        // Desça até o final da classe, lá nós tratamos o método de sucesso e falha.
        self.viewModel = ListContactViewModel(delegate: self)
        self.setUpNavigationController()
        self.getDataFromViewModel()
    }
    
    // Aqui, nós acessamos o método para realizar a requisição e popular o objeto.
    func getDataFromViewModel() {
        self.viewModel?.getData()
    }
    
    private func setUpNavigationController() {
        self.title = "Interview"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
    }
        
}

extension ListContactController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Como nós não podemos acessar a model para popular a tableView, usamos os métodos que criamos lá na ViewModel para fazer isso.
        return self.viewModel!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: ContactCell? = tableView.dequeueReusableCell(withIdentifier: ContactCell.identifier, for: indexPath) as? ContactCell
        // Aqui que chegamos no momento de dar uma olhada na outra viewModel. Por nossa célula tambem ser um View, temos que criar uma ViewModel para ela também.
        
        // Vá para ContactCellViewModel -> 
        cell?.prepareCell(model: (self.viewModel?.getIndex(indexPath: indexPath))!)
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
}

// Por conformar com o delegate, temos que aplicar o seus métodos.

extension ListContactController: ListContactViewModelProtocols {
    
    func success() {
        // No caso de sucesso, nós damos reload na tableView para ela se atualizar.
        DispatchQueue.main.async {
            self.listContactScreen?.tableView.reloadData()
            self.listContactScreen?.activity.stopAnimating()
        }
    }
    
    func failure() {
        print("Error")
    }
    
    
}
