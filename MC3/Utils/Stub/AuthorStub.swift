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
        AuthorModel(name: "richard", username: "richkid999", profileImage: "people", password: "asdasdasd", email: "rich@asd.com", phone: "082273774781"),
        AuthorModel(name: "marvin", username: "marv", profileImage: "archer", password: "asdasdasd", email: "rich@asd.com", phone: "082273774781"),
        AuthorModel(name: "kevin", username: "kev99", profileImage: "people", password: "asdasdasd", email: "rich@asd.com", phone: "082273774781"),
    ]
    
    static func getActiveUser()->AuthorModel{
        return AuthorStub.authors[0]
    }
    
    static func getPlainUser()->AuthorModel {
        return AuthorModel(name: "", username: "", profileImage: "", password: "", email: "", phone: "")
    }
    
    static func getAllAuthor()->[AuthorModel] {
        return AuthorStub.authors
    }
}
