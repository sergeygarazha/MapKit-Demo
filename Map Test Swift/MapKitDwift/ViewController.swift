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
import AddressBook

class ViewController: UIViewController, CLLocationManagerDelegate, UITextFieldDelegate {
                            
    @IBOutlet var map : MKMapView
    @IBOutlet var textField : UITextField
    let manager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        textField.delegate = self
        manager.delegate = self
        
        if CLLocationManager.authorizationStatus() == CLAuthorizationStatus.NotDetermined {
            manager.requestWhenInUseAuthorization()
        } else {
            manager.startUpdatingLocation()
        }
        
        textField.becomeFirstResponder()
    }
    
    func locationManager(manager: CLLocationManager!,
        didChangeAuthorizationStatus status: CLAuthorizationStatus) {
            println("did change status to \(status.toRaw())")
            manager.startUpdatingLocation()
    }

    func locationManager(manager: CLLocationManager!,
        didUpdateLocations locations: AnyObject[]!) {
            println("did update location")
            map.setCenterCoordinate(manager.location.coordinate, animated: true)
            map.showsUserLocation = true
    }
    
    func textField(textField: UITextField!,
        shouldChangeCharactersInRange range: NSRange,
        replacementString string: String!) -> Bool {
            let str = "0123456789"
            
            if str.rangeOfString(string) || string == "" {
                
                let result = textField.text.bridgeToObjectiveC().stringByReplacingCharactersInRange(range, withString: string)
                let ar = checkNumber(result)
                
                return true
            }
            
            return false
    }
    
    func checkNumber(nmber: String) -> AnyObject?[] {
        var i = 0
        var result: AnyObject?[] = []
        let myPredicate = NSPredicate(format:"record.phoneNumber contains %@", nil)
        let addressBook = ABAddressBookRef()
        let thePeoples = ABAddressBookCopyArrayOfAllPeople(addressBook).takeRetainedValue()
        let count = CFArrayGetCount(thePeoples)
        
        while i < count {
//            let x: ABRecordRef? = CFArrayGetValueAtIndex(thePeoples, i)
//            if let y: ABRecordRef! = x {
//                result.append(x)
//            }
            i++
        }
        
        return result
            //filteredArrayUsingPredicate(myPredicate);
    }
}

