//
//  GreenViewController.swift
//  Lab1
//
//  Created by Владислав Шевырёв on 12.09.2022.
//

import UIKit

class GreenViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func goToMain(_ sender: UIButton) {
        navigationController?.popToRootViewController(animated: true)
    }

}
