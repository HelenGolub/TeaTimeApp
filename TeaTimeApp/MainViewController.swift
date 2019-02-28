//
//  MainViewController.swift
//  TeaTimeApp
//
//  Created by Helen Golub on 01.12.2018.
//  Copyright © 2018 com.test. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    private let vasesArray = ["aquaVase", "blueVase", "greenVase", "orangeVase", "purpleVase", "redVase", "yellowVase"]
    private let sausersArray = ["aquaSaucer", "blueSaucer", "greenSaucer", "orangeSaucer", "purpleSaucer", "redSaucer", "yellowSaucer"]
    private let cupsArray = ["aquaCup", "blueCup", "greenCup", "orangeCup", "purpleCup", "redCup", "yellowCup"]
    private let spoonsArray = ["aquaSpoon", "blueSpoon", "greenSpoon", "orangeSpoon", "purpleSpoon", "redSpoon", "yellowSpoon"]
    
    var vaseIndex = 0
    var shuffledItemsArray = [String]()
    var objectColors = ColorsObjectDictionary()
    
    
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var vaseImageView: UIImageView!
    @IBOutlet weak var sauserImageView: UIImageView!
    @IBOutlet weak var cupImageView: UIImageView!
    @IBOutlet weak var spoonImageView: UIImageView!
    @IBOutlet weak var winningLabel: UILabel!
    @IBOutlet var buttonsArray: [UIButton]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupRandomVaseImage()
        setImagesForButtons(arrayName: sausersArray)
    }
    
    // MARK: - Utils
    
    func setupRandomVaseImage() {
        vaseIndex = Int(arc4random_uniform(7))
        vaseImageView.image = UIImage(named: vasesArray[vaseIndex])
    }
    
    func setImagesForButtons(arrayName: [String]) {
        
        //        MARK: - Generate random array
        var arrayNameCopy = arrayName
        var randomImagesArray = [String]()
        
        randomImagesArray.append(arrayNameCopy[vaseIndex])
        arrayNameCopy.remove(at: vaseIndex)
        while arrayNameCopy.count > 3 {
            let randomIndex = Int.random(in: 0..<arrayNameCopy.count)
            let removedItem = arrayNameCopy.remove(at: randomIndex)
            randomImagesArray.append(removedItem)
            shuffledItemsArray = randomImagesArray.shuffled()
        }
        //        MARK: - Set image for buttons
        var shuffledArrayIndex = 0
        
        for button in buttonsArray {
            button.setImage(UIImage(named: shuffledItemsArray[shuffledArrayIndex]), for: .normal)
            shuffledArrayIndex += 1
        }
    }
    
    func sauserSelection(_ sender: UIButton){
        let colorSaucers = objectColors.saucers
        for (saucerIndex, saucerColor) in colorSaucers {
            if saucerIndex == vaseIndex && UIImage(named: saucerColor) == buttonsArray[sender.tag-1].currentImage {
                sauserImageView.image = UIImage(named: saucerColor)
                sauserImageView.isHidden = false
                setImagesForButtons(arrayName: cupsArray)
            }
        }
    }
    
    func cupSelection(_ sender: UIButton){
        let colorCups = objectColors.cups
        for (cupIndex, cupColor) in colorCups {
            if cupIndex == vaseIndex && UIImage(named: cupColor) == buttonsArray[sender.tag-1].currentImage {
                cupImageView.image = UIImage(named: cupColor)
                cupImageView.isHidden = false
                setImagesForButtons(arrayName: spoonsArray)
            }
        }
    }
    
    func spoonSelection(_ sender: UIButton){
        let colorSpoons = objectColors.spoons
        for (spoonIndex, spoonColor) in colorSpoons {
            if spoonIndex == vaseIndex && UIImage(named: spoonColor) == buttonsArray[sender.tag-1].currentImage {
                spoonImageView.image = UIImage(named: spoonColor)
                spoonImageView.isHidden = false
                
                //                MARK: - Shows winning label and runs new game loop
                done()
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    self.setupRandomVaseImage()
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    self.setImagesForButtons(arrayName: self.sausersArray)
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    self.changeStatus()
                }
            }
        }
    }
    
    func done() {
        if sauserImageView.isHidden == false && cupImageView.isHidden == false && spoonImageView.isHidden == false {
            winningLabel.isHidden = false
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self.winningLabel.isHidden = true
            }
        }
    }
    
    func changeStatus() {
        sauserImageView.isHidden = true
        cupImageView.isHidden = true
        spoonImageView.isHidden = true
    }
    
    @IBAction func pressedButton(_ sender: UIButton) {
        if sauserImageView.isHidden == true && cupImageView.isHidden == true && spoonImageView.isHidden == true {
            sauserSelection(buttonsArray[sender.tag-1])
        } else if sauserImageView.isHidden == false && cupImageView.isHidden == true && spoonImageView.isHidden == true {
            cupSelection(buttonsArray[sender.tag-1])
        } else {
            spoonSelection(buttonsArray[sender.tag-1])
        }
    }
}
