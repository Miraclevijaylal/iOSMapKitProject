//
//  PlaceTableViewController.swift
//  MapKitProject
//
//  Created by Vijay Lal on 21/11/24.
//

import Foundation
import UIKit
import MapKit

class PlaceTableViewController: UITableViewController {
    var userCurrentLocation: CLLocation
    let places: [PlaceAnnotations]
    init(userCurrentLocation: CLLocation, places: [PlaceAnnotations]) {
        self.userCurrentLocation = userCurrentLocation
        self.places = places
        super.init(nibName: nil, bundle: nil)
        //TableViewCell
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "PlaceCell")
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        places.count
    }
    private func calculateDistance(from: CLLocation, to:CLLocation) -> CLLocationDistance {
        from.distance(from: to)
    }
    private func formatDistanceForDisplay(distance: CLLocationDistance) -> String {
        let meters = Measurement(value: distance, unit: UnitLength.meters)
        return meters.converted(to: .miles).formatted()
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PlaceCell", for: indexPath)
        let place = places[indexPath.row]
        // Cell COnfiguration
        var content = cell.defaultContentConfiguration()
        content.text = place.name
        content.secondaryText = formatDistanceForDisplay(distance: calculateDistance(from: userCurrentLocation, to: place.location!))
        cell.contentConfiguration = content
        return cell
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
