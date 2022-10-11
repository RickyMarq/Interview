//
//  ContactCell.swift
//  Interview
//
//  Created by Henrique Marques on 04/10/22.
//

import UIKit

class ContactCell: UITableViewCell {
    
    static let identifier = "ContactCell"
    // Aqui já começamos inicializando a ViewModel da Célula, desça até o final da classe...
    var viewModel: ContactCellViewModel?
    
    lazy var contactImageView: UIImageView = {
        let image = UIImage(named: "loading")
        let imageView = UIImageView(image: image)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 7
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    lazy var contactFirstName: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        return label
    }()
    
    lazy var contactLastName: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        return label
    }()
    
    
    private func setUpUIElements() {
        self.contentView.addSubview(self.contactImageView)
        self.contentView.addSubview(self.contactFirstName)
        self.contentView.addSubview(self.contactLastName)
    }
    
    private func setUpUIConstraints() {
        self.configContactImageViewConstraints()
        self.configContactNameConstraints()
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setUpUIElements()
        self.setUpUIConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func configContactImageViewConstraints() {
        NSLayoutConstraint.activate([
            
            self.contactImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 25),
            self.contactImageView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20),
            self.contactImageView.heightAnchor.constraint(equalToConstant: 100),
            self.contactImageView.widthAnchor.constraint(equalToConstant: 100),
            
        ])
    }
    
    private func configContactNameConstraints() {
        NSLayoutConstraint.activate([
        
            self.contactFirstName.topAnchor.constraint(equalTo: self.contactImageView.topAnchor),
            self.contactFirstName.leftAnchor.constraint(equalTo: self.contactImageView.rightAnchor, constant: 50),
            self.contactFirstName.heightAnchor.constraint(equalToConstant: 100),
            self.contactFirstName.widthAnchor.constraint(equalToConstant: 200),
        
        ])
    }
    
    // Como é recomendado, é sempre criar um método na nossa célula para preparar os dados para serem apresentados.
    
    func prepareCell(model: Datum) {
        // Passamos esse parâmetro "model", porque nós popularemos a nossa célula com os dados vindos da ListContactViewModel.
        // Abaixo, nós inicializamos nossa viewModel passando o parâmetro "model".
        self.viewModel = ContactCellViewModel(objc: model)
        // Agora, preparamos nossa célula com as closures que escrevemos lá na ContactCellViewModel.
        self.contactFirstName.text = (self.viewModel?.contactFirstName ?? "") + " " + (viewModel?.contactLastName ?? "")

        // Essa é a tratativa para lidar com imagens.
        DispatchQueue.global().async {
            if let image = URL(string: self.viewModel!.contactImage) {
                do {
                    let data = try Data(contentsOf: image)
                    let image = UIImage(data: data)
                    DispatchQueue.main.async {
                        self.contactImageView.image = image
                    }
                } catch {
                    print("ERROR")
                }
            }
        }
    }
}
