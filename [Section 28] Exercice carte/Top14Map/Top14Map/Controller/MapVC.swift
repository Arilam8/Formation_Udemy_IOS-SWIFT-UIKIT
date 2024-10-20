//
//  MapVC.swift
//  Top14Map
//
//  Created by Aristide LAMBERT on 14/10/2024.
//

import UIKit
import MapKit

class MapVC: UIViewController, MKMapViewDelegate {
    @IBOutlet weak var map: MKMapView!
    
    var allStadiums: [Stadium] = Datas.shared.allStadiums
    var segueID = "identifier"

    override func viewDidLoad() {
        super.viewDidLoad()
        map.delegate = self
        allStadiums.forEach{stadium in
            let anno = StadiumAnnotation(stadium)
            map.addAnnotation(anno)
        }
        NotificationCenter.default.addObserver(self, selector: #selector(notificationObserver), name: Notification.Name("Center"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(notificationObserver), name: Notification.Name("Detail"), object: nil)
    }
    
    @objc func notificationObserver(_ notification: Notification){
        if let notif = notification.object as? MKCoordinateRegion{
            map.setRegion(notif, animated: true)
        } else if let notif = notification.object as? Club{
            performSegue(withIdentifier: segueID, sender: notif)
        }
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: any MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation{
            return nil
        }
        let id = "ID"
        var view: StadiumAnnotationView
        if let anno = annotation as? StadiumAnnotation{
            if let d = mapView.dequeueReusableAnnotationView(withIdentifier: id) as? StadiumAnnotationView{
                d.annotation = anno
                view = d
            } else {
                view = StadiumAnnotationView(annotation: annotation, reuseIdentifier: id)
            }
            view.update(anno)
            return view
        }
        return MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: id)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == segueID{
            if let next = segue.destination as? DetailVC{
                next.club = sender as? Club
            }
        }
    }
}
