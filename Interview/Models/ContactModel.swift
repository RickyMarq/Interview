//
//  Contact.swift
//  Interview
//
//  Created by Henrique Marques on 04/10/22.
//

import Foundation

/* E sempre recomendável que você comece um projeto pela sua model de classes que o seu app irá usar.

 Sempre usem esse flow de construção: Model -> Service -> ViewModel -> View

 Aqui, as classes estão organizadas dessa maneira para suportar a obtenção de dados vindos da API.
 
 Se você não seguir, provavelmente ele irá conseguir realizar a requisição, mas não consiguirá colocar os dados nas classes para formar os objetos.

*/

struct Contact: Codable {
    let data: [Datum]
}

struct Datum: Codable {
    let firstName: String?
    let lastName: String?
    let picture: String?
    
    /*
     
     CodingKeys servem basicamente para substituir o nome que será usado para as variáveis, para evitar redundância de nomes. Ou para resolver problemas como APIs que pedem por exemplo, Primeiro_Nome no corpo de sua API. O Swift não permite que você declare uma variável como let primeiro_nome, então você declara como let PrimeiroNome: String e usa coding keys para passar o valor que a API pede, ou seja:
     
     case PrimeiroNome = "Primeiro_Nome"
     
     Caso queira um exemplo real:
     
     Link: https://api.punkapi.com/v2/beers
     
     Caso não esteja conseguindo ver a API corretamente, recomendo que instale essa extensão:
     
     Extensão Visualizador de API: https://chrome.google.com/webstore/detail/json-viewer/gbmdgpbipfallnflgajpaliibnhdgobh?hl=pt-BR
     
     Por exemplo, o atribuito image_url não é possível de acessar sem utilizar o CodingKeys como explicado anteriormente.
    
    Vamos para a camada de Serive ->
     
     */
    
    enum CodingKeys: String, CodingKey {
        case firstName
        case lastName
        case picture
    }
}
