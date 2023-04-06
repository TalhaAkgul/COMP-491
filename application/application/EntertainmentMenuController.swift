//
//  EntertainmentMenuController.swift
//  application
//
//  Created by Doga Ege Inhanli on 3.04.2023.
//

import UIKit

class EntertainmentMenuController: UIViewController {
    @IBOutlet weak var entPhoto1: UIImageView!
    @IBOutlet weak var entPhoto2: UIImageView!
    @IBOutlet weak var entPhoto3: UIImageView!
    @IBOutlet weak var entPhoto4: UIImageView!
    @IBOutlet weak var entPhoto5: UIImageView!
    @IBOutlet weak var entPhoto6: UIImageView!
    @IBOutlet weak var entPhoto7: UIImageView!
    @IBOutlet weak var entPhoto8: UIImageView!
    @IBOutlet weak var entPhoto9: UIImageView!
    @IBOutlet weak var entPhoto10: UIImageView!
    @IBOutlet weak var entPhoto11: UIImageView!
    @IBOutlet weak var entPhoto12: UIImageView!
    @IBOutlet weak var entPhoto13: UIImageView!
    @IBOutlet weak var entPhoto14: UIImageView!
    @IBOutlet weak var entPhoto15: UIImageView!
    @IBOutlet weak var entPhoto16: UIImageView!
    
    @IBOutlet weak var plusButton1: UIButton!
    @IBOutlet weak var plusButton2: UIButton!
    @IBOutlet weak var plusButton3: UIButton!
    @IBOutlet weak var plusButton4: UIButton!
    @IBOutlet weak var plusButton5: UIButton!
    @IBOutlet weak var plusButton6: UIButton!
    @IBOutlet weak var plusButton7: UIButton!
    @IBOutlet weak var plusButton8: UIButton!
    @IBOutlet weak var plusButton9: UIButton!
    @IBOutlet weak var plusButton10: UIButton!
    @IBOutlet weak var plusButton11: UIButton!
    @IBOutlet weak var plusButton12: UIButton!
    @IBOutlet weak var plusButton13: UIButton!
    @IBOutlet weak var plusButton14: UIButton!
    @IBOutlet weak var plusButton15: UIButton!
    @IBOutlet weak var plusButton16: UIButton!
    
    @IBOutlet weak var minusButton1: UIButton!
    @IBOutlet weak var minusButton2: UIButton!
    @IBOutlet weak var minusButton3: UIButton!
    @IBOutlet weak var minusButton4: UIButton!
    @IBOutlet weak var minusButton5: UIButton!
    @IBOutlet weak var minusButton6: UIButton!
    @IBOutlet weak var minusButton7: UIButton!
    @IBOutlet weak var minusButton8: UIButton!
    @IBOutlet weak var minusButton9: UIButton!
    @IBOutlet weak var minusButton10: UIButton!
    @IBOutlet weak var minusButton11: UIButton!
    @IBOutlet weak var minusButton12: UIButton!
    @IBOutlet weak var minusButton13: UIButton!
    @IBOutlet weak var minusButton14: UIButton!
    @IBOutlet weak var minusButton15: UIButton!
    @IBOutlet weak var minusButton16: UIButton!
    
    @IBOutlet weak var count1: UILabel!
    @IBOutlet weak var count2: UILabel!
    @IBOutlet weak var count3: UILabel!
    @IBOutlet weak var count4: UILabel!
    @IBOutlet weak var count5: UILabel!
    @IBOutlet weak var count6: UILabel!
    @IBOutlet weak var count7: UILabel!
    @IBOutlet weak var count8: UILabel!
    @IBOutlet weak var count9: UILabel!
    @IBOutlet weak var count10: UILabel!
    @IBOutlet weak var count11: UILabel!
    @IBOutlet weak var count12: UILabel!
    @IBOutlet weak var count13: UILabel!
    @IBOutlet weak var count14: UILabel!
    @IBOutlet weak var count15: UILabel!
    @IBOutlet weak var count16: UILabel!
    var countLabels = [UILabel]()
    var plusButtons = [UIButton]()
    var minusButtons = [UIButton]()
    override func viewDidLoad() {
        super.viewDidLoad()
        entPhoto1.image = UIImage(named: "images/entertainment menu images/album-daisies.jpg")
        entPhoto2.image = UIImage(named: "images/entertainment menu images/album-legacy.jpg")
        entPhoto3.image = UIImage(named: "images/entertainment menu images/album-neveragain.jpg")
        entPhoto4.image = UIImage(named: "images/entertainment menu images/album-pixels.jpg")
        entPhoto5.image = UIImage(named: "images/entertainment menu images/book-anchor.jpg")
        entPhoto6.image = UIImage(named: "images/entertainment menu images/book-flyinghigh.jpg")
        entPhoto7.image = UIImage(named: "images/entertainment menu images/book-mind.jpg")
        entPhoto8.image = UIImage(named: "images/entertainment menu images/book-oldtimes.jpg")
        entPhoto9.image = UIImage(named: "images/entertainment menu images/film-newworld.jpg")
        entPhoto10.image = UIImage(named: "images/entertainment menu images/film-ourstory.jpg")
        entPhoto11.image = UIImage(named: "images/entertainment menu images/game-maze.jpg")
        entPhoto12.image = UIImage(named: "images/entertainment menu images/game-race.jpg")
        entPhoto13.image = UIImage(named: "images/entertainment menu images/game-trivia.jpg")
        entPhoto14.image = UIImage(named: "images/entertainment menu images/game-war.jpg")
        entPhoto15.image = UIImage(named: "images/entertainment menu images/magazine-inflight.jpg")
        entPhoto16.image = UIImage(named: "images/entertainment menu images/magazine-mosaic.jpg")
        plusButtons.append(contentsOf: [plusButton1,plusButton2,plusButton3,plusButton4,plusButton5,plusButton6,plusButton7,plusButton8,plusButton9,plusButton10,plusButton11,plusButton12,plusButton13,plusButton14,plusButton15,plusButton16])
        for i in plusButtons.indices {
            plusButtons[i].tag = (i+1) * 2
        }
        minusButtons.append(contentsOf: [minusButton1,minusButton2,minusButton3,minusButton4,minusButton5,minusButton6,minusButton7,minusButton8,minusButton9,minusButton10,minusButton11,minusButton12,minusButton13,minusButton14,minusButton15,minusButton16])
        for i in minusButtons.indices {
            minusButtons[i].tag = (i+1) * 2 + 1
        }
        countLabels.append(contentsOf: [count1,count2,count3,count4,count5,count6,count7,count8,count9,count10,count11,count12,count13,count14,count15, count16])
    }
    @IBAction func buttonClicked(_ sender: UIButton) {
        let senderInfo = sender.self.tag
        if(senderInfo % 2 == 0){
            var value = Int(countLabels[senderInfo/2 - 1].text!) ?? 0
            value += 1
            countLabels[senderInfo/2 - 1].text = "\(value)"
        } else {
            var value = Int(countLabels[(senderInfo-1)/2 - 1].text!) ?? 0
            if(value > 0){
                value -= 1
                countLabels[(senderInfo-1)/2 - 1].text = "\(value)"
            }
        }
    }
    
}
