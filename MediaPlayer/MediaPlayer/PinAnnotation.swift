//
//  PinAnnotation.swift
//  MediaPlayer
//
//  Created by pedro on 26/8/17.
//  Copyright © 2017 com.company. All rights reserved.
//

import Foundation
import MapKit
import Contacts

class PinAnnotation: NSObject, MKAnnotation {
    var title: String?
    var sub: String?
    var coordinate: CLLocationCoordinate2D
    var discipline: String
    
    init(title: String, subtitle: String, discipline: String, coordinate: CLLocationCoordinate2D) {
        self.title = title
        self.sub = subtitle
        self.discipline = discipline
        self.coordinate = coordinate
        super.init()
    }
    
    var subtitle: String? {
        return self.sub
    }
    
    func mapItem() -> MKMapItem {
        let addressDictionary = [String(CNPostalAddressStreetKey):self.subtitle as AnyObject]
        let placeMark = MKPlacemark(coordinate: coordinate, addressDictionary: addressDictionary)
        let mapItem = MKMapItem(placemark: placeMark)
        mapItem.name = title
        return mapItem
    }
}
