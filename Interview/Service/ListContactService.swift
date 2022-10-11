//
//  ListContactService.swift
//  Interview
//
//  Created by Henrique Marques on 04/10/22.
//

import Foundation

class ListContactService {
    
    static let sharedObjc = ListContactService()
    
    private init() { }
    
    /* Essa camada de Service é um singleton, caso não saiba o que é, recomendo esse artigo em pt-br.
    
    
    */
    
    /*
     
     Aqui, temos o método que irá realizar a requisição, vamos destrichá-lo linha por linha.
     
     Na primeira linha, temos a declaração do método com seu nome, após isso temos algo chamado de CompletionHadler, que em uma breve explicação é outro
        método que é chamado quando uma tarefa principal é completada realizando a tarefa do método do competionHandler. Usamos em situações como essa, pois uma requisição pode ter diversos resultados diferentes.
     
     Dentro do CompletionHandler, estamos declarando uma Closure, que são de métodos que podem ser passados pelo código, ele segue o mesmo "padrão" de um método normal, que pode passar parâmetros e retornos.
     
     A palavra @escaping significa que os resultados dessa closure irão ser utilizados fora do escopo do método, isso permite que podemos tratar os resultados lá na ViewModel e popular o nosso objeto com os dados do resultado da requisição.
     
     A sintaxe de um método com um completionHandler que passa uma closure é assim
     
     func testeCompletion(completion: ( Parâmetros da Closure ) -> ( O que e closure retorna )) {
     
     }
     
     Sim, são duas tuplas vazias, que basicamente declaramos o possíveis resultados, nesse caso, ou é entregue uma array de [Datum] populada com a requisição, ou um erro.
     
     Você pode estar confuso sobre o Void, mas ele é basicamente um typelias (TypeAlias: Outro nome para algo já existente) de (), () = Tupla Vazia.
     
     Ou seja, a closure retorna um vazio.
     
     Esse conceito é extremamente complexo e chato, por isso recomendo o seguinte link:
     
     [Inglês] Vídeo Explicado o conceito: https://www.youtube.com/watch?v=JmPbnuJxzHg&ab_channel=StewartLynch
     
     
     */
        
    
    func getContancts(completion: @escaping ([Datum]?, Error?) -> Void) {
        
        // Aqui nessa linha, estamos declarando o link da API que estamos usando.
        guard let url = URL(string: "https://dummyapi.io/data/v1/user?limit=10") else {return}
        // 2 linhas abaixo, estamos declarando as variáveis necessárias para realizar a requisição.
        let session = URLSession.shared
        var request = URLRequest(url: url)
        // A linha httpMethod não é extremamente necessária, eu (Henrique), apenas declaro para deixar claro qual método de http estamos fazendo, mas ele não é neccesário.
        request.httpMethod = "GET"
        
        /* A linha request.setValue, é especial, pois em algumas APIs, (A maioria), teremos que declarar um token, e ou passar dados para conseguir realizar os métodos de http com sucesso.
         
         Nesse caso, eu tive que gerar esse token e adicioná-lo ao valor app-id do cabeçalho, normalmente, as APIs tem uma documentação que irá explicar cada parâmetro para realizar a requisição.
         
         Mas fica minha dica, use o Postman para testar para ver se a requisição foi feita com sucesso, e só após isso tente fazer no Swift.
         
         Mas, é assim que se declara o valor de um "httpHeaderField", caso não saiba esse conceito, eu recomendo esse artigo:
         
         Link; http://gabsferreira.com/o-que-e-o-http-como-funciona-request-respose/
         
         */
        request.setValue("633ba705727aa8cefd35e832", forHTTPHeaderField: "app-id")
        
        // Aqui, estamos declarando a tarefa que irá realizar o método com as configurações que declaramos anteriormente.
        let task = session.dataTask(with: request) { data, response, error in
            guard let data = data else {return}
            do {
                // Nas 3 linhas abaixo, realizando a tarefa que "decodar" os valores vindo das requisição, eles vieram no formato json, e estamos passado cada valor para os atributos das classes que criamos anteriormente.
                let decoder = JSONDecoder()
                let model = try decoder.decode(Contact.self, from: data)
                // Na linha abaixo que está a mágica, estamos chamando o nosso completion, declarando que se o método chegou nesse ponto, nos devolva a array populada e um nil, que é "vazio", pois nenhum erro ocorreu.
                completion(model.data, nil)
            } catch {
                print("Error")
                // Aqui temos o inverso, o nosso método anterior falhou em tentar atribuir os valores do json para as nossas clasees, e nos devolver um nil (que era para ser nossa classe populada) e um erro.
                completion(nil, error)
            }
        }
        task.resume()
    }
    
    // Agora vamos para a nossa ViewModel, a ListContactViewModel. 
}
