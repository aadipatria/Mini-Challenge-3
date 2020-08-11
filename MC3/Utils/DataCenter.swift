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
    static var instance:DataCenter? = nil
    @Published var modules:[ModuleModel] = []
    @Published var authors:[AuthorModel] = []
    @Published var activeUser:AuthorModel?
    static var savedModule:[UUID:Bool] = [:]
    
    init() {
        modules = moduleRepo.getModule()
        authors = authorRepo.getAuthor()
        activeUser = authorRepo.getActiveuser()
    }
    
    func savedModule(id:UUID)->Void {
        DataCenter.savedModule[id] = true
    }
    
    func isSavedModule(id:UUID)->Bool {
        return DataCenter.savedModule[id] ?? false
    }
    
    static func getInstance()->DataCenter {
        if self.instance != nil {
            return self.instance!
        }
        self.instance = DataCenter()
        return self.getInstance()
    }
    
    func getAllModules()->[ModuleModel] {
        return modules
    }
    
    func getModuleWithGenre(genre:Genre) -> [ModuleModel] {
        return modules.filter { module in
            return module.genre == genre
        }
    }
    
    func getModuleWithUser(author:AuthorModel) -> [ModuleModel] {
        return moduleRepo.getModuleByAuthor(authorID: author.id)
    }
    
    func getCurrentUserModule()->[ModuleModel] {
        if let user = activeUser {
            return moduleRepo.getModuleByAuthor(authorID: user.id)
        }
        return []
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
    
    func getActiveUser() -> AuthorModel? {
        return activeUser
    }
    
    func saveUser(user:AuthorModel)->Void
    {
        authorRepo.patchAuthor(author: user)
        self.syncAuthor()
    }
    
    
    func userLogin(user:AuthorModel)->Void {
        authorRepo.login(author: user)
        self.syncAuthor()
    }
    
    func userRegister(user:AuthorModel)->Void {
        activeUser = user
    }
    
    private func syncAuthor()->Void {
        authors =  authorRepo.getAuthor()
        activeUser = authorRepo.getActiveuser()
    }
    
    private func syncModule()->Void {
        modules =  moduleRepo.getModule()
    }
}
