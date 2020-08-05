//
//  ScreenMain.swift
//  MC3
//
//  Created by Peter Andrew on 05/08/20.
//  Copyright © 2020 Aghawidya Adipatria. All rights reserved.
//

import SwiftUI

struct DMScreenMain: View {
    @State var travelPaceExpand:Bool = false
    @State var coverExpand:Bool = true
    @State var lightExpand:Bool = false
    @State var typicalDifficultyClassesExpand:Bool = false
    @State var exhaustionExpand:Bool = false
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(spacing: 30) {
                ScreenTravelPace(expand: $travelPaceExpand)
                ScreenCover(expand: $coverExpand)
                ScreenLight(expand: $lightExpand)
                ScreenTypeDiffClass(expand: $typicalDifficultyClassesExpand)
                ScreenExhaustion(expand: $exhaustionExpand)
            }
        }.background(Color.gray)
    }
}

struct ScreenMain_Previews: PreviewProvider {
    static var previews: some View {
        DMScreenMain()
    }
}

struct MainTextDMScreen: View {
    @Binding var expandState:Bool
    var title:String
    var body: some View {
        Button(action: {
            self.expandState.toggle()
        }) {
            HStack{
                Text(title)
                Spacer()
                Image(systemName: "chevron.up")
                .rotationEffect(.degrees( expandState ? 0 : 180))
            }.font(.system(size: 23, weight: .medium, design: .rounded))
            .padding(.top, 18)
            .padding(.horizontal, 30)
            .padding(.bottom, expandState ? 10 : 18 )
                .background(Color.white)
        }.buttonStyle(PlainButtonStyle())
        
    }
}

struct DMScreenCard<Content:View>: View {
    var title:String
    @Binding var expandState:Bool
    let content:Content
    
    init(title:String, expandState:Binding<Bool>, @ViewBuilder content: () -> Content) {
        self.title = title
        self._expandState = expandState
        self.content = content()
    }
    
    var body: some View {
        ZStack(alignment: .topLeading){
            Rectangle().foregroundColor(.white)
            VStack(alignment: .center, spacing: 0){
                MainTextDMScreen(expandState: $expandState, title: title)
                if expandState {
                    VStack(alignment: .center, spacing: 0){
                        self.content
                    }
                    
                }
            }
        }.fixedSize(horizontal: false, vertical: true)
        .cornerRadius(10)
    }
}


struct TravelSubData {
    var pace:String
    var paceColor:Color
    var minute:String
    var hour:String
    var day:String
    var effect:String
}

struct TravelSub: View {
    var data:TravelSubData
    var underline:Bool = true
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack{
                Text("Pace :")
                Text(data.pace)
                    .foregroundColor(data.paceColor)
                    .fontWeight(.semibold)
            }
            HStack{
                Text("Minute :")
                Text(data.minute)
                    .fontWeight(.semibold)
            }
            HStack{
                Text("Hour :")
                Text(data.hour)
                    .fontWeight(.semibold)
            }
            HStack{
                Text("Day :")
                Text(data.day)
                    .fontWeight(.semibold)
            }
            HStack(alignment: .top){
                Text("Effect :")
                Text(data.effect)
                    .fontWeight(.semibold)
            }
            if underline{
                Divider().padding(.top, 10)
            } else {
                HStack{
                    Spacer()
                }
            }
        }.font(.system(size: 15, weight: .regular, design: .rounded))
            .padding(.horizontal, 40)
            .padding(.top, 10)
            .padding(.bottom, underline ? 0 : 18)
            
    }
}

struct CoverSubData {
    var cover:String
    var coverColor:Color
    var effect:String
}

struct CoverSub: View {
    var data:CoverSubData
    var underline:Bool = true
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack{
                Text("Cover :")
                Text(data.cover)
                    .foregroundColor(data.coverColor)
                    .fontWeight(.semibold)
            }
            HStack(alignment: .top){
                Text("Effect :")
                Text(data.effect)
                    .fontWeight(.semibold)
            }
            if underline{
                Divider().padding(.top, 10)
            } else {
                HStack{
                    Spacer()
                }
            }
        }.font(.system(size: 15, weight: .regular, design: .rounded))
            .padding(.horizontal, 40)
            .padding(.top, 10)
            .padding(.bottom, underline ? 0 : 18)
            
    }
}


