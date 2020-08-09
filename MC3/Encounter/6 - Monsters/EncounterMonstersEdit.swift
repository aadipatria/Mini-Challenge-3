//
//  EncounterMonstersEdit.swift
//  MC3
//
//  Created by Aghawidya Adipatria on 05/08/20.
//  Copyright © 2020 Aghawidya Adipatria. All rights reserved.
//

import SwiftUI

struct EncounterMonstersEdit: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @EnvironmentObject var moduleInfo: ModuleInfo
    @ObservedObject var dataCenter = DataCenter()
    
    @State var initial: Bool = false
    @State var descriptionPlaceholder: String = "Description"
    
    @State var monsterName: String = ""
    @State var monsterImage: UIImage = UIImage(named: "SampleOval")!
    @State var monsterSize: String = ""
    @State var monsterType: String = ""
    @State var monsterAlignment: String = ""
    @State var monsterArmorClass: String = ""
    @State var monsterHitPoints: String = ""
    @State var monsterSpeed: String = ""
    @State var monsterStrength: Int = 0
    @State var monsterConstitution: Int = 0
    @State var monsterWisdom: Int = 0
    @State var monsterDexterity: Int = 0
    @State var monsterIntelligence: Int = 0
    @State var monsterCharisma: Int = 0
    @State var monsterDescription: String = ""
    var editMode: EditMode
    
    var body: some View {
        VStack(spacing: 0) {
            ModuleHeader(action: {self.presentationMode.wrappedValue.dismiss()})
            
            ScrollView {
                ZStack {
                    BackgroundCard()
                    
                    VStack(alignment: .leading, spacing: 0) {
                        EncounterHeader(section: .Monsters, isEditable: false)
                        
                        ZStack {
                            Rectangle()
                                .fill(Color.white)
                                .cornerRadius(10)
                                .onTapGesture {ModuleInfo.endEditing()}
                            
                            VStack(spacing: 0) {
                                Group {
                                    VStack(spacing: 10) {
                                        SingleLineField(
                                            description: "Name",
                                            image: "TextfieldMonsterName",
                                            inputText: $monsterName
                                        )
                                        
                                        UploadImageButton(image: $monsterImage)
                                        
                                        SingleLineField(
                                            description: "Size (ft.)",
                                            image: "TextfieldMonsterSize",
                                            inputText: $monsterSize
                                        ).padding(.horizontal, 30)
                                        
                                        SingleLineField(
                                            description: "Type",
                                            image: "TextfieldMonsterType",
                                            inputText: $monsterType
                                        )
                                        
                                        SingleLineField(
                                            description: "Alignment",
                                            image: "TextfieldMonsterAlignment",
                                            inputText: $monsterAlignment
                                        )
                                        
                                        SingleLineField(
                                            description: "Armor Class",
                                            image: "TextfieldMonsterAC",
                                            inputText: $monsterArmorClass
                                        )
                                        
                                        SingleLineField(
                                            description: "Hit Points",
                                            image: "TextfieldMonsterHP",
                                            inputText: $monsterHitPoints
                                        ).padding(.horizontal, 30)
                                        
                                        SingleLineField(
                                            description: "Speed",
                                            image: "TextfieldMonsterSpeed",
                                            inputText: $monsterSpeed
                                        ).padding(.horizontal, 30)
                                    }
                                }
                                .padding(.top, 20)
                                .padding(.horizontal, 0)
                                
                                HStack(spacing: 24) {
                                    NumberField(
                                        description: "Strength",
                                        image: "StatStrength",
                                        inputText: $monsterStrength
                                    )
                                    
                                    NumberField(
                                        description: "Constitution",
                                        image: "StatConstitution",
                                        inputText: $monsterConstitution
                                    )
                                    
                                    NumberField(
                                        description: "Wisdom",
                                        image: "StatWisdom",
                                        inputText: $monsterWisdom
                                    )
                                }
                                .padding(.horizontal, 30)
                                .padding(.vertical, 10)
                                
                                HStack(spacing: 24) {
                                    NumberField(
                                        description: "Dexterity",
                                        image: "StatDexterity",
                                        inputText: $monsterDexterity
                                    )
                                    
                                    NumberField(
                                        description: "Intelligence",
                                        image: "StatIntelligence",
                                        inputText: $monsterIntelligence
                                    )
                                    
                                    NumberField(
                                        description: "Charisma",
                                        image: "StatCharisma",
                                        inputText: $monsterCharisma
                                    )
                                }
                                .padding(.horizontal, 30)
                                .padding(.bottom, 10)
                                
                                MultiLineField(
                                    description: descriptionPlaceholder,
                                    inputText: $monsterDescription
                                ).padding(.bottom, 20)

                                HStack(spacing: 30) {
                                    CancelButton(action: {
                                        self.presentationMode.wrappedValue.dismiss()
                                    })

                                    NextButton(action: {
                                        let encounterIndex = self.moduleInfo.encounterIndex
                                        let monsterIndex = self.moduleInfo.monsterIndex

                                        if self.editMode == .add {
                                            if self.initial {
                                                self.moduleInfo.currentModule.content.encounters[encounterIndex].monsters = []
                                            }

                                            self.moduleInfo.currentModule.content.encounters[encounterIndex].monsters?.append(
                                                Monster(
                                                    name: self.monsterName,
                                                    image: self.monsterImage,
                                                    size: self.monsterSize,
                                                    type: self.monsterType,
                                                    alignment: self.monsterAlignment,
                                                    armorclass: self.monsterArmorClass,
                                                    hitpoints: self.monsterHitPoints,
                                                    speed: self.monsterSpeed,
                                                    strength: self.monsterStrength,
                                                    dexterity: self.monsterDexterity,
                                                    constitution: self.monsterConstitution,
                                                    intelligence: self.monsterIntelligence,
                                                    wisdom: self.monsterWisdom,
                                                    charisma: self.monsterCharisma,
                                                    desc: self.monsterDescription)
                                            )
                                        } else if self.editMode == .edit {
                                            if (self.moduleInfo.currentModule.content.encounters[encounterIndex].monsters?[monsterIndex]) != nil {
                                                self.moduleInfo.currentModule.content.encounters[encounterIndex].monsters?[monsterIndex].name = self.monsterName
                                                self.moduleInfo.currentModule.content.encounters[encounterIndex].monsters?[monsterIndex].image = self.monsterImage
                                                self.moduleInfo.currentModule.content.encounters[encounterIndex].monsters?[monsterIndex].size = self.monsterSize
                                                self.moduleInfo.currentModule.content.encounters[encounterIndex].monsters?[monsterIndex].type = self.monsterType
                                                self.moduleInfo.currentModule.content.encounters[encounterIndex].monsters?[monsterIndex].alignment = self.monsterAlignment
                                                self.moduleInfo.currentModule.content.encounters[encounterIndex].monsters?[monsterIndex].armorclass = self.monsterArmorClass
                                                self.moduleInfo.currentModule.content.encounters[encounterIndex].monsters?[monsterIndex].hitpoints = self.monsterHitPoints
                                                self.moduleInfo.currentModule.content.encounters[encounterIndex].monsters?[monsterIndex].speed = self.monsterSpeed
                                                self.moduleInfo.currentModule.content.encounters[encounterIndex].monsters?[monsterIndex].strength = self.monsterStrength
                                                self.moduleInfo.currentModule.content.encounters[encounterIndex].monsters?[monsterIndex].dexterity = self.monsterDexterity
                                                self.moduleInfo.currentModule.content.encounters[encounterIndex].monsters?[monsterIndex].constitution = self.monsterConstitution
                                                self.moduleInfo.currentModule.content.encounters[encounterIndex].monsters?[monsterIndex].intelligence = self.monsterIntelligence
                                                self.moduleInfo.currentModule.content.encounters[encounterIndex].monsters?[monsterIndex].wisdom = self.monsterWisdom
                                                self.moduleInfo.currentModule.content.encounters[encounterIndex].monsters?[monsterIndex].charisma = self.monsterCharisma
                                                self.moduleInfo.currentModule.content.encounters[encounterIndex].monsters?[monsterIndex].desc = self.monsterDescription
                                            }
                                        }

                                        self.dataCenter.saveModule(module: self.moduleInfo.currentModule)
                                        if !self.initial {
                                            self.presentationMode.wrappedValue.dismiss()
                                        }
                                    })
                                }
                                .padding(.horizontal, 30)
                                .padding(.bottom, 20)
                            }
                        }
                        .frame(height: 733)
                        
                        Spacer()
                    }
                }
            }
        }
        .navigationBarTitle("", displayMode: .inline)
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
        
        .onAppear(perform: {
            let encounterIndex = self.moduleInfo.encounterIndex
            let monsterIndex = self.moduleInfo.monsterIndex
            
            if self.moduleInfo.currentModule.content.encounters[encounterIndex].monsters?.count ?? 0 == 0 {
                    self.initial = true
            }
            
            if self.editMode == .edit {
                if let monster = self.moduleInfo.currentModule.content.encounters[encounterIndex].monsters?[monsterIndex] {
                    self.monsterName = monster.name
                    self.monsterImage = monster.image
                    self.monsterSize = monster.size
                    self.monsterType = monster.type
                    self.monsterAlignment = monster.alignment
                    self.monsterArmorClass = monster.armorclass
                    self.monsterHitPoints = monster.hitpoints
                    self.monsterSpeed = monster.speed
                    self.monsterStrength = monster.strength
                    self.monsterConstitution = monster.constitution
                    self.monsterWisdom = monster.wisdom
                    self.monsterDexterity = monster.dexterity
                    self.monsterIntelligence = monster.intelligence
                    self.monsterCharisma = monster.charisma
                    self.monsterDescription = monster.desc
                    
                    if monster.desc != "" {
                        self.descriptionPlaceholder = ""
                    }
                }
            }
        })
    }
}

struct EncounterMonstersEdit_Preview: PreviewProvider {
    static var previews: some View {
        EncounterMonstersEdit(editMode: .add).environmentObject(ModuleInfo())
    }
}
