//
//  Usuario.swift
//  Snapchat
//
//  Created by Kyrllan Nogueira on 28/08/17.
//  Copyright © 2017 Kyrllan Nogueira. All rights reserved.
//

import Foundation

class Usuario {
    
    var email: String
    var nome: String
    var uid: String
    
    init(email: String, nome: String, uid: String) {
        self.email = email
        self.nome = nome
        self.uid = uid
    }
    
}
