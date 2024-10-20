//
//  StadiumAnnotationView.swift
//  Top14Map
//
//  Created by Aristide LAMBERT on 14/10/2024.
//

import Foundation
import MapKit

class StadiumAnnotationView: MKAnnotationView {
    
    override init(annotation: (any MKAnnotation)?, reuseIdentifier: String?) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup() {
        image = getImage()
        frame.size = CGSize(width: 25, height: 25)
        canShowCallout = true
        leftCalloutAccessoryView = UIButton.systemButton(with: UIImage(systemName: "globe")!, target: self, action: #selector (centerOnMap))
        rightCalloutAccessoryView = UIButton.systemButton(with: UIImage(systemName: "magnifyingglass")!, target: self, action: #selector (toDetail))
    }
    
    func update(_ annotation: StadiumAnnotation){
        self.annotation = annotation
        setup()
    }
    
    func getImage() -> UIImage? {
        if let club = Datas.shared.allClubs.first(where: {$0.stadium.name == annotation!.title}){
            return UIImage(named: club.nickname)
        }
        return nil
    }
    
    @objc func centerOnMap() {
        let center = annotation!.coordinate
        let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        let region = MKCoordinateRegion(center: center, span: span)
        NotificationCenter.default.post(name: Notification.Name("Center"), object: region)
    }
    
    @objc func toDetail() {
        let club = Datas.shared.allClubs.first(where: {$0.stadium.name == annotation!.title})
        NotificationCenter.default.post(name: Notification.Name("Detail"), object: club)
    }
}
