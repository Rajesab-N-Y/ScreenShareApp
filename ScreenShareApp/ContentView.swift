//
//  ContentView.swift
//  ScreenShareApp
//
//  Created by Rajesab N Y on 07/08/24.
//

import SwiftUI
import HMSSDK

struct ContentView: View {
    @StateObject private var viewModel = ContentViewModel()
    
    var body: some View {
        VStack {
            if viewModel.isJoined {
                Text("Room Code: \(viewModel.roomCode)")
                    .padding()
                
                Button(action: viewModel.startScreenSharing) {
                    Text("Start Screen Sharing")
                        .padding()
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
                .padding()
                .disabled(viewModel.isScreenSharing)
                
                if viewModel.isScreenSharing {
                    Text("Screen sharing is active")
                        .foregroundColor(.green)
                }
            } else {
                Text("Waiting for room code...")
                    .padding()
            }
        }
        .alert(isPresented: $viewModel.showAlert) {
            Alert(
                title: Text(viewModel.alertTitle),
                message: Text(viewModel.alertMessage),
                primaryButton: .default(Text("Join")) {
                    viewModel.joinRoom()
                },
                secondaryButton: .cancel()
            )
        }
    }
    
    func handlePushNotification(roomCode: String, title: String, subtitle: String, body: String) {
        viewModel.handlePushNotification(roomCode: roomCode, title: title, subtitle: subtitle, body: body)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }

}
