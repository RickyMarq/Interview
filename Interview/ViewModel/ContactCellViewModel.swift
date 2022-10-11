//
//  ContactCellViewModel.swift
//  Interview
//
//  Created by Henrique Marques on 04/10/22.
//

import Foundation

class ContactCellViewModel {
    
    /* Por se tratar de uma ViewModel de uma célula, ela é bem mais simples comparada com a de uma "view normal"
    
     O objetivo é o mesmo, preparar os dados para a view.
     
     */
    
    // Inicializamos a classe com o objeto para que futuramente podemos preenche-la com o nosso objeto populado que vem da ListContactViewModel.
    
    var objc: Datum
    
    init(objc: Datum) {
        self.objc = objc
    }
    
    // Criamos closures porque não necessitamos passar parâmetros, apenas preparar o valor para a View.
    
    var contactImage: String {
        return self.objc.picture ?? "Error"
    }
    
    var contactFirstName: String {
        return self.objc.firstName ?? "Error"
    }
    
    var contactLastName: String {
        return self.objc.lastName ?? "Error"
    }
    
    // Vamos para a ContactCell -> 
    
}
