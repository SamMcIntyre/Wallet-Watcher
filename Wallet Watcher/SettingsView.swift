//
//  SettingsView.swift
//  Wallet Watcher
//
//  Created by Sam McIntyre on 9/26/23.
//

import SwiftUI
import SwiftData

@Query private var settings: [Setting]



struct SettingsView: View {
    var body: some View {
		VStack{
			Text("Settings").font(.title)
			
			Spacer()
		}
    }
}

#Preview {
    SettingsView()
}
