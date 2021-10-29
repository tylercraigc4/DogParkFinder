//
//  ViewController.swift
//  DogParkFinder
//
//  Created by Tyler Craig on 10/25/21.
//

import UIKit
import MapKit
import CoreLocation

class ViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    var locationManager:CLLocationManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //mapView.delegate = self
        // request the location from the user
        locationManager = CLLocationManager.init()
        locationManager.requestWhenInUseAuthorization()
        
        let searchRequest = MKLocalSearch.Request()
        searchRequest.naturalLanguageQuery = "dog park"
        searchRequest.pointOfInterestFilter?.includes(MKPointOfInterestCategory.park)
        searchRequest.region = mapView.region
        
        let search = MKLocalSearch(request: searchRequest)
        search.start { (response, error) in
          guard let response = response else {
            print("Error searching - no response")
            if let error = error {
              print("Error: \(error.localizedDescription)")
            } else {
              print("No error specified")
            }
            return
           }
            
           for mapItem in response.mapItems {
               let annotation = MKPointAnnotation()
               annotation.coordinate = mapItem.placemark.coordinate
               annotation.title = mapItem.name
               annotation.subtitle = mapItem.phoneNumber
               self.mapView.addAnnotation(annotation)
           }
            self.mapView.setRegion(response.boundingRegion, animated: true)
         }
        
    }

}

extension ViewController: CLLocationManagerDelegate {
    func locationManager(_ _manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
          case .authorizedWhenInUse:
            print("Authorized When in Use")
          case .authorizedAlways:
            print("Authorized Always")
          case .denied:
            print("Denied")
          case .notDetermined:
            print("Not determined")
          case .restricted:
            print("Restricted")
          @unknown default:
            print("Unknown status")
        }
    }
}


