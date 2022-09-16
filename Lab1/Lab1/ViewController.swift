//
//  ViewController.swift
//  Lab1
//
//  Created by Владислав Шевырёв on 12.09.2022.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var labelOfUserChoice: UILabel!
    var valueOfResult: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.labelOfUserChoice.text = "\(String(describing: valueOfResult))"
    }
    @IBAction func goToYellow(_ sender: UIBarButtonItem) {
        let newVC = storyboard?.instantiateViewController(withIdentifier: "Work2ViewController")
        navigationController?.pushViewController(newVC!, animated: true)
    }
    
    @IBAction func goToMint(_ sender: UIBarButtonItem) {
        let newVC = storyboard?.instantiateViewController(withIdentifier: "Work1ViewController")
        navigationController?.pushViewController(newVC!, animated: true)
    }
    
}

