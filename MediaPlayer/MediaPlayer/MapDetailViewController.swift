//
//  LiveDetailViewController.swift
//  MediaPlayer
//
//  Created by pedro on 22/8/17.
//  Copyright © 2017 com.company. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
import Localize_Swift

class MapDetailViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    


    @IBOutlet weak var mapView: MKMapView!
    
    var data: [String:Any]?
    

    var locationManager: CLLocationManager!
    var destinationLocation:CLLocation?
    let regionRadius:CLLocationDistance = 2500
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let initialLocation = CLLocation(latitude: data?["latitude"] as! CLLocationDegrees, longitude:  data?["longitude"] as! CLLocationDegrees)
        generatePins()
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(initialLocation.coordinate, regionRadius, regionRadius)
        mapView.setRegion(coordinateRegion, animated: true)
    }
    
    
    // Mark: - Map
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let identifier = "pin"
        var view: MKPinAnnotationView
        if let annotation = annotation as? PinAnnotation {
            print("dentro")
            view = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            view.rightCalloutAccessoryView = UIButton(type: .detailDisclosure) as UIView
            view.isEnabled = true
            view.canShowCallout = true
            view.pinTintColor = .yellow
            return view
        }
        return nil
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        if let location = view.annotation as? PinAnnotation {
            let launchOptions = [MKLaunchOptionsDirectionsModeKey:MKLaunchOptionsDirectionsModeWalking]
            location.mapItem().openInMaps(launchOptions: launchOptions)
        }
    }
    
    func generatePins() {
        let pinLoc = CLLocation(latitude: data!["latitude"] as! CLLocationDegrees, longitude: data!["longitude"] as! CLLocationDegrees)
        let pinAnnotation: PinAnnotation = PinAnnotation(title: data?["title"] as! String, subtitle: data?["subtitle"] as! String, discipline: "a", coordinate: CLLocationCoordinate2D(latitude: data!["latitude"] as! CLLocationDegrees, longitude: data!["longitude"] as! CLLocationDegrees))
        pinAnnotation.coordinate = CLLocationCoordinate2D(latitude: pinLoc.coordinate.latitude, longitude: pinLoc.coordinate.longitude)
        mapView.addAnnotation(pinAnnotation)
        destinationLocation = CLLocation(latitude: pinLoc.coordinate.latitude, longitude: pinLoc.coordinate.longitude)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
