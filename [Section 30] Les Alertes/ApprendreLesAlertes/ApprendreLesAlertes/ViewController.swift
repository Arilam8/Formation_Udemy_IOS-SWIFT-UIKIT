//
//  ViewController.swift
//  ApprendreLesAlertes
//
//  Created by Aristide LAMBERT on 21/10/2024.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var enterText: UIBarButtonItem!
    @IBOutlet weak var textLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func addButton(title: String, color: UIColor) -> UIAlertAction {
        return UIAlertAction(title: title, style: .default) { act in
            self.view.backgroundColor = color
        }
    }
    @IBAction func TextFieldButtonPressed(_ sender: Any) {
        let controller = UIAlertController(title: "Entrez du texte", message: nil, preferredStyle: .alert)
        controller.addTextField { tf in
            tf.placeholder = "Entrez du texte ici"
        }
        controller.addTextField { tf in
            tf.placeholder = "Second"
        }
        controller.addAction(UIAlertAction(title: "Annuler", style: .destructive, handler: nil))
        let validateButton = UIAlertAction(title: "OK", style: .default){ action in
            if let value = controller.textFields?.first?.text{
                self.textLabel.text = value
            }
            if let second = controller.textFields?[1].text{
                print("J'ai quelque chose sur le second TF: \(second)")
            }
        }
        controller.addAction(validateButton)
        present(controller, animated: true, completion: nil)
    }
    
    @IBAction func alertButtonPressed(_ sender: Any) {
        let controller = UIAlertController(
            title: "Notre première alerte",
            message: "Félicitations, vous avez montré votre première alerte",
            preferredStyle: .alert)
        let action = UIAlertAction(
            title: "OK",
            style: .default) { act in
                self.view.backgroundColor = .systemBackground
        }
        let second = UIAlertAction(
            title: "Cancel",
            style: .cancel) { act in
                self.view.backgroundColor = .cyan
        }
        let destr = UIAlertAction(
            title: "Destructive",
            style: .destructive,
            handler: nil)
        controller.addAction(action)
        controller.addAction(second)
        controller.addAction(destr)
        present(controller, animated: true, completion: nil)
    }
    
    
    @IBAction func ActionSheetButtonPressed(_ sender: Any) {
        let controller = UIAlertController(title: "Modifier le fon d'écran", message: "Choisissez votre couleur", preferredStyle: .actionSheet)
        let cancel = UIAlertAction(title: "Annuler", style: .cancel, handler: nil)
        controller.addAction(cancel)
        controller.addAction(addButton(title: "Rouge", color: .systemRed))
        controller.addAction(addButton(title: "Bleu", color: .systemBlue))
        controller.addAction(addButton(title: "Jaune", color: .systemYellow))
        controller.addAction(addButton(title: "Vert", color: .systemGreen))
        controller.addAction(addButton(title: "Menthe", color: .systemMint))
        controller.addAction(addButton(title: "Défaut", color: .systemBackground))
        let device = UIDevice.current.userInterfaceIdiom
        if device == .pad {
            if let popover = controller.popoverPresentationController {
                popover.sourceView = self.view
                let center = CGRect(x: self.view.center.x, y: self.view.center.y, width: 0, height: 0)
                popover.sourceRect = center
                popover.permittedArrowDirections = [.down, .left]
            }
        }
        present(controller, animated: true, completion: nil)
    }
    
}

