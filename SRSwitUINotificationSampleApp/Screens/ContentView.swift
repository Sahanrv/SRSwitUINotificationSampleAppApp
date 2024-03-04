//
//  ContentView.swift
//  SRSwitUINotificationSampleApp
//
//  Created by Sahan Ravindu on 04/03/2024.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var notificationManager = NotificationManager()
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
            
            Button("Request Notification"){
                Task{
                    await notificationManager.request()
                }
            }
            .buttonStyle(.bordered)
//            .disabled(notificationManager.hasPermission)
            .task {
                await notificationManager.getAuthStatus()
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
