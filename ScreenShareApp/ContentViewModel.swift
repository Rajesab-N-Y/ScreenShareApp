//
//  ContentViewModel.swift
//  ScreenShareApp
//
//  Created by Rajesab N Y on 08/08/24.
//

import Foundation
import HMSSDK

class ContentViewModel: ObservableObject {
    @Published var roomCode: String = ""
    @Published var isJoined: Bool = false
    @Published var isScreenSharing: Bool = false
    @Published var showAlert: Bool = false
    @Published var alertTitle: String = ""
    @Published var alertMessage: String = ""
    
    private var hmsClient: HMSClient?
    
    // Configuration
    private let authToken: String
    private let broadcastExtensionBundleID: String
    
    init(authToken: String, broadcastExtensionBundleID: String) {
        self.authToken = authToken
        self.broadcastExtensionBundleID = broadcastExtensionBundleID
    }
    
    /// Handles the incoming push notification
    /// - Parameters:
    ///   - roomCode: The room code received in the notification
    ///   - title: The title of the notification
    ///   - subtitle: The subtitle of the notification
    ///   - body: The body of the notification
    func handlePushNotification(roomCode: String, title: String, subtitle: String, body: String) {
        self.roomCode = roomCode
        self.alertTitle = title
        self.alertMessage = "\(subtitle)\n\(body)"
        self.showAlert = true
    }
    
    /// Joins the room with the current room code
    func joinRoom() {
        hmsClient = HMSClient(authToken: authToken, broadcastExtensionBundleID: broadcastExtensionBundleID)
        hmsClient?.joinRoom(roomCode: roomCode, userName: "iOS User", delegate: self)
    }
    
    /// Starts screen sharing
    func startScreenSharing() {
        hmsClient?.startScreenSharing { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success:
                    self?.isScreenSharing = true
                case .failure(let error):
                    print("Error starting screen sharing: \(error)")
                    // TODO: Show an alert to the user
                }
            }
        }
    }
}

// MARK: - HMSUpdateListener
extension ContentViewModel: HMSUpdateListener {
    func on(room: HMSRoom, update: HMSRoomUpdate) {
        // handle updates
    }
    
    func onPeerListUpdate(added: [HMSPeer], removed: [HMSPeer]) {
        // handle updates
    }
    
    func on(track: HMSTrack, update: HMSTrackUpdate, for peer: HMSPeer) {
        // handle updates
    }
    
    func onReconnecting() {
        // handle updates
    }
    
    func onReconnected() {
        // handle updates
    }
    
    func on(join room: HMSRoom) {
        DispatchQueue.main.async {
            self.isJoined = true
        }
    }
    
    func on(peer update: HMSPeer, update type: HMSPeerUpdate) {
        // Handle peer updates
    }
    
    func on(track update: HMSTrack, for peer: HMSPeer, type: HMSTrackUpdate) {
        // Handle track updates
    }
    
    func on(error: Error) {
        print("HMS error: \(error.localizedDescription)")
    }
    
    func on(message: HMSMessage) {
        // Handle incoming messages
    }
    
    func on(updated speakers: [HMSSpeaker]) {
        // Handle speaker updates
    }
    
    func on(reconnecting: Bool) {
        // Handle reconnection attempts
    }
    
    func on(roleChange request: HMSRoleChangeRequest) {
        // Handle role change requests
    }
    
    func on(changeTrackState request: HMSChangeTrackStateRequest) {
        // Handle track state change requests
    }
    
    func on(removedFromRoom notification: HMSRemovedFromRoomNotification) {
        // Handle removal from room
    }
    
    func on(room update: HMSRoomUpdate) {
        // Handle room updates
    }
}