struct LightSubData {
    var source:String
    var sourceColor:Color
    var bright:String
    var dim:String
    var duration:String
}

struct LightSub: View {
    var data:LightSubData
    var underline:Bool = true
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack{
                Text("Source :")
                Text(data.source)
                    .foregroundColor(data.sourceColor)
                    .fontWeight(.semibold)
            }
            HStack{
                Text("Bright Light :")
                Text(data.bright)
                    .fontWeight(.semibold)
            }
            HStack{
                Text("Dim Light :")
                Text(data.dim)
                    .fontWeight(.semibold)
            }
            HStack{
                Text("Duration :")
                Text(data.duration)
                    .fontWeight(.semibold)
            }
            if underline{
                Divider().padding(.top, 10)
            } else {
                HStack{
                    Spacer()
                }
            }
        }.font(.system(size: 15, weight: .regular, design: .rounded))
            .padding(.horizontal, 40)
            .padding(.top, 10)
            .padding(.bottom, underline ? 0 : 18)
            
    }
}


struct DifficultySubData {
    var taskDiff:String
    var diffColor:Color
    var dc:String
}

struct DifficultySub: View {
    var data:DifficultySubData
    var underline:Bool = true
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack{
                Text("Task Difficulty:")
                Text(data.taskDiff)
                    .foregroundColor(data.diffColor)
                    .fontWeight(.semibold)
            }
            HStack{
                Text("DC :")
                Text(data.dc)
                    .fontWeight(.semibold)
            }
            if underline{
                Divider().padding(.top, 10)
            } else {
                HStack{
                    Spacer()
                }
            }
        }.font(.system(size: 15, weight: .regular, design: .rounded))
            .padding(.horizontal, 40)
            .padding(.top, 10)
            .padding(.bottom, underline ? 0 : 18)
            
    }
}

struct ExhaustionSubData {
    var level:String
    var levelColor:Color
    var effect:String
}

struct ExhaustionSub: View {
    var data:ExhaustionSubData
    var underline:Bool = true
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack{
                Text("Level:")
                Text(data.level)
                    .foregroundColor(data.levelColor)
                    .fontWeight(.semibold)
            }
            HStack(alignment: .top){
                Text("Effect")
                Text(data.effect)
                .fontWeight(.semibold)
                .lineLimit(2)
                .fixedSize(horizontal: false, vertical: true)
                    
            }
            if underline{
                Divider().padding(.top, 10)
            } else {
                HStack{
                    Spacer()
                }
            }
        }.font(.system(size: 15, weight: .regular, design: .rounded))
            .padding(.horizontal, 40)
            .padding(.top, 10)
            .padding(.bottom, underline ? 0 : 18)
            
    }
}


struct ScreenTravelPace: View {
    @Binding var expand:Bool
    var body: some View {
        DMScreenCard(title: "Travel Pace", expandState: $expand){
            Text("While traveling, a group of adventurers can move at a normal, fast, or slow pace, as shown here.")
                .font(.system(size: 13, weight: .regular, design: .rounded))
                .multilineTextAlignment(.leading)
                .padding(.horizontal, 27)
                .padding(.top, 10)
                .fixedSize(horizontal: false, vertical: true)
            TravelSub(data: TravelSubData(pace: "Fast", paceColor: .screenGreen, minute: "400 feet", hour: "4 miles", day: "30 miles", effect: "-5 penalty to passive Wisdom (Perception) scores"))
            TravelSub(data: TravelSubData(pace: "Normal", paceColor: .screenBlue, minute: "300 feet", hour: "3 miles", day: "24 miles", effect: "---"))
            TravelSub(data: TravelSubData(pace: "Slow", paceColor: .screenRed, minute: "200 feet", hour: "2 miles", day: "18 miles", effect: "Able to use stealth"), underline: false)
        }
    }
}

