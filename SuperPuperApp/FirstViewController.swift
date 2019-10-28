//
//  FirstViewController.swift
//  SuperPuperApp
//
//  Created by Ihor YERIN on 6/2/18.
//  Copyright © 2018 Ihor YERIN. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class Place: NSObject, MKAnnotation {
    let title: String?
    let locationDescription: String
    let coordinate: CLLocationCoordinate2D
    
    init(title: String, locationDescription: String, coordinate: CLLocationCoordinate2D) {
        self.title = title
        self.locationDescription = locationDescription
        self.coordinate = coordinate
        
        super.init()
    }
    var subtitle: String? {
        return locationDescription
    }
}

class FirstViewController: UIViewController, CLLocationManagerDelegate {
    
    @IBOutlet weak var myMap: MKMapView!
    @IBAction func mapStyle(_ sender: UISegmentedControl) {
        switch (sender.selectedSegmentIndex) {
        case 0:
            myMap.mapType = .standard
        case 1:
            myMap.mapType = .satellite
        default:
            myMap.mapType = .hybrid
        }
    }
    var locationManager = CLLocationManager()
    var myObj: Object?
    
    @IBAction func currentLocation(_ sender: UIButton) {
        let locValue:CLLocationCoordinate2D = locationManager.location!.coordinate
        let currentLocation = CLLocation(latitude: locValue.latitude, longitude: locValue.longitude)
        centerMapOnLocation(location: currentLocation)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        myMap.delegate = self
        let metro = Place(title: "Lukianovka",
                          locationDescription: "my favorite metro",
                          coordinate: CLLocationCoordinate2D(latitude: 50.462522, longitude: 30.481639))
        myMap.addAnnotation(metro)
        let unit = Place(title: "UnitFactory",
                          locationDescription: "free ping-pong",
                          coordinate: CLLocationCoordinate2D(latitude: 50.468988, longitude: 30.462290))
        myMap.addAnnotation(unit)
        let home = Place(title: "Home",
                          locationDescription: "sweet home",
                          coordinate: CLLocationCoordinate2D(latitude: 50.395320, longitude: 30.501846))
        myMap.addAnnotation(home)
        
        if let tmpObj = myObj {
            let tmp = Place(title: tmpObj.name,
                            locationDescription: tmpObj.sub,
                            coordinate: CLLocationCoordinate2D(latitude: tmpObj.lat, longitude: tmpObj.lon))
            myMap.addAnnotation(tmp)
            centerMapOnLocation(location: CLLocation(latitude: tmpObj.lat, longitude: tmpObj.lon))
        } else {
            centerMapOnLocation(location: CLLocation(latitude: 50.450985, longitude: 30.522569))
        }
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        myMap.showsUserLocation = true
    }
    func centerMapOnLocation(location: CLLocation) {
        let regionRadius: CLLocationDistance = 1000
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate, regionRadius, regionRadius)
        myMap.setRegion(coordinateRegion, animated: true)
    }
}

extension FirstViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard let annotation = annotation as? Place else { return nil }
        let identifier = "marker"
        var view: MKMarkerAnnotationView
        if let dequeuedView = myMap.dequeueReusableAnnotationView(withIdentifier: identifier)
            as? MKMarkerAnnotationView {
            dequeuedView.annotation = annotation
            view = dequeuedView
        } else {
            view = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            view.canShowCallout = true
            view.calloutOffset = CGPoint(x: -5, y: 5)
            view.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        }
        view.markerTintColor = UIColor.green
        return view
    }
}
