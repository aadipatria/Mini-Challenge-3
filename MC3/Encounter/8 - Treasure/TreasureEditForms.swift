//
//  TreasureEditForms.swift
//  MC3
//
//  Created by Aghawidya Adipatria on 05/08/20.
//  Copyright © 2020 Aghawidya Adipatria. All rights reserved.
//

import SwiftUI

struct EncounterTreasureEditArmor: View {
    @EnvironmentObject var moduleInfo: ModuleInfo
    @ObservedObject var dataCenter = DataCenter()
    
    @Binding var treasure: Treasure
    @State private var armorName: String = ""
    @State private var armorType: String = ""
    @State private var armorMagicModifier: String = ""
    @State private var armorPrice: String = ""
    @State private var armorWeight: String = ""
    @State private var armorArmorClass: String = ""
    @State private var armorStealth: String = ""
    @State private var armorDescription: String = ""
    @State private var armor: Armor = Armor(name: "", type: "", magicModifier: "", price: "", weight: "", armorClass: "", stealth: "", desc: "")
    
    var actionNext: () -> ()
    @State var descriptionPlaceholder: String = "Description"
    
    var initial: Bool
    var editMode: EditMode
    
    var body: some View {
        ScrollView {
            ZStack {
                Rectangle()
                    .fill(Color.white)
                    .cornerRadius(10)
                    .onTapGesture {ModuleInfo.endEditing()}

                VStack(spacing: 10) {
                    SingleLineField(
                        description: "Name",
                        image: "TextfieldMonsterAC",
                        inputText: $armorName
                    )
                        .padding(.top, 20)
                    
                    SingleLineField(
                        description: "Type",
                        image: "TextfieldArmorType",
                        inputText: $armorType
                    )
                    
                    SingleLineField(
                        description: "Magic Modifier",
                        image: "TextfieldItemModifier",
                        inputText: $armorMagicModifier
                    )
                    
                    SingleLineField(
                        description: "Price",
                        image: "TextfieldItemPrice",
                        inputText: $armorPrice
                    )
                    
                    SingleLineField(
                        description: "Weight",
                        image: "TextfieldItemWeight",
                        inputText: $armorWeight
                    )
                    
                    SingleLineField(
                        description: "Armor Class",
                        image: "TextfieldArmorAC",
                        inputText: $armorArmorClass
                    )
                    
                    SingleLineField(
                        description: "Stealth",
                        image: "TextfieldArmorStealth",
                        inputText: $armorStealth
                    )
                    
                    MultiLineField(
                        description: descriptionPlaceholder,
                        inputText: $armorDescription
                    )
                        .padding(.bottom, 10)

                    NextButton(action: {
                        let encounterIndex = self.moduleInfo.encounterIndex
                        let treasureIndex = self.moduleInfo.treasureIndex
                        
                        self.armor.name = self.armorName
                        self.armor.type = self.armorType
                        self.armor.magicModifier = self.armorMagicModifier
                        self.armor.price = self.armorPrice
                        self.armor.weight = self.armorWeight
                        self.armor.armorClass = self.armorArmorClass
                        self.armor.stealth = self.armorStealth
                        self.armor.desc = self.armorDescription
                        
                        if self.editMode == .add {
                            if self.initial {
                                self.moduleInfo.currentModule.content.encounters[encounterIndex].treasure = []
                            }

                            self.moduleInfo.currentModule.content.encounters[encounterIndex].treasure?.append(self.armor)

                        } else if self.editMode == .edit {
                            if (self.moduleInfo.currentModule.content.encounters[encounterIndex].treasure?[treasureIndex]) != nil {
                                    self.moduleInfo.currentModule.content.encounters[encounterIndex].treasure![treasureIndex] = self.armor
                            }
                        }

                        self.dataCenter.saveModule(module: self.moduleInfo.currentModule)
                        if !self.initial {
                            self.actionNext()
                        }
                    })
                        .padding(.horizontal, 30)
                        .padding(.bottom, 20)
                }
            }
            .frame(height: 575)
            
            .onAppear(perform: {
                if let armor = self.treasure as? Armor {
                    self.armorName = armor.name
                    self.armorType = armor.type
                    self.armorMagicModifier = armor.magicModifier
                    self.armorPrice = armor.price
                    self.armorWeight = armor.weight
                    self.armorArmorClass = armor.armorClass
                    self.armorStealth = armor.stealth
                    self.armorDescription = armor.desc
                    
                    if armor.desc != "" {
                        self.descriptionPlaceholder = ""
                    }
                }
            })
        }
    }
}

