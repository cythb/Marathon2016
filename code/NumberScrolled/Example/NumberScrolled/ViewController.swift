//
//  ViewController.swift
//  NumberScrolled
//
//  Created by tanghaibo on 03/24/2016.
//  Copyright (c) 2016 tanghaibo. All rights reserved.
//

import UIKit
import NumberScrolled

class ViewController: UIViewController {
    @IBOutlet weak var animationView: NumberScrollAnimatedView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        animationView.value = Int(arc4random()) % 10000
    }
    
    @IBAction func startStopAni(sender: AnyObject) {
        animationView.startAnimation()
    }
    
}

