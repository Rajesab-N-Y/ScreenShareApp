import Foundation
import HMSSDK
import ReplayKit

class HMSClient {
    private var hms: HMSSDK
    private(set) var isJoined = false
    
    // Configuration
    private let broadcastPickerSize: CGFloat = 44
    private let broadcastExtensionBundleID: String
    
    init(authToken: String, broadcastExtensionBundleID: String) {
        self.hms = HMSSDK.build()
        self.broadcastExtensionBundleID = broadcastExtensionBundleID
    }
    
    /// Joins a room with the given room code and username
    /// - Parameters:
    ///   - roomCode: The code of the room to join
    ///   - userName: The name of the user joining the room
    ///   - delegate: The delegate to receive updates about the room
    func joinRoom(roomCode: String, userName: String, delegate: HMSUpdateListener) {
        hms.getAuthTokenByRoomCode(roomCode) { [weak self] token, error in
            guard let self = self else { return }
            if let token = token {
                let config = HMSConfig(userName: userName, authToken: token)
                self.hms.join(config: config, delegate: delegate)
                self.isJoined = true
            } else if let error = error {
                print("Error getting auth token: \(error)")
            }
        }
    }
    
    /// Starts screen sharing
    /// - Parameter completion: Callback to handle the result of starting screen sharing
    func startScreenSharing(completion: @escaping (Result<Void, Error>) -> Void) {
        guard isJoined else {
            completion(.failure(HMSClientError.notJoined))
            return
        }
        
        DispatchQueue.main.async {
            let broadcastPicker = RPSystemBroadcastPickerView(frame: CGRect(x: 0, y: 0, width: self.broadcastPickerSize, height: self.broadcastPickerSize))
            broadcastPicker.preferredExtension = self.broadcastExtensionBundleID
            
            if let button = broadcastPicker.subviews.first as? UIButton {
                button.sendActions(for: .touchUpInside)
            }
            
            self.hms.startAppScreenCapture { error in
                if let error = error {
                    completion(.failure(error))
                } else {
                    completion(.success(()))
                }
            }
        }
    }
    
    /// Stops screen sharing
    func stopScreenSharing() {
        hms.stopAppScreenCapture()
    }
    
    /// Leaves the room
    func leaveRoom() {
        hms.leave()
        isJoined = false
    }
}

enum HMSClientError: Error {
    case notJoined
    case screenShareFailed
}
