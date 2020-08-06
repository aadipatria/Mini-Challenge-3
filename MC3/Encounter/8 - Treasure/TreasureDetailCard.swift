//
//  TreasureDetailCard.swift
//  MC3
//
//  Created by Aghawidya Adipatria on 05/08/20.
//  Copyright © 2020 Aghawidya Adipatria. All rights reserved.
//

import SwiftUI

struct TreasureDetailCard: View {
    @State var treasureType: TreasureType = .armor
    @State var title: String = "Coins"
    @State var description: String = ""
    var treasure: Treasure
    var actionDelete: () -> ()
    var actionEdit: () -> ()
    
    var body: some View {
        VStack(spacing: 30) {
            HStack(alignment: .bottom, spacing: 15) {
                Text(title)
                    .font(.system(size: 23, weight: .medium, design: .rounded))
                
                Spacer()
                
                //if dataCenter.getActiveUser()?.id == moduleInfo.currentModule.author.id {
                DeleteButton(action: actionDelete)
                //EditButton(action: actionEdit)
            }
            .padding(.top, 20)
            .padding(.horizontal, 30)
        
            Text(description)
                .frame(width: UIScreen.main.bounds.width - 80, alignment: .leading)
                .font(.system(size: 15, weight: .regular, design: .rounded))
                .padding(.horizontal, 40)
            
            Spacer()
        }
        .background(Color.white)
        .onAppear(perform: {
            self.treasureType = self.treasure.treasureType
            
            switch self.treasureType {
            case .weapon:
                let weapon = self.treasure as! Weapon
                self.title = weapon.name
                self.description =
                """
                Type: \(weapon.type)
                Handedness: \(weapon.handedness)
                Proficiency: \(weapon.proficiency)
                
                Damage: \(weapon.damage)
                Damage Type: \(weapon.damageType)
                Magic Modifiers: \(weapon.magicModifier)
                Range: \(weapon.range)
                
                Property: \(weapon.property)
                Weight: \(weapon.weight)
                Price: \(weapon.price)
                Quantity: \(weapon.quantity)
                
                Description\n\(weapon.desc)
                """
                
            case .magic:
                let magic = self.treasure as! Magic
                self.title = magic.name
                self.description =
                """
                \(magic.rarity)
                Type: \(magic.type)
                Weight: \(magic.weight)
                Max Charges: \(magic.maxCharge)
                \nDescription\n\(magic.desc)
                """
                
            case .item:
                let item = self.treasure as! Item
                self.title = item.name
                self.description =
                """
                Quantity: \(item.quantity)
                Weight: \(item.weight)
                Cost: \(item.cost)
                \nDescription\n\(item.desc)
                """
                
            case .coin:
                let coin = self.treasure as! Coin
                self.description = ""
                if coin.platinum > 0 {
                    self.description += "\(coin.platinum) platinum coins\n"
                }
                if coin.gold > 0 {
                    self.description += "\(coin.gold) gold coins\n"
                }
                if coin.emerald > 0 {
                    self.description += "\(coin.emerald) emeralds\n"
                }
                if coin.silver > 0 {
                    self.description += "\(coin.silver) silver coins\n"
                }
                if coin.copper > 0 {
                    self.description += "\(coin.copper) copper coins"
                }
                
            case .armor:
                let armor = self.treasure as! Armor
                self.title = armor.name
                self.description =
                """
                Type: \(armor.type)
                Armor Class: \(armor.armorClass)
                Magic Modifiers: \(armor.magicModifier)
                Weight: \(armor.weight)
                Price: \(armor.price)
                Stealth: \(armor.stealth)
                \nDescription\n\(armor.desc)
                """
            }
        })
    }
}

struct TreasureDetailCard_Preview: PreviewProvider {
    static var previews: some View {
        TreasureDetailCard(treasure: Magic(name: "Amulet of Health", type: "Wondrous Item", rarity: "Legendary", maxCharge: "", weight: "", desc: "Your Constitution score is 19 while you wear this amulet. It has no effect on you if your Constitution is already 19 or higher."), actionDelete: {}, actionEdit: {})
    }
}
