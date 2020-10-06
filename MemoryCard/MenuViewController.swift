//
//  MenuViewController.swift
//  MemoryCard
//
//  Created by Oscar A on 30/05/20.
//  Copyright © 2020 Oscar A. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {
    
    @IBOutlet var buttons: [UIButton]!

    let data = LocalData()
    enum segues: String {
        case delicioso = "toViewControllerdelicioso"
        case brujas = "toViewControllerbrujas"
        case animales = "toViewControlleranimales"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == MenuViewController.segues.delicioso.rawValue {
            if let viewController = segue.destination as? GameViewController {
                viewController.emojis = self.data.delicioso
                viewController.bg = self.data.deliciosoImage
            }
        }
        if segue.identifier == MenuViewController.segues.brujas.rawValue {
            if let viewController = segue.destination as? GameViewController {
                viewController.emojis = self.data.brujas
                viewController.bg = self.data.brujasImage
            }
        }
        if segue.identifier == MenuViewController.segues.animales.rawValue {
            if let viewController = segue.destination as? GameViewController {
                viewController.emojis = self.data.animales
                viewController.bg = self.data.animalesImage
            }
        }
    }
    
    func setUI() -> Void {
        for eachCard in self.buttons.indices {
            buttons[eachCard].layer.cornerRadius = 4
        }
    }
}
