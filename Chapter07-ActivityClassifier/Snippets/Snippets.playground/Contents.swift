//
//  Snippets.playground
//
//  Created by Mars Geldard on 22/6/19.
//  Copyright © 2019 Mars Geldard. All rights reserved.
//

import CoreMotion

struct RuntimeError: Error {
    let message: String
    
    init(_ message: String) {
        self.message = message
    }
    
    public var localizedDescription: String {
        return message
    }
}

// typealias CMMotionActivityHandler = (CMMotionActivity?) -> Void
extension CMMotionActivityManager {
    func startTracking(handler: @escaping (CMMotionActivity?) -> Void) throws {
        if !CMMotionActivityManager.isActivityAvailable() {
            throw RuntimeError("Activity Tracking not available")
        }
        
        if CMMotionActivityManager.authorizationStatus() != .authorized {
            throw RuntimeError("Activity Tracking not permitted")
        }
        
        self.startActivityUpdates(to: .main, withHandler: handler)
    }
    
    func stopTracking() {
        self.stopActivityUpdates()
    }
}

let activityTracker = CMMotionActivityManager()
do {
    try activityTracker.startTracking { result in
        if let activity = result {
            print("New activity detected: \(activity)")
        }
    }
} catch {
    print("Error: \(error.localizedDescription)")
}
