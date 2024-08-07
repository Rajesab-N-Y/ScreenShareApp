//
//  ContentView.swift
//  ScreenShareApp
//
//  Created by Rajesab N Y on 07/08/24.
//

import SwiftUI
import HMSSDK

struct ContentView: View {
    @State var roomCode: String? = nil

    var body: some View {
        VStack {
            if let roomCode = roomCode {
                Text("Room Code: \(roomCode)")
                    .padding()
                
                Button(action: joinRoom) {
                    Text("Join Room")
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
                .padding()
                
            }
        } //: VStack
        
    } //: body
    
    // Join Room Logic
    func joinRoom() {
        // Implement the join room logic here
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(roomCode: "1234")
    }

}

