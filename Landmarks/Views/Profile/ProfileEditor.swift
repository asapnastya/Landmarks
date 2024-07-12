//
//  ProfileEditor.swift
//  Landmarks
//
//  Created by Анастасия Романова on 7/10/24.
//  Copyright © 2024 Apple. All rights reserved.
//

import SwiftUI

struct ProfileEditor: View {
    
    @Binding var profile: Profile
    
    var body: some View {
        List {
            HStack {
                Text("Username:")
                
                Spacer()
                
                TextField(
                    "write your username",
                    text: $profile.username
                )
                .multilineTextAlignment(.trailing)
            }
            
            Toggle(isOn: $profile.prefersNotifications) {
                Text("Notifications:")
            }
            
            Picker(
                "Seasonal photos:",
                selection: $profile.seasonalPhoto
            ) {
                ForEach(Profile.Season.allCases) { season in
                    Text(season.rawValue).tag(season)
                }
            }
            
            DatePicker(
                "Goal Date",
                selection: $profile.goalDate,
                in: Date()...,
                displayedComponents: .date
            )
        }
        .navigationBarBackButtonHidden()
        .listStyle(.inset)
    }
}

#Preview {
    ProfileEditor(profile: .constant(.default))
        .environment(ModelData())
}
