//
//  Work2ViewController.swift
//  Lab1
//
//  Created by Владислав Шевырёв on 12.09.2022.
//

import UIKit

class Work2ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
  
    @IBAction func goToGreen(_ sender: UIButton) {
        let newVC = storyboard?.instantiateViewController(withIdentifier: "GreenViewController")
        navigationController?.pushViewController(newVC!, animated: true)
    }
    
    @IBAction func goToMain(_ sender: UIButton) {
        navigationController?.popToRootViewController(animated: true)
    }
}