struct EncounterTreasureEditCoins: View {
    @EnvironmentObject var moduleInfo: ModuleInfo
    @ObservedObject var dataCenter = DataCenter()
    
    @Binding var treasure: Treasure
    @State private var platinum: Int = 0
    @State private var gold: Int = 0
    @State private var emerald: Int = 0
    @State private var silver: Int = 0
    @State private var copper: Int = 0
    @State private var coin: Coin = Coin(platinum: 0, gold: 0, emerald: 0, silver: 0, copper: 0)
    
    var actionNext: () -> ()
    var initial: Bool
    var editMode: EditMode
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(Color.white)
                .cornerRadius(10)
                .onTapGesture {ModuleInfo.endEditing()}

            VStack(spacing: 10) {
                NumberField(
                    description: "Platinum",
                    image: "TextfieldCoins1",
                    inputText: $platinum
                )
                    .padding(.top, 20)
                
                NumberField(
                    description: "Gold",
                    image: "TextfieldCoins2",
                    inputText: $gold
                )
                
                NumberField(
                    description: "Emerald",
                    image: "TextfieldCoins3",
                    inputText: $emerald
                )
                
                NumberField(
                    description: "Silver",
                    image: "TextfieldCoins4",
                    inputText: $silver
                )
                
                NumberField(
                    description: "Copper",
                    image: "TextfieldCoins5",
                    inputText: $copper
                )
                    .padding(.bottom, 10)

                NextButton(action: {
                    let encounterIndex = self.moduleInfo.encounterIndex
                    let treasureIndex = self.moduleInfo.treasureIndex
                    
                    self.coin.platinum = self.platinum
                    self.coin.gold = self.gold
                    self.coin.emerald = self.emerald
                    self.coin.silver = self.silver
                    self.coin.copper = self.copper
                    
                    if self.editMode == .add {
                        if self.initial {
                            self.moduleInfo.currentModule.content.encounters[encounterIndex].treasure = []
                        }

                        self.moduleInfo.currentModule.content.encounters[encounterIndex].treasure?.append(self.coin)

                    } else if self.editMode == .edit {
                        if (self.moduleInfo.currentModule.content.encounters[encounterIndex].treasure?[treasureIndex]) != nil {
                                self.moduleInfo.currentModule.content.encounters[encounterIndex].treasure![treasureIndex] = self.coin
                        }
                    }

                    self.dataCenter.saveModule(module: self.moduleInfo.currentModule)
                    if !self.initial {
                        self.actionNext()
                    }
                })
                    .padding(.horizontal, 30)
                    .padding(.bottom, 20)
            }
        }
        .frame(height: 364)
        
        .onAppear(perform: {
            if let coin = self.treasure as? Coin {
                self.platinum = coin.platinum
                self.gold = coin.gold
                self.emerald = coin.emerald
                self.silver = coin.silver
                self.copper = coin.copper
            }
        })
    }
}

struct EncounterTreasureEditItem: View {
    @EnvironmentObject var moduleInfo: ModuleInfo
    @ObservedObject var dataCenter = DataCenter()
    
    @Binding var treasure: Treasure
    @State private var itemName: String = ""
    @State private var itemWeight: String = ""
    @State private var itemQuantity: String = ""
    @State private var itemCost: String = ""
    @State private var itemDescription: String = ""
    @State private var item: Item = Item(name: "Item", weight: "", quantity: "", cost: "", desc: "")
    
