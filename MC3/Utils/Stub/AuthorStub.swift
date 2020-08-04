//
//  AuthorStub.swift
//  MC3ProgMe
//
//  Created by Peter Andrew on 01/08/20.
//  Copyright © 2020 Peter Andrew. All rights reserved.
//

import Foundation

class AuthorStub {
    static private var authors = [
        AuthorModel(name: "richard", image: "RealBrad", username: "richkid999", password: "asdasdasd", email: "rich@asd.com", phone: "082273774781"),
        AuthorModel(name: "marvin", image: "RealBrad", username: "marv", password: "asdasdasd", email: "rich@asd.com", phone: "082273774781"),
        AuthorModel(name: "kevin", image: "RealBrad", username: "kev99", password: "asdasdasd", email: "rich@asd.com", phone: "082273774781"),
        AuthorModel(name: "kevin", image: "RealBrad", username: "kev99", password: "asdasdasd", email: "rich@asd.com", phone: "082273774781"),
        AuthorModel(name: "Real Brad", image: "RealBrad", username: "realbrad", password: "12345678", email: "real@brad.com", phone: "082273774781"),
    ]
    
    static func getActiveUser()->AuthorModel{
        return AuthorStub.authors[0]
    }
    
    static func getAllAuthor()->[AuthorModel] {
        return AuthorStub.authors
    }
}
