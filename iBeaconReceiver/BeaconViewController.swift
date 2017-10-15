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
    
    var isNearToTheDoor = false {
        didSet {
            if let timer = timer, !isNearToTheDoor {
                timer.invalidate()
            } else if isNearToTheDoor, timer == nil {
                self.initializeTimer()
            }
        }
    }
    var timer: Timer?

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
    
    func initializeTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 4, repeats: true, block: { _ in
            guard self.isNearToTheDoor else { return }
            
            self.httpRequest()
            
        })
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
    
    func httpRequest() {
        let header: HTTPHeaders = ["Authorization": "KISI-LINK 75388d1d1ff0dff6b7b04a7d5162cc6c"]
        let request = Alamofire.request("https://api.getkisi.com/locks/5124/access", method: .post, headers: header)
        print(request.debugDescription)
        
        request.response { response in
            print("Request: \(String(describing: response.request))")
            print("Response: \(String(describing: response.response))")
            print("Error: \(String(describing: response.error))")
            
            if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) {
                print("Data: \(utf8Text)")
            }
        }
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
        print(state.rawValue)
        if state == .inside {
            locationManager.startRangingBeacons(in: beaconRegion)
        }
        
    }
    
    func locationManager(_ manager: CLLocationManager,
                         didRangeBeacons beacons: [CLBeacon],
                         in region: CLBeaconRegion) {
        if beacons.count > 0 {
            
            let nearestBeacon = beacons.first!
            
            switch nearestBeacon.proximity {
            case .immediate, .near:
                isNearToTheDoor = true
                view.backgroundColor = .green
                
            case .far:
                isNearToTheDoor = false
                view.backgroundColor = .yellow
                
            default:
                isNearToTheDoor = false
                view.backgroundColor = .red
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
