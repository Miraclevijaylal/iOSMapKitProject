//
//  ViewController+UI.swift
//  MapKitProject
//
//  Created by Vijay Lal on 20/11/24.
//

import Foundation

extension ViewController {
    func initViews() {
        let guide = view.safeAreaLayoutGuide
        view.backgroundColor = .white
        view.addSubview(myMapView)
        myMapView.translatesAutoresizingMaskIntoConstraints = false
        [myMapView.leadingAnchor.constraint(equalTo: guide.leadingAnchor, constant: 0),
         myMapView.trailingAnchor.constraint(equalTo: guide.trailingAnchor, constant: 0),
         myMapView.topAnchor.constraint(equalTo: guide.topAnchor, constant: 0),
         myMapView.bottomAnchor.constraint(equalTo: guide.bottomAnchor, constant: 0)
        ].forEach({ $0.isActive = true })
        view.addSubview(searchBarView)
        searchBarView.translatesAutoresizingMaskIntoConstraints = false
        searchBarView.returnKeyType = .go
        [searchBarView.leadingAnchor.constraint(equalTo: guide.leadingAnchor, constant: 20),
         searchBarView.trailingAnchor.constraint(equalTo: guide.trailingAnchor, constant: -20),
         searchBarView.topAnchor.constraint(equalTo: guide.topAnchor, constant: 20),
         searchBarView.heightAnchor.constraint(equalToConstant: 40)
        ].forEach({ $0.isActive = true })
    }
}
