//
//  ClubCell.swift
//  Top14Map
//
//  Created by Aristide LAMBERT on 14/10/2024.
//

import UIKit
import MapKit

class ClubCell: UITableViewCell {
    @IBOutlet weak var logoIV: UIImageView!
    @IBOutlet weak var cityLbl: UILabel!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var map: MKMapView!
    
    var club: Club!

    func setupCell(_ club: Club){
        self.club = club
        self.logoIV.image = UIImage(named: self.club.nickname)
        self.cityLbl.text = self.club.city
        self.nameLbl.text = self.club.name
        self.centerCard()
    }
    
    func centerCard(){
        let stadium = self.club.stadium
        let coords = CLLocationCoordinate2D(latitude: stadium.lat, longitude: stadium.lon)
        map.setRegion(MKCoordinateRegion(center: coords, span: MKCoordinateSpan(latitudeDelta: 0.25, longitudeDelta: 0.25)), animated: true)
    }
}