    var actionNext: () -> ()
    @State var descriptionPlaceholder: String = "Description"
    
    var initial: Bool
    var editMode: EditMode
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(Color.white)
                .cornerRadius(10)
                .onTapGesture {ModuleInfo.endEditing()}

            VStack(spacing: 10) {
                SingleLineField(
                    description: "Name",
                    image: "TextfieldItemName",
                    inputText: $itemName
                )
                    .padding(.top, 20)
                
                SingleLineField(
                    description: "Weight",
                    image: "TextfieldItemWeight",
                    inputText: $itemWeight
                )
                
                SingleLineField(
                    description: "Quantity",
                    image: "TextfieldItemQuantity",
                    inputText: $itemQuantity
                )
                
                SingleLineField(
                    description: "Price",
                    image: "TextfieldItemPrice",
                    inputText: $itemCost
                )
                
                MultiLineField(
                    description: descriptionPlaceholder,
                    inputText: $itemDescription
                )
                    .padding(.bottom, 10)

                NextButton(action: {
                    let encounterIndex = self.moduleInfo.encounterIndex
                    let treasureIndex = self.moduleInfo.treasureIndex
                    
                    self.item.name = self.itemName
                    self.item.weight = self.itemWeight
                    self.item.quantity = self.itemQuantity
                    self.item.cost = self.itemCost
                    self.item.desc = self.itemDescription
                    
                    if self.editMode == .add {
                        if self.initial {
                            self.moduleInfo.currentModule.content.encounters[encounterIndex].treasure = []
                        }

                        self.moduleInfo.currentModule.content.encounters[encounterIndex].treasure?.append(self.item)

                    } else if self.editMode == .edit {
                        if (self.moduleInfo.currentModule.content.encounters[encounterIndex].treasure?[treasureIndex]) != nil {
                                self.moduleInfo.currentModule.content.encounters[encounterIndex].treasure![treasureIndex] = self.item
                        }
                    }

                    self.dataCenter.saveModule(module: self.moduleInfo.currentModule)
                    if !self.initial {
                        self.actionNext()
                    }
                })
                    .padding(.horizontal, 30)
                    .padding(.bottom, 20)
            }
        }
        .frame(height: 412)
        
        .onAppear(perform: {
            if let item = self.treasure as? Item {
                self.itemName = item.name
                self.itemWeight = item.weight
                self.itemQuantity = item.quantity
                self.itemCost = item.cost
                self.itemDescription = item.desc
                
                if item.desc != "" {
                    self.descriptionPlaceholder = ""
                }
            }
        })
    }
}

struct EncounterTreasureEditMagic: View {
    @EnvironmentObject var moduleInfo: ModuleInfo
    @ObservedObject var dataCenter = DataCenter()
    
    @Binding var treasure: Treasure
    @State private var magicName: String = ""
    @State private var magicType: String = ""
    @State private var magicRarity: String = ""
    @State private var magicCharge: String = ""
    @State private var magicWeight: String = ""
    @State private var magicDescription: String = ""
    @State private var magic = Magic(name: "Magix", type: "", rarity: "", maxCharge: "", weight: "", desc: "")
    
    var actionNext: () -> ()
    @State var descriptionPlaceholder: String = "Description"
    
    var initial: Bool
    var editMode: EditMode
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(Color.white)
                .cornerRadius(10)
                .onTapGesture {ModuleInfo.endEditing()}

