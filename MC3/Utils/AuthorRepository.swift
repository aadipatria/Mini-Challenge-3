//
//  AuthorRepository.swift
//  MC3ProgMe
//
//  Created by Peter Andrew on 01/08/20.
//  Copyright © 2020 Peter Andrew. All rights reserved.
//

import Foundation

class AuthorRepository {
    var localDB = UserDefaults.standard
    static var instance:AuthorRepository?
    static private var repo:[AuthorModel] = AuthorStub.getAllAuthor()
    
    static func getInstance()->AuthorRepository {
        if instance == nil {
            instance = AuthorRepository()
        }
        return instance!
    }
    
    func getActiveuser()->AuthorModel?{
        if localDB.bool(forKey: UserConstant.IS_REGISTER) {
            return AuthorRepository.repo[0] // suppose to fetch user
        }
        return nil // suppose to be nil in production
    }
    
    func getAuthor()->[AuthorModel] {
        return AuthorRepository.repo
    }
    
    func postAuthor(author:AuthorModel) {
        AuthorRepository.repo.append(author)
    }
    
    func deleteAuthor(author:AuthorModel) {
        AuthorRepository.repo = AuthorRepository.repo.filter { oldAuthor in
            return oldAuthor.id != author.id
        }
    }
    
    func patchAuthor(author:AuthorModel) {
        AuthorRepository.repo = AuthorRepository.repo.map{ oldAuthor in
            return oldAuthor.id == author.id ? author : oldAuthor
        }
    }
    
    func login(author:AuthorModel) {
        localDB.set(true, forKey: UserConstant.IS_REGISTER)
    }
}
