//
//  PlaceAnnotations.swift
//  MapKitProject
//
//  Created by Vijay Lal on 21/11/24.
//

import Foundation
import MapKit

class PlaceAnnotations: MKPointAnnotation {
    let mapItem: MKMapItem
    let id = UUID()
    let isSelected: Bool = false
    init(mapItem: MKMapItem) {
        self.mapItem = mapItem
        super.init()
        self.coordinate = mapItem.placemark.coordinate
    }
    var name: String? {
        mapItem.name ?? ""
    }
    var phoneNumber: String? {
        mapItem.phoneNumber ?? ""
    }
    var address: String? {
        "\(mapItem.placemark.subThoroughfare ?? "") \(mapItem.placemark.thoroughfare ?? "") \(mapItem.placemark.locality ?? "") \(mapItem.placemark.countryCode ?? "")"
    }
    var location: CLLocation? {
        mapItem.placemark.location ?? CLLocation.defalt
    }
}
