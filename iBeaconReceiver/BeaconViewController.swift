//
//  BeaconViewController.swift
//  iBeaconReceiver
//
//  Created by Andrea Antonioni on 14/10/17.
//  Copyright © 2017 Andrea Antonioni. All rights reserved.
//

import UIKit
import CoreLocation
import Alamofire

class BeaconViewController: UIViewController {
    
    let locationManager = CLLocationManager()
    var beaconRegion: CLBeaconRegion!
    
    private enum BeaconStatus {
        case finded(timer: Timer)
        case unknown
        
        mutating func `switch`() {
            switch self {
            case .finded(let timer):
                timer.invalidate()
                self = .unknown
            case .unknown:
                self = .finded(timer: createTimer())
            }
        }
        
        private func createTimer() -> Timer {
            return Timer.scheduledTimer(withTimeInterval: 4, repeats: true, block: { _ in
                print("🔔")
                NetworkManager.shared.accessRequest()
            })
        }
    }
    
    private var status: BeaconStatus = .unknown
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "iBeacon"
        
        locationManager.delegate = self
        locationManager.requestAlwaysAuthorization()
        
        monitorBeacons()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func monitorBeacons() {
        // Match all beacons with the specified UUID
        let proximityUUID = UUID(uuidString:
            "9C07E0AB-EC3C-4968-9296-59A0579D0678")
        let beaconID = "io.andreaantonioni.iBeaconSample"
        
        // Create the region and begin monitoring it.
        beaconRegion = CLBeaconRegion(proximityUUID: proximityUUID!,
                                      identifier: beaconID)
        self.locationManager.startMonitoring(for: beaconRegion)
        locationManager.startUpdatingLocation()
    }
    
}

// MARK: - CLLocationManagerDelegate

extension BeaconViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager,
                         didStartMonitoringFor region: CLRegion) {
        locationManager.requestState(for: region)
    }
    
    func locationManager(_ manager: CLLocationManager,
                         didDetermineState state: CLRegionState,
                         for region: CLRegion) {
        if state == .inside {
            locationManager.startRangingBeacons(in: beaconRegion)
        }
        
    }
    
    func locationManager(_ manager: CLLocationManager,
                         didRangeBeacons beacons: [CLBeacon],
                         in region: CLBeaconRegion) {
        
        guard let nearestBeacon = beacons.first else { return }
        
        switch nearestBeacon.proximity {
        case .immediate, .near:
            view.backgroundColor = .green
            if case .unknown = status {
                status.switch()
            }
            
        default:
            view.backgroundColor = .red
            if case .finded = status {
                status.switch()
            }
        }
        
        
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
    
    
    func locationManager(_ manager: CLLocationManager, monitoringDidFailFor region: CLRegion?, withError error: Error) {
        print(error.localizedDescription)
    }
    
    
    func locationManager(_ manager: CLLocationManager, rangingBeaconsDidFailFor region: CLBeaconRegion, withError error: Error) {
        print(error.localizedDescription)
    }
    
}
