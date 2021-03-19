//
//  NoteCell.swift
//  cft_notes
//
//  Created by Zakirov Tahir on 13.03.2021.
//

import UIKit

class NoteCell: UICollectionViewCell {
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Test text"
        label.font = UIFont(name: "Avenir Next", size: 16)
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor = .label
        return label
    }()
    
    let contentLabel: UILabel = {
        let label = UILabel()
        label.text = "new text"
        label.font = UIFont(name: "Avenir Next", size: 14)
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.numberOfLines = 1
        label.textColor = .secondaryLabel
        return label
    }()
    
    let dateLabel: UILabel = {
        let label = UILabel()
        label.text = "datedate"
        label.font = UIFont(name: "Avenir Next", size: 14)
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.numberOfLines = 1
        label.textColor = .secondaryLabel
        return label
    }()
    


    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureUI()
        
    }
    
    
    fileprivate func configureUI() {
        
        backgroundColor = .systemGray6
        layer.cornerRadius = 12
        
        addSubview(titleLabel)
        addSubview(contentLabel)
        addSubview(dateLabel)
        titleLabel.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 10, left: 10, bottom: 5, right: 10))
        contentLabel.anchor(top: titleLabel.bottomAnchor, leading: dateLabel.trailingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 5, left: 10, bottom: 10, right: 10))
        dateLabel.anchor(top: titleLabel.bottomAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: nil, padding: .init(top: 5, left: 10, bottom: 10, right: 10), size: .init(width: 80, height: 0))
    }
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
