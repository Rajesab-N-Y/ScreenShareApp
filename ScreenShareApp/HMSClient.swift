import Foundation
import HMSSDK
import ReplayKit

class HMSClient {
    private var hms: HMSSDK
    private(set) var isJoined = false
    
    init(authToken: String) {
        self.hms = HMSSDK.build()
    }
    
    func joinRoom(roomCode: String, userName: String, delegate: HMSUpdateListener) {
        hms.getAuthTokenByRoomCode(roomCode) { token, error in
            if let token = token {
                let config = HMSConfig(userName: userName, authToken: token)
                self.hms.join(config: config, delegate: delegate)
                self.isJoined = true
            } else if let error = error {
                print("Error getting auth token: \(error)")
            }
        }
    }
    
    func startScreenSharing(completion: @escaping (Result<Void, Error>) -> Void) {
        guard isJoined else {
            completion(.failure(HMSClientError.notJoined))
            return
        }
        
        DispatchQueue.main.async {
            let broadcastPicker = RPSystemBroadcastPickerView(frame: CGRect(x: 0, y: 0, width: 44, height: 44))
            broadcastPicker.preferredExtension = "YOUR_BROADCAST_EXTENSION_BUNDLE_ID"
            
            if let button = broadcastPicker.subviews.first as? UIButton {
                button.sendActions(for: .touchUpInside)
            }
            
            self.hms.startAppScreenCapture { error in
                if let error = error {
                    completion(.failure(error))
                }
            }
        }
    }
}

enum HMSClientError: Error {
    case notJoined
    case screenShareFailed
}
