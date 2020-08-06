//
//  ModuleRepository.swift
//  MC3ProgMe
//
//  Created by Peter Andrew on 01/08/20.
//  Copyright © 2020 Peter Andrew. All rights reserved.
//

import Foundation

class ModuleRepository {
    static var instance:ModuleRepository?
    static private var repo:[ModuleModel] = ModulesStub.getModules()
    
    static func getInstance()->ModuleRepository {
        if instance == nil {
            instance = ModuleRepository()
        }
        return instance!
    }
    
    func getModule()->[ModuleModel] {
        return ModuleRepository.repo
    }
    
    func postModule(module:ModuleModel) {
        ModuleRepository.repo.append(module)
    }
    
    func deleteModule(module:ModuleModel) {
        ModuleRepository.repo = ModuleRepository.repo.filter { oldModule in
            return oldModule.id != module.id
        }
    }
    
    func getModuleByAuthor(authorID:UUID)->[ModuleModel] {
        return ModuleRepository.repo.filter { module in
            return module.author.id == authorID
        }
    }
    
    func patchModule(module:ModuleModel) {
        ModuleRepository.repo = ModuleRepository.repo.map{ oldModule in
            return oldModule.id == module.id ? module : oldModule
        }
    }
}
