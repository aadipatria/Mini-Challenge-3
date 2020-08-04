//
//  MockDB.swift
//  MC3ProgMe
//
//  Created by Peter Andrew on 31/07/20.
//  Copyright © 2020 Peter Andrew. All rights reserved.
//

import Foundation

class DataCenter : ObservableObject {
    let authorRepo:AuthorRepository = AuthorRepository.getInstance()
    let moduleRepo:ModuleRepository = ModuleRepository.getInstance()
    @Published var modules:[ModuleModel] = []
    @Published var authors:[AuthorModel] = []
    
    init() {
        modules = moduleRepo.getModule()
        authors = authorRepo.getAuthor()
    }
    
    func getAllModules()->[ModuleModel] {
        return modules
    }
    
    func getModuleWithGenre(genre:Genre) -> [ModuleModel] {
        return modules.filter { module in
            return module.genre == genre
        }
    }
    
    func saveModule(module:ModuleModel) -> Void {
        moduleRepo.patchModule(module: module)
        self.syncModule()
    }
    
    func addModules(module:ModuleModel) {
        moduleRepo.postModule(module: module)
        self.syncModule()
    }
    
    func getAllAuthors()->[AuthorModel] {
        return authors
    }
    
    func getActiveUser() -> AuthorModel {
        return authorRepo.getActiveuser()
    }
    
    func saveUser(user:AuthorModel)->Void
    {
        authorRepo.patchAuthor(author: user)
        self.syncAuthor()
    }
    
    private func syncAuthor()->Void {
        authors =  authorRepo.getAuthor()
    }
    
    private func syncModule()->Void {
        modules =  moduleRepo.getModule()
    }
}
