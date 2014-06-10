//
//  ViewController.swift
//  MapTest
//
//  Created by Sergey Garazha on 06/06/14.
//  Copyright (c) 2014 self. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class ViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
                            
    @IBOutlet var mapView : MKMapView
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        mapView.showsUserLocation = true
        locationManager.delegate = self
        showUserLocation(self)
    }
    
    @IBAction func showUserLocation(sender : AnyObject) {
        let status = CLLocationManager.authorizationStatus()
        if status == CLAuthorizationStatus.NotDetermined {
            locationManager.requestWhenInUseAuthorization()
        } else {
            locationManager.startUpdatingLocation()
        }
    }
    
    func locationManager(manager: CLLocationManager!,
        didUpdateLocations locations: AnyObject[]!) {
            mapView.setCenterCoordinate(locationManager.location.coordinate, animated: false)
    }
    
    func locationManager(manager: CLLocationManager!,
        didChangeAuthorizationStatus status: CLAuthorizationStatus) {
            locationManager.startUpdatingLocation()
    }
    
    func locationManager(manager: CLLocationManager!,
        didFailWithError error: NSError!) {
            println("Error qew: \(error)")
    }
    
}