struct ScreenCover: View {
    @Binding var expand:Bool
    var body: some View {
        DMScreenCard(title: "Cover", expandState: $expand){
            Text("Walls, trees, creatures, and other obstacles can provide cover during combat, making a target more difficult to harm.")
                .font(.system(size: 0, weight: .regular, design: .rounded))
                .multilineTextAlignment(.leading)
                .padding(.horizontal, 27)
                .padding(.top, 10)
            CoverSub(data: CoverSubData(cover: "Half Cover", coverColor: .screenRed, effect: "+2 bonus to AC and Dexterity saving throws"))
            CoverSub(data: CoverSubData(cover: "Three-quarters coverr", coverColor: .screenBlue, effect: "+5 bonus to AC and Dexterity saving throws"))
            CoverSub(data: CoverSubData(cover: "Total Cover", coverColor: .screenGreen, effect: "Can’t be targeted directly by an attack or a spell"),underline: false)
        }
    }
}

struct ScreenLight: View {
    @Binding var expand:Bool
    var body: some View {
        DMScreenCard(title: "Light", expandState: $expand){
            LightSub(data: LightSubData(source: "Candle", sourceColor: .screenRed, bright: "5 ft.", dim: "+5 ft.", duration: "1 hour"))
            LightSub(data: LightSubData(source: "Lantern", sourceColor: .screenOrange, bright: "20 ft.", dim: "+20 ft.", duration: "1 hour"))
            LightSub(data: LightSubData(source: "Lamp", sourceColor: .screenBlue, bright: "15 ft.", dim: "+30 ft.", duration: "6 hours"))
            LightSub(data: LightSubData(source: "Lantern (hooded)", sourceColor: .screenLightBlue, bright: "30 ft.", dim: "+30 ft.", duration: "6 hours"))
            LightSub(data: LightSubData(source: "Lantern (bullseye)", sourceColor: .screenGreen, bright: "60 ft. cone", dim: "+60 ft.", duration: "6 hours"),underline: false)
        }
    }
}

struct ScreenTypeDiffClass: View {
    @Binding var expand:Bool
    var body: some View {
        DMScreenCard(title: "Typical Difficulty Classes", expandState: $expand){
            DifficultySub(data: DifficultySubData(taskDiff: "Very Easy", diffColor: .screenGreen, dc: "5"))
            DifficultySub(data: DifficultySubData(taskDiff: "Easy", diffColor: .screenlightGreen, dc: "10"))
            DifficultySub(data: DifficultySubData(taskDiff: "Medium", diffColor: .screenBlue, dc: "15"))
            DifficultySub(data: DifficultySubData(taskDiff: "Hard", diffColor: .screenYellow, dc: "20"))
            DifficultySub(data: DifficultySubData(taskDiff: "Very Hard", diffColor: .screenOrange, dc: "25"))
            DifficultySub(data: DifficultySubData(taskDiff: "Nearly Impossible", diffColor: .screenRed, dc: "30"),underline: false)
        }
    }
}

struct ScreenExhaustion: View {
    @Binding var expand:Bool
    var body: some View {
        DMScreenCard(title: "Exhaustion", expandState: $expand){
            ExhaustionSub(data: ExhaustionSubData(level: "1", levelColor: .screenGreen, effect: "Disadvantage on ability checks"))
            ExhaustionSub(data: ExhaustionSubData(level: "2", levelColor: .screenlightGreen, effect: "Speed halved"))
            ExhaustionSub(data: ExhaustionSubData(level: "3", levelColor: .screenBlue, effect: "Disadvantage on attack rolls and saving throws"))
            ExhaustionSub(data: ExhaustionSubData(level: "4", levelColor: .screenYellow, effect: "Hit point maximum halved"))
            ExhaustionSub(data: ExhaustionSubData(level: "5", levelColor: .screenOrange, effect: "Speed reduced to 0"))
            ExhaustionSub(data: ExhaustionSubData(level: "6", levelColor: .screenRed, effect: "Death"))
        }
    }
}
