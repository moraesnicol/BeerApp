//
//  viewCodeProtocol.swift
//  BeerApp
//
//  Created by Gabriel on 27/09/21.
//

import Foundation

public protocol CodeView {
    
    func setupHierarchy()
    func setupConstraints()
    func setupAdditionalConfigurations()
    
}

extension CodeView {
    
    public func setupView() {
        setupHierarchy()
        setupConstraints()
        setupAdditionalConfigurations()
    }
    
    public func setupAdditionalConfigurations() {
        
    }
}
