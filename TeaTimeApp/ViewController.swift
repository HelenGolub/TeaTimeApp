//
//  ViewController.swift
//  TeaTimeApp
//
//  Created by Helen Golub on 30.11.2018.
//  Copyright © 2018 com.test. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var desktopImageView: UIImageView!
    @IBOutlet weak var gameNameLabel: UILabel!
    @IBOutlet weak var gameTaskLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func startPlayButton(_ sender: UIButton) {
        performSegue(withIdentifier: "play", sender: self)
    }
    
}

