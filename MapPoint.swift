//
//  MapPoint.swift
//  DogParkFinder
//
//  Created by Tyler Craig on 10/28/21.
//

import Foundation
import MapKit
import CoreLocation

class MapPoint: NSObject, MKAnnotation {
    @objc dynamic var coordinate: CLLocationCoordinate2D
    var title: String?
    var subtitle: String?
    init(coordinate:CLLocationCoordinate2D, title:String?, subtitle:String?) {
        self.coordinate = coordinate
        self.title = title
        self.subtitle = subtitle
    }
}