            VStack(spacing: 10) {
                SingleLineField(
                    description: "Name",
                    image: "TextfieldMagicName",
                    inputText: $magicName
                )
                    .padding(.top, 20)

                SingleLineField(
                    description: "Type",
                    image: "TextfieldMagicType",
                    inputText: $magicType
                )
                
                SingleLineField(
                    description: "Rarity",
                    image: "TextfieldMagicRarity",
                    inputText: $magicRarity
                )
                
                SingleLineField(
                    description: "Max Charges",
                    image: "TextfieldMagicCharges",
                    inputText: $magicCharge
                )
                
                SingleLineField(
                    description: "Weight",
                    image: "TextfieldItemWeight",
                    inputText: $magicWeight
                )
                
                MultiLineField(
                    description: descriptionPlaceholder,
                    inputText: $magicDescription
                )
                    .padding(.bottom, 10)

                NextButton(action: {
                    let encounterIndex = self.moduleInfo.encounterIndex
                    let treasureIndex = self.moduleInfo.treasureIndex
                    
                    self.magic.name = self.magicName
                    self.magic.type = self.magicType
                    self.magic.rarity = self.magicRarity
                    self.magic.maxCharge = self.magicCharge
                    self.magic.weight = self.magicWeight
                    self.magic.desc = self.magicDescription
                    
                    if self.editMode == .add {
                        if self.initial {
                            self.moduleInfo.currentModule.content.encounters[encounterIndex].treasure = []
                        }

                        self.moduleInfo.currentModule.content.encounters[encounterIndex].treasure?.append(self.magic)

                    } else if self.editMode == .edit {
                        if (self.moduleInfo.currentModule.content.encounters[encounterIndex].treasure?[treasureIndex]) != nil {
                                self.moduleInfo.currentModule.content.encounters[encounterIndex].treasure![treasureIndex] = self.magic
                        }
                    }

                    self.dataCenter.saveModule(module: self.moduleInfo.currentModule)
                    if !self.initial {
                        self.actionNext()
                    }
                })
                    .padding(.horizontal, 30)
                    .padding(.bottom, 20)
            }
        }
        .frame(height: 467)
        
        .onAppear(perform: {
            if let magic = self.treasure as? Magic {
                self.magicName = magic.name
                self.magicType = magic.type
                self.magicRarity = magic.rarity
                self.magicCharge = magic.maxCharge
                self.magicWeight = magic.weight
                self.magicDescription = magic.desc
                
                if magic.desc != "" {
                    self.descriptionPlaceholder = ""
                }
            }
        })
    }
}

struct EncounterTreasureEditWeapon: View {
    @EnvironmentObject var moduleInfo: ModuleInfo
    @ObservedObject var dataCenter = DataCenter()
    
    @Binding var treasure: Treasure
    @State private var weaponName: String = ""
    @State private var weaponDamage: String = ""
    @State private var weaponMagicModifier: String = ""
    @State private var weaponType: String = ""
    @State private var weaponHandedness: String = ""
    @State private var weaponProficiency: String = ""
    @State private var weaponPrice: String = ""
    @State private var weaponWeight: String = ""
    @State private var weaponRange: String = ""
    @State private var weaponDamageType: String = ""
    @State private var weaponProperty: String = ""
    @State private var weaponQuantity: String = ""
    @State private var weaponDescription: String = ""
    @State private var weapon: Weapon = Weapon(name: "", damage: "", magicModifier: "", type: "", handedness: "", proficiency: "", price: "", weight: "", range: "", damageType: "", property: "", quantity: "", desc: "")
    
    var actionNext: () -> ()
    @State var descriptionPlaceholder: String = "Description"
    
    var initial: Bool
    var editMode: EditMode
    
