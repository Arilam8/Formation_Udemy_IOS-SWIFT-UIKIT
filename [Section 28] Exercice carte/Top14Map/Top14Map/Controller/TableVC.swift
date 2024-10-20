//
//  TableVC.swift
//  Top14Map
//
//  Created by Aristide LAMBERT on 14/10/2024.
//

import UIKit

class TableVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!
    
    let id = "ToDetail"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Datas.shared.allClubs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let club = Datas.shared.allClubs[indexPath.row]
        if let cell = tableView.dequeueReusableCell(withIdentifier: "Club") as? ClubCell {
            cell.setupCell(club)
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let club = Datas.shared.allClubs[indexPath.row]
        performSegue(withIdentifier: id, sender: club)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == id {
            if let detail = segue.destination as? DetailVC {
                detail.club = sender as? Club
            }
        }
    }

}
