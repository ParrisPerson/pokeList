//
//  PokemonViewCell.swift
//  PokeApi
//
//  Created by Parris Louis  on 9/5/23.
//

import UIKit
import Foundation

class PokemonViewCell: UITableViewCell {
    
    let backView: UIView = {
        let v = UIView(frame: .zero)
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = .red
        v.layer.cornerRadius = 20
        v.clipsToBounds = true
        v.layer.borderColor = UIColor.black.cgColor
        v.layer.borderWidth = 3
        
        return v
    }()
    
    let name: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.textColor = .white
        label.numberOfLines = 1
        label.minimumScaleFactor = 0.5
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView.backgroundColor = .clear
        backgroundColor = .clear
        self.contentView.addSubview(backView)
        self.contentView.addSubview(name)
        setupConstraints()
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupConstraints() {
        
        NSLayoutConstraint.activate([
            backView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 10),
            backView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 10),
            backView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -10),
            backView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -10)
        ])
        
        NSLayoutConstraint.activate([
            name.topAnchor.constraint(equalTo: backView.topAnchor, constant: 10),
            name.leadingAnchor.constraint(equalTo: backView.leadingAnchor, constant: 20),
            name.trailingAnchor.constraint(equalTo: backView.trailingAnchor, constant: -20)
        ])
    }
    
}
