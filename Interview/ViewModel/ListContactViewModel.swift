//
//  ListContactViewModel.swift
//  Interview
//
//  Created by Henrique Marques on 04/10/22.
//

import Foundation

/*
 
 Comece pelo próximo comentário, volte aqui depois.
 
 Criamos esse protocolo para lidar com o sucesso, ou error, como explicado anteriormente.
 
 */

protocol ListContactViewModelProtocols: AnyObject {
    func success()
    func failure()
}

/*
 
 Para começar, precisamos do conceito do que é uma ViewModel, basicamente, é uma classe separada da nossa View que lida com o objeto que irá popular a View.
 
 A ViewModel serve justamente como um mediador entre a Model e a View do nosso App.
 
 Isso implica em uma série de fatores, por exemplo, diferente do MVC, no MVVM a nossa View não pode acessar a Model de jeito nenhum.
 
 A nossa View também não faz a requisição para se popular, a ViewModel que faz por ela.
 
 */

class ListContactViewModel {
    
    // Aqui, estamos declarando um delegate para a nossa ViewModel que irá tratar se caso um erro ocorreu ou não, ao tentar realizar a requisição e passar os dados para a View. Volte no protocolo acima para entender melhor.
    
    weak var delegate: ListContactViewModelProtocols?
    
    // Aqui, declaramos o objeto que será utilizado para popular nossa TableView.
    var objc: [Datum] = []
    
    // Inicializamos a ViewModel com o nosso delegate para "obrigar" a View a assinar os métodos de sucesso, ou falha.
    init(delegate: ListContactViewModelProtocols? = nil) {
        self.delegate = delegate
    }
    
    // No método getData realizamos a requisição que tinhamos preparado anteriormente, na camanda de Service.
    func getData() {
        /*
         
         Basicamente, estamos vendo o resultado daquele completionHandler, que nos devolvia ou um erro, ou o objeto populado que usaremos para passar ao nosso objeto
         
         Além disso, se não tivessemos declarado nosso completionHandler como @escaping, não poderiamos realizar essa tarefa, pois como vemos o método está "vivendo fora de seu escopo", e agora podemos tratar os resultados.
         
         // Você pode estar confuso(a) sobre o termo "contacts", mas ele é o resultado da nossa requisição que está com os valores necessários. Como closures não tem nome, passamos o nome do parâmetro quando utilizamos.
         
         O termo [weak self] serve para evitar que essa closure cause um memory leak, ou vazamento de memória, que é quando uma parte da memória RAM do iphone fica alocada para sempre e não pode ser desalocada.
                  
         */
        
        ListContactService.sharedObjc.getContancts { [weak self] contacts, error in
            // Basico, caso ocorreu um erro na camada anterior, ao tentar realizar a requisição, estaremos jogando o erro para a camada acima (View) pelo delegate, avisando que algo deu errado.
            if error != nil {
                self?.delegate?.failure()
            } else {
                // Caso o método tenha sucedido, iremos alimentar o nosso objeto (objc) com os contatos vindos do método de requisição.
                self?.objc = contacts!
                self?.delegate?.success()
            }
        }
    }
    
    // Como estamos no ambiente MVVM, a nossa View não pode acessar o objeto para popular sua TableView, então preparamos dois métodos para popular a tableView sem que a View tenha contato direto com o objeto.
    
    var count: Int {
        return objc.count
    }
    
    func getIndex(indexPath: IndexPath) -> Datum {
        return objc[indexPath.row]
    }
    
    // Vamos para a ListContactController -> 
}