    var body: some View {
        ScrollView {
            ZStack {
                Rectangle()
                    .fill(Color.white)
                    .cornerRadius(10)
                    .onTapGesture {ModuleInfo.endEditing()}

                VStack(spacing: 10) {
                    SingleLineField(
                        description: "Name",
                        image: "TextfieldWeaponName",
                        inputText: $weaponName
                    )
                        .padding(.top, 20)
                    
                    VStack(spacing: 10) {
                        SingleLineField(
                            description: "Damage",
                            image: "TextfieldWeaponDamage",
                            inputText: $weaponDamage
                        )
                        
                        SingleLineField(
                            description: "Magical Modifier",
                            image: "TextfieldItemModifier",
                            inputText: $weaponMagicModifier
                        )
                        
                        SingleLineField(
                            description: "Type",
                            image: "TextfieldWeaponType",
                            inputText: $weaponType
                        )
                        
                        SingleLineField(
                            description: "Handedness",
                            image: "TextfieldWeaponHandedness",
                            inputText: $weaponHandedness
                        )
                        
                        SingleLineField(
                            description: "Proficiency",
                            image: "TextfieldWeaponProficiency",
                            inputText: $weaponProficiency
                        )
                    }.padding(.all, 0)
                    
                    SingleLineField(
                        description: "Price",
                        image: "TextfieldItemPrice",
                        inputText: $weaponPrice
                    )
                    
                    SingleLineField(
                        description: "Weight",
                        image: "TextfieldItemWeight",
                        inputText: $weaponWeight
                    )
                    
                    SingleLineField(
                        description: "Range",
                        image: "TextfieldWeaponRange",
                        inputText: $weaponRange
                    )
                    
                    SingleLineField(
                        description: "Damage Type",
                        image: "TextfieldWeaponDamageType",
                        inputText: $weaponDamageType
                    )
                    
                    SingleLineField(
                        description: "Property",
                        image: "TextfieldWeaponProperty",
                        inputText: $weaponProperty
                    )
                    
                    SingleLineField(
                        description: "Quantity",
                        image: "TextfieldItemQuantity",
                        inputText: $weaponQuantity
                    )
                    
                    MultiLineField(
                        description: descriptionPlaceholder,
                        inputText: $weaponDescription
                    )
                        .padding(.bottom, 10)

                    NextButton(action: {
                        let encounterIndex = self.moduleInfo.encounterIndex
                        let treasureIndex = self.moduleInfo.treasureIndex
                        
                        self.weapon.name = self.weaponName
                        self.weapon.damage = self.weaponDamage
                        self.weapon.magicModifier = self.weaponMagicModifier
                        self.weapon.type = self.weaponType
                        self.weapon.handedness = self.weaponHandedness
                        self.weapon.proficiency = self.weaponProficiency
                        self.weapon.price = self.weaponPrice
                        self.weapon.weight = self.weaponWeight
                        self.weapon.range = self.weaponRange
                        self.weapon.type = self.weaponDamageType
                        self.weapon.property = self.weaponProperty
                        self.weapon.quantity = self.weaponQuantity
                        self.weapon.desc = self.weaponDescription
                        
                        if self.editMode == .add {
                            if self.initial {
                                self.moduleInfo.currentModule.content.encounters[encounterIndex].treasure = []
                            }

                            self.moduleInfo.currentModule.content.encounters[encounterIndex].treasure?.append(self.weapon)

                        } else if self.editMode == .edit {
                            if (self.moduleInfo.currentModule.content.encounters[encounterIndex].treasure?[treasureIndex]) != nil {
                                    self.moduleInfo.currentModule.content.encounters[encounterIndex].treasure![treasureIndex] = self.weapon
                            }
                        }

                        self.dataCenter.saveModule(module: self.moduleInfo.currentModule)
                        if !self.initial {
                            self.actionNext()
                        }
                    })
                        .padding(.horizontal, 30)
                        .padding(.bottom, 20)
                }
            }
            .frame(height: 845)
            
            .onAppear(perform: {
                if let weapon = self.treasure as? Weapon {
                    self.weaponName = weapon.name
                    self.weaponDamage = weapon.damage
                    self.weaponMagicModifier = weapon.magicModifier
                    self.weaponType = weapon.type
                    self.weaponHandedness = weapon.handedness
                    self.weaponProficiency = weapon.proficiency
                    self.weaponPrice = weapon.price
                    self.weaponWeight = weapon.weight
                    self.weaponRange = weapon.range
                    self.weaponDamageType = weapon.damageType
                    self.weaponProperty = weapon.property
                    self.weaponQuantity = weapon.quantity
                    self.weaponDescription = weapon.desc
                    
                    if weapon.desc != "" {
                        self.descriptionPlaceholder = ""
                    }
                }
            })
        }
    }
}
