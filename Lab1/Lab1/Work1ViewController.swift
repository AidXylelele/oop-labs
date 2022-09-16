//
//  Work1ViewController.swift
//  Lab1
//
//  Created by Владислав on 12.09.2022.
//

import UIKit

class Work1ViewController: UIViewController {
    
    @IBOutlet weak var label: UILabel!
    
    @IBOutlet weak var slider: UISlider!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func sliderValueChanged(_ sender: Any) {
        label.text = "\(Int(slider.value))"
    }
    
    @IBAction func saveTheValue(_ sender: UIButton) {
        let newVC = storyboard?.instantiateViewController(withIdentifier: "ViewController") as! ViewController
        let value = slider.value
        newVC.valueOfResult = Int(value)
        navigationController?.pushViewController(newVC, animated: true)
    }
}
