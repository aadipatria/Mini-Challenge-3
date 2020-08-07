//
//  AddModule.swift
//  MC3
//
//  Created by Peter Andrew on 06/08/20.
//  Copyright © 2020 Aghawidya Adipatria. All rights reserved.
//

import SwiftUI

struct AddModule: View {
    @Binding var isActive:Bool
    @Binding var previewModule:Bool
    @State var VM = AddModuleVM()
    @ObservedObject var dataCenter = DataCenter.getInstance()
    @EnvironmentObject var moduleInfo: ModuleInfo
    @State var user:AuthorModel? = nil
    var body: some View {
        NavigationModalTemplate(title: "Add Module", backButtonFunc: {
            self.isActive = false
        }) {
            ScrollView(.vertical, showsIndicators: false) {
                VStack(alignment: .leading, spacing: 0) {
                    AddModuleHeading(content: "Already have a Module?")
                    AddModuleSubHeading(content: "Import your existing modules by pressing button below. We'll skip the formalities and get you right to your game.")
                    UploadImage(iconName: "square.and.arrow.down", desc: "Import an Existing Module", image: $VM.image)
                    AddModuleHeading(content: "Get Started")
                    AddModuleSubHeading(content: "Get started creating your modules")
                    AddModuleInput(description: "Module Name", image: "book.fill", inputText: $VM.moduleName).padding(.bottom,9)
                    UploadImage(iconName: "icloud.and.arrow.down", desc: "Image", image: $VM.image)
                }.padding(.horizontal,30)
                VStack(spacing:9){
                    VStack(alignment: .trailing, spacing: 0) {
                        Button(action: {
                            self.VM.isLevel.toggle()
                            self.VM.isGenre = false
                        }){
                            AddModulePicker(description: {
                                switch VM.indexlevel{
                                case 0: return "Easy"
                                case 1: return "Normal"
                                case 2: return "Hard"
                                case .none:
                                    return "Level"
                                case .some(_):
                                    return "Level"
                                }
                            }(), image: "TextfieldTrapsLevel", pickState: VM.isLevel)
                        }.buttonStyle(PlainButtonStyle())
                        DropdownPicker(showPicker: $VM.isLevel, selectedIndexBinding: $VM.indexlevel,
                            pickerSize: screen.width-60,
                            array: ["Easy","Normal","Hard"])
                            .frame(width: screen.width-60).padding(.top, VM.isLevel ? 15 : 0)
                    }
                    VStack(alignment: .trailing, spacing: 0) {
                        Button(action: {
                            self.VM.isGenre.toggle()
                            self.VM.isLevel = false
                        }){
                            AddModulePicker(description: {
                                switch VM.indexGenre{
                                case 0: return "Horror"
                                case 1: return "Adventure"
                                case 2: return "Action"
                                case 3: return "Spacetravel"
                                case 4: return "Mystery"
                                case 5: return "Strategy"
                                case 6: return "Medieval"
                                case 7: return "Apocalyptic"
                                case .none:
                                    return "Genre"
                                case .some(_):
                                    return "Genre"
                                }
                            }(), image: "genre", pickState: VM.isGenre).padding(.bottom,9)
                        }.buttonStyle(PlainButtonStyle())
                        DropdownPicker(showPicker: $VM.isGenre, selectedIndexBinding: $VM.indexGenre,
                            pickerSize: screen.width-60,
                            array: [
                                "Horror",
                                "Adventure",
                                "Action",
                                "Spacetravel",
                                "Mystery",
                                "Strategy",
                                "Medieval",
                                "Apocalyptic",
                            ])
                            .frame(width: screen.width-60).padding(.top, VM.isGenre ? 15 : 0)
                    }
                }.padding(.horizontal,30)
                ApplicationActionButton(content: "Next", enableFunction: {
                    return self.VM.image != nil &&
                        self.VM.moduleName.count > 3 &&
                        self.VM.indexlevel != nil &&
                        self.VM.indexGenre != nil
                }, action: {
                    let newModule = ModuleModel(name: self.VM.moduleName, author: self.user!, coverImageName: "people", addDate: Date.init(), level: self.getLevelFromIndex(idx: self.VM.indexlevel!)!,
                        genre:self.getGenreFromIndex(idx: self.VM.indexGenre!)!, content: ModuleContent(overviews: [], encounters: [], notes: []))
                    self.dataCenter.addModules(module: newModule)
                    self.moduleInfo.currentModule = newModule
                    self.isActive = false
                    self.previewModule = true
                })
            }
        }.onAppear{
            self.user = self.dataCenter.getActiveUser()!
        }
    }
    func getLevelFromIndex(idx:Int)->ModuleLevel? {
        switch idx {
        case 0:
            return .easy
        case 1:
            return .normal
        case 2:
            return .hard
        default:
            return nil
        }
    }
    func getGenreFromIndex(idx:Int)->Genre?{
        switch idx {
        case 0 : return .horror
        case 1 : return .adventure
        case 2 : return .action
        case 3 : return .spaceTravel
        case 4 : return .mystery
        case 5 : return .strategy
        case 6 : return .medieval
        case 7 : return .apocalyptic
        default:
            return nil
        }
        
    }
}

