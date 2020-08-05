//
//  EncounterSectionCard.swift
//  MC3
//
//  Created by Aghawidya Adipatria on 03/08/20.
//  Copyright © 2020 Aghawidya Adipatria. All rights reserved.
//

import SwiftUI

struct EncounterSectionCard: View {
    var isEmpty: Bool
    let section: EncounterSection
    
    var body: some View {
        VStack {
            HStack(spacing: 17) {
                Image(EncounterSectionDescription.desc[section]?[1] ?? "")
                    .padding(.leading, 30)
                    .overlay(showNotification())
                
                VStack(alignment: .leading,spacing: 5) {
                    Text(EncounterSectionDescription.desc[section]?[0] ?? "Title")
                        .padding(.top, 25)
                        .font(.system(size: 19, weight: .bold, design: .rounded))
                    Text(EncounterSectionDescription.desc[section]?[2] ?? "Desc")
                        .font(.system(size: 13, weight: .regular, design: .rounded))
                    Spacer()
                }
                
                Spacer()
                Image(systemName: "chevron.right")
                    .renderingMode(.original)
                    .font(.system(size: 17, weight: .regular, design: .rounded))
                    .padding(.trailing, 30)
            }

            Rectangle()
                .fill(Color.separator)
                .frame(height: 1)
        }
        .frame(height: 110)
    }
    
    func showNotification() -> AnyView {
        if isEmpty == true {
            return AnyView(EncounterNotification()
                .offset(x: 43, y: -28))
        } else {
            return AnyView(Circle().frame(maxWidth: 0))
        }
    }
}

enum EncounterSection: CaseIterable {
    case Environment
    case Traps
    case Maps
    case POI
    case NPC
    case Monsters
    case ReadAloudText
    case Treasure
    case Notes
}

class EncounterSectionDescription {
    static let desc = [
        EncounterSection.Environment: ["Environment", "EncounterEnvironment", "Where is this encounter, and what’s it like there?"],
        EncounterSection.Traps: ["Traps", "EncounterTraps", "Pit Falls, Poison Needles, and Bear Traps. How will your players fare?"],
        EncounterSection.Maps: ["Maps and Images", "EncounterMaps", "Keep track of all of the interesting places or images in your world"],
        EncounterSection.POI: ["Points of Interest", "EncounterPOI", "Keep track of all of the interesting locations and objects in the world."],
        EncounterSection.NPC: ["Non-Player Characters", "EncounterNPC", "Keep track of all of the interesting characters in your world"],
        EncounterSection.Monsters: ["Monsters", "EncounterMonsters", "What kind of baddies will your encounters have?"],
        EncounterSection.ReadAloudText: ["Read-Aloud Text", "EncounterRAT", "For all the things you need to say to players: wall carvings, secret messages, or worldly descriptions."],
        EncounterSection.Treasure: ["Treasure", "EncounterTreasure", "Add loot to the treasure horde."],
        EncounterSection.Notes: ["Notes", "EncounterNotes", "Was there something particularly interesting about this place?"]
    ]
}

struct EncounterNotification: View {
    var body: some View{
        ZStack {
            Circle()
                .fill(Color.blue)
                .frame(width: 24, height: 24)
                .shadow(radius: 2)
                .overlay(
                    Circle()
                        .stroke(Color.white, lineWidth: 1)
                )
            
            Text("!")
                .foregroundColor(.white)
                .font(.system(size: 19, weight: .bold, design: .rounded))
        }
    }
}

struct EncounterSectionCard_Preview: PreviewProvider {
    static var previews: some View {
        EncounterSectionCard(isEmpty: true, section: .Treasure)
    }
}
