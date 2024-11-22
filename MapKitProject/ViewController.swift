//
//  ViewController.swift
//  MapKitProject
//
//  Created by Vijay Lal on 20/11/24.
//

import UIKit
import MapKit

class ViewController: UIViewController {
    var locationManager: CLLocationManager!
    lazy var myMapView: MKMapView = {
        let view = MKMapView()
        view.showsUserLocation = true
        return view
    }()
    lazy var searchBarView: UITextField = {
        let search = UITextField()
        search.leftViewMode = .always
        search.delegate = self
        search.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        search.backgroundColor = .white
        search.layer.cornerRadius = 10
        search.placeholder = "Search"
        search.clipsToBounds = true
        return search
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        initViews()
        locationManager = CLLocationManager()
        locationManager?.delegate = self
        locationManager?.requestWhenInUseAuthorization()
        locationManager?.requestLocation()
        locationManager?.requestAlwaysAuthorization()
    }
    private func checkLocationAuthorization() {
        guard let locationManager = locationManager,
              let location = locationManager.location else { return }
        switch locationManager.authorizationStatus {
        case .authorizedWhenInUse, .authorizedAlways:
            let region = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: 750, longitudinalMeters: 750)
            myMapView.setRegion(region, animated: true)
        case .denied:
            print("")
        case .notDetermined:
            print("")
        case .restricted:
            print("")
        @unknown default :
            print("")
        }
    }
    private func presentSheetPopUP(places: [PlaceAnnotations]) {
        guard let locationManager = locationManager,
        let userLocation = locationManager.location
        else { return }
        let placeTvc = PlaceTableViewController(userCurrentLocation: userLocation, places: places)
        placeTvc.modalPresentationStyle = .pageSheet
        if let sheet = placeTvc.sheetPresentationController {
            sheet.prefersGrabberVisible = true
            sheet.detents = [.medium(), .large()]
            present(placeTvc, animated: true)
        }
    }
    private func findNearByPlaces(by query: String) {
        // clearing all Annotations
        myMapView.removeAnnotations(myMapView.annotations)
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = query
        request.region = myMapView.region
        let search = MKLocalSearch(request: request)
        search.start { [weak self] respose, error in
            guard let response = respose, error == nil else { return }
            let place = respose?.mapItems.map(PlaceAnnotations.init)
            place?.forEach { place in
                self?.myMapView.addAnnotation(place)
            }
            self?.presentSheetPopUP(places: place!) 
        }
    }
}
extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let text = textField.text ?? ""
        if !text.isEmpty {
            textField.resignFirstResponder()
            findNearByPlaces(by: text)
        }
        return true
    }
}
extension ViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
    }
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkLocationAuthorization()
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: any Error) {
        print(error)
    }
}