struct AddModule_Previews: PreviewProvider {
    static var previews: some View {
        AddModule(isActive: .constant(true), previewModule: .constant(true))
    }
}

struct UploadImage: View {
    var iconName:String
    var desc:String
    @Binding var image:Image?
    var body: some View {
        ImagePickerEmbed(imageBinding: $image){
            HStack(alignment: .center, spacing: 10){
                Image(systemName: iconName)
                    .padding(.leading,20)
                Text(desc)
            }.foregroundColor(.black)
                .font(.system(size: 13, weight: .regular, design: .rounded))
                .frame(width: 354, height: 44, alignment: .leading)
                .background(Color.init(red: 209/225, green: 209/225, blue: 209/225))
                .cornerRadius(20)
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Color.black, lineWidth: 3))
                
                .buttonStyle(PlainButtonStyle())
        }
    }
}

struct AddModuleInput:View {
    var description: String
    var image: String
    @Binding var inputText: String
    
    let fieldHeight: CGFloat = 44
    
    var body: some View {
        HStack(spacing: 0) {
            ZStack {
                Rectangle()
                    .fill(Color.white)
                    .frame(width: 64, height: fieldHeight)
                
                Image(systemName: image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxWidth: 15, alignment: .center)
                    .padding(.horizontal, 5)
            }
            
            Rectangle()
                .fill(Color.black)
                .frame(width: 1, height: fieldHeight)
            
            TextField(description, text: $inputText)
                .font(.system(size: 13, weight: .regular, design: .rounded))
                .padding(.horizontal, 14)
            
            getButton()
        }
        .background(Color.white)
        .frame(idealWidth: UIScreen.main.bounds.width - 60, maxWidth: UIScreen.main.bounds.width - 60, minHeight: fieldHeight, maxHeight: fieldHeight)
        .cornerRadius(20)
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .stroke(Color.black, lineWidth: 1))
    }
    
    func getButton() -> AnyView {
        if inputText == "" {
            return AnyView(EmptyView())
        } else {
            return AnyView(
                Button(action: {
                    self.inputText = ""
                }) {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(Color.gray)
                }
                .padding(.trailing, 12)
            )
        }
    }
}

struct AddModulePicker:View {
    var description: String
    var image: String
    var pickState: Bool
    let fieldHeight: CGFloat = 44
    
    var body: some View {
        HStack(spacing: 0) {
            ZStack {
                Rectangle()
                    .fill(Color.white)
                    .frame(width: 64, height: fieldHeight)
               
                Image(image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxWidth: 15, alignment: .center)
                    .padding(.horizontal, 5)
            }
            
            Rectangle()
                .fill(Color.black)
                .frame(width: 1, height: fieldHeight)
            Text(description).font(.system(size: 13, weight: .regular, design: .rounded))
                .padding(.horizontal, 14).opacity(
                    description == "Level" || description == "Genre" ? 0.5 : 1
            )
            Spacer()
            Image(systemName: pickState ? "arrowtriangle.up.fill": "arrowtriangle.down.fill")
            .foregroundColor(Color.gray)
            .padding(.trailing, 12)        }
        .background(Color.white)
        .frame(idealWidth: UIScreen.main.bounds.width - 60, maxWidth: UIScreen.main.bounds.width - 60, minHeight: fieldHeight, maxHeight: fieldHeight)
        .cornerRadius(20)
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .stroke(Color.black, lineWidth: 1))
    }
}

struct AddModuleHeading: View {
    var content:String
    var body: some View {
        Text(content)
            .font(.system(size: 21, weight: .medium, design: .rounded))
            .padding(.bottom,15)
            .padding(.top,30)
    }
}

struct AddModuleSubHeading: View {
    var content:String
    var body: some View {
        Text(content)
            .font(.system(size: 13, weight: .regular, design: .rounded))
            .padding(.bottom,15)
    }
}
