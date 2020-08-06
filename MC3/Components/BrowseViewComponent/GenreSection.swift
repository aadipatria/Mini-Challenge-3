//
//  GenreSection.swift
//  MC3ProgMe
//
//  Created by Peter Andrew on 28/07/20.
//  Copyright © 2020 Peter Andrew. All rights reserved.
//

import SwiftUI

struct GenreSection: View {
    @Binding var isBrowseByGenre:Bool
    @Binding var genre:Genre
    var CategoryRepository:[Genre:CategoryData] = [
        .horror:CategoryData(iconName: "horrorIcon", title: "Horror"),
        .adventure:CategoryData(iconName: "adventureIcon", title: "Adventure"),
        .action:CategoryData(iconName: "actionIcon", title: "Action"),
        .spaceTravel:CategoryData(iconName: "spaceTravelIcon", title: "Space"),
        .mystery:CategoryData(iconName: "mysteryIcon", title: "Mystery"),
        .strategy:CategoryData(iconName: "strategyIcon", title: "Strategy"),
        .medieval:CategoryData(iconName: "medievalIcon", title: "Medieval"),
        .apocalyptic:CategoryData(iconName: "apocalypticIcon", title: "Apocalyptic")
    ]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0){
            ContentText(content: "Genre", size: .semiTitle)
                .padding(.vertical, 10)
                .padding(.leading,30)
            VStack(alignment:.center, spacing:20){
                HStack(spacing: (screen.width-30)/20){
                    CategoryIcon(categoryData: CategoryRepository[.horror]!, functionality: {
                        self.genre = .horror
                        self.isBrowseByGenre.toggle()
                    })
                    CategoryIcon(categoryData: CategoryRepository[.adventure]!, functionality: {
                        self.genre = .adventure
                        self.isBrowseByGenre.toggle()

                    })
                    CategoryIcon(categoryData: CategoryRepository[.action]!, functionality: {
                        self.genre = .action
                        self.isBrowseByGenre.toggle()

                    })
                    CategoryIcon(categoryData: CategoryRepository[.spaceTravel]!, functionality: {
                        self.genre = .spaceTravel
                        self.isBrowseByGenre.toggle()

                    })
                }
                HStack(spacing: (screen.width-30)/20){
                    CategoryIcon(categoryData: CategoryRepository[.mystery]!, functionality: {
                        self.genre = .mystery
                        self.isBrowseByGenre.toggle()

                    })
                    CategoryIcon(categoryData: CategoryRepository[.strategy]!, functionality: {
                        self.genre = .strategy
                        self.isBrowseByGenre.toggle()

                    })
                    CategoryIcon(categoryData: CategoryRepository[.medieval]!, functionality: {
                        self.genre = .medieval
                        self.isBrowseByGenre.toggle()

                    })
                    CategoryIcon(categoryData: CategoryRepository[.apocalyptic]!, functionality: {
                        self.genre = .apocalyptic
                        self.isBrowseByGenre.toggle()

                    })
                }
            }.padding(.horizontal,20)
        }
    }
}

struct GenreSection_Previews: PreviewProvider {
    static var previews: some View {
        GenreSection(isBrowseByGenre: .constant(true), genre: .constant(.action))
    }
}
