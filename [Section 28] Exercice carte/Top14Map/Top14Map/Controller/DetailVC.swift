//
//  DetailVC.swift
//  Top14Map
//
//  Created by Aristide LAMBERT on 20/10/2024.
//

import UIKit
import MapKit

class DetailVC: UIViewController {
    
    @IBOutlet weak var map: MKMapView!
    @IBOutlet weak var logoView: UIImageView!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var cityLbl: UILabel!
    @IBOutlet weak var descLbl: UILabel!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var europeanLbl: UILabel!
    @IBOutlet weak var stadiumNameLbl: UILabel!
    @IBOutlet weak var stadiumCapacityLbl: UILabel!
    
    var club: Club!

    override func viewDidLoad() {
        super.viewDidLoad()
        logoView.image = UIImage(named: club.nickname)
        nameLbl.text = club.name
        cityLbl.text = club.city
        descLbl.text = club.desc
        titleLbl.text = convertArrayIntoText(club.franceChampion, "nationaux")
        europeanLbl.text = convertArrayIntoText(club.europeanChampion, "européens")
        stadiumNameLbl.text = club.stadium.name
        stadiumCapacityLbl.text = "Capacité: \(club.stadium.capacity)"
        centerMap()
    }
    
    func centerMap() {
        let span = MKCoordinateSpan(latitudeDelta: 0.025, longitudeDelta: 0.05)
        let center = CLLocationCoordinate2D(latitude: club.stadium.lat, longitude: club.stadium.lon)
        let region = MKCoordinateRegion(center: center, span: span)
        map.setRegion(region, animated: true)
    }
    
    func convertArrayIntoText(_ array: [Int], _ extra: String) -> String {
        var str = "Nombre de titres \(extra): \(array.count)"
        array.forEach { i in
            if i == array[0] {
                str += ": \(i)"
            } else {
                str += ", \(i)"
            }
        }
        return str
    }
    

}
