//
//  ProfileHost.swift
//  Landmarks
//
//  Created by Mac on 6/29/24.
//  Copyright © 2024 Apple. All rights reserved.
//

import SwiftUI

struct ProfileHost: View {
    
    @Environment(ModelData.self) private var modelData
    @Environment (\.editMode) private var editMode
    
    @State private var draftProfile = Profile.default
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            switch editMode?.wrappedValue {
            case .inactive:
                ProfileSummary(profile: modelData.profile)
                
            default:
                ProfileEditor(profile: $draftProfile)
                    .onAppear {
                        draftProfile = modelData.profile
                    }
                    .onDisappear {
                        modelData.profile = draftProfile
                    }
            }
        }
        .padding()
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    switch editMode?.wrappedValue {
                    case .inactive:
                        editMode?.wrappedValue = .active
                        
                    default:
                        editMode?.wrappedValue = .inactive
                    }
                } label: {
                    Text(
                        editMode?.wrappedValue == .inactive
                        ? "Edit"
                        : "Save"
                    )
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        ProfileHost()
            .environment(ModelData())
    }
}
