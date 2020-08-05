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
    @State private var armorWeight: Int = 0
    @State private var armorArmorClass: String = ""
    @State private var armorStealth: Int = 0
    @State private var armorDescription: String = ""
    
    var actionNext: () -> ()
    var descriptionPlaceholder: String = "Description"
    
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
                        inputText: $armorName
                    )
                    
                    SingleLineField(
                        description: "Magic Modifier",
                        image: "TextfieldArmorMagicModifier",
                        inputText: $armorName
                    )
                    
                    SingleLineField(
                        description: "Price",
                        image: "TextfieldItemPrice",
                        inputText: $armorPrice
                    )
                    
                    NumberField(
                        description: "Weight",
                        image: "TextfieldItemWeight",
                        inputText: $armorWeight
                    )
                    
                    SingleLineField(
                        description: "Armor Class",
                        image: "TextfieldArmorAC",
                        inputText: $armorArmorClass
                    )
                    
                    NumberField(
                        description: "Stealth",
                        image: "TextfieldArmorStealth",
                        inputText: $armorStealth
                    )
                    
                    MultiLineField(
                        description: descriptionPlaceholder,
                        inputText: $armorDescription
                    )
                        .padding(.bottom, 10)

                    NextButton(action: actionNext)
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
    
    var actionNext: () -> ()
    
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

                NextButton(action: actionNext)
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
    @State private var itemWeight: Int = 0
    @State private var itemQuantity: Int = 0
    @State private var itemCost: String = ""
    @State private var itemDescription: String = ""
    
    var actionNext: () -> ()
    var descriptionPlaceholder: String = "Description"
    
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
                
                NumberField(
                    description: "Weight",
                    image: "TextfieldItemWeight",
                    inputText: $itemWeight
                )
                
                NumberField(
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

                NextButton(action: actionNext)
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
    @State private var magicCharge: Int = 0
    @State private var magicWeight: Int = 0
    @State private var magicDescription: String = ""
    
    var actionNext: () -> ()
    var descriptionPlaceholder: String = "Description"
    
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
                
                NumberField(
                    description: "Max Charges",
                    image: "TextfieldMagicCharges",
                    inputText: $magicCharge
                )
                
                NumberField(
                    description: "Weight",
                    image: "TextfieldItemWeight",
                    inputText: $magicWeight
                )
                
                MultiLineField(
                    description: descriptionPlaceholder,
                    inputText: $magicDescription
                )
                    .padding(.bottom, 10)

                NextButton(action: actionNext)
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
    @State private var weaponWeight: Int = 0
    @State private var weaponRange: Int = 0
    @State private var weaponDamageType: String = ""
    @State private var weaponProperty: String = ""
    @State private var weaponQuantity: Int = 0
    @State private var weaponDescription: String = ""
    
    var actionNext: () -> ()
    var descriptionPlaceholder: String = "Description"
    
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
                            image: "TextfieldWeaponMagicalModifier",
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
                    
                    NumberField(
                        description: "Weight",
                        image: "TextfieldItemWeight",
                        inputText: $weaponWeight
                    )
                    
                    NumberField(
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
                    
                    NumberField(
                        description: "Quantity",
                        image: "TextfieldItemQuantity",
                        inputText: $weaponQuantity
                    )
                    
                    MultiLineField(
                        description: descriptionPlaceholder,
                        inputText: $weaponDescription
                    )
                        .padding(.bottom, 10)

                    NextButton(action: actionNext)
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
                }
            })
        }
    }
}
