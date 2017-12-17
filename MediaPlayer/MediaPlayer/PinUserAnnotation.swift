//
//  PinUserAnnotation.swift
//  MediaPlayer
//
//  Created by pedro on 14/9/17.
//  Copyright © 2017 com.company. All rights reserved.
//

import Foundation
import MapKit

class PinUserAnnotation: NSObject, MKAnnotation {
    var title: String?
    var subtitle: String?
    var coordinate: CLLocationCoordinate2D
    var discipline: String
    
    init(title: String, subtitle: String, discipline:String, coordinate: CLLocationCoordinate2D) {
        self.title = title
        self.subtitle = subtitle
        self.discipline = discipline
        self.coordinate = coordinate
    }
}
