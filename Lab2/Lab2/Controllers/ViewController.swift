//
//  ViewController.swift
//  Lab2
//
//  Created by Владислав Шевырёв on 27.09.2022.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var dislpayWidth: UILabel!
    @IBOutlet weak var colorWell: UIColorWell!
    @IBOutlet var canvas: Canvas!
    @IBOutlet weak var slider: UISlider!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
   
    @IBAction func undoBtn() {
        canvas.undo()
    }
    
    @IBAction func clearBtn() {
        canvas.clean()
    }
    
    @IBAction func setColorBtn() {
        canvas.setStrokeColor(color: colorWell.selectedColor ?? .black)
    }
    
    @IBAction func sliderChangeValue() {
        dislpayWidth.text = "\(Int((slider.value)))"
        canvas.setStrokeWidth(width: slider.value)
    }
}

