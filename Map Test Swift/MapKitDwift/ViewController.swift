//
//  ViewController.swift
//  MapKitDwift
//
//  Created by Sergey Garazha on 16/06/14.
//  Copyright (c) 2014 self. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate, UITextFieldDelegate {
                            
    @IBOutlet var slider : UISlider
    @IBOutlet var map : MKMapView
    let manager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        manager.delegate = self
        if CLLocationManager.authorizationStatus() == CLAuthorizationStatus.NotDetermined {
            manager.requestWhenInUseAuthorization()
        } else {
            manager.startUpdatingLocation()
        }
        
        slider.addTarget(self, action: Selector("sliderMoved"), forControlEvents: UIControlEvents.ValueChanged)
    }
    
    func sliderMoved() {
        let delta : Double = Double(slider.value)
        let span = MKCoordinateSpanMake(delta, delta)
        let center = map.userLocation.location.coordinate
        var zoomRegion : MKCoordinateRegion = MKCoordinateRegion(center: center, span: span)
        map.setRegion(zoomRegion, animated: false)
    }
    
    func locationManager(manager: CLLocationManager!,
        didChangeAuthorizationStatus status: CLAuthorizationStatus) {
            
        if status != CLAuthorizationStatus.NotDetermined {
            map.showsUserLocation = true
        }
    }
    
}

