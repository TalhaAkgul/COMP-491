//
//  FoodDrinkMenuController.swift
//  passengerApp
//
//  Created by Doga Ege Inhanli on 15.04.2023.
//

import UIKit
import SQLite

class FoodDrinkMenuController: UIViewController {

    var database: Connection!
    let productsTable = Table("Products")
    let productId = Expression<Int>("productId")
    let productName = Expression<String>("productName")
    let productType = Expression<String>("productType")
    let count = Expression<Int>("count")
    let price = Expression<Double>("price")
    
    @IBOutlet weak var foodPhoto1: UIImageView!
    @IBOutlet weak var foodPhoto2: UIImageView!
    @IBOutlet weak var foodPhoto3: UIImageView!
    @IBOutlet weak var foodPhoto4: UIImageView!
    @IBOutlet weak var foodPhoto5: UIImageView!
    @IBOutlet weak var foodPhoto6: UIImageView!
    @IBOutlet weak var foodPhoto7: UIImageView!
    @IBOutlet weak var foodPhoto8: UIImageView!
    @IBOutlet weak var foodPhoto9: UIImageView!
    @IBOutlet weak var foodPhoto10: UIImageView!
    @IBOutlet weak var foodPhoto11: UIImageView!
    @IBOutlet weak var foodPhoto12: UIImageView!
    @IBOutlet weak var foodPhoto13: UIImageView!
    @IBOutlet weak var foodPhoto14: UIImageView!
    @IBOutlet weak var foodPhoto15: UIImageView!
    @IBOutlet weak var foodPhoto16: UIImageView!
    @IBOutlet weak var foodPhoto17: UIImageView!
    @IBOutlet weak var foodPhoto18: UIImageView!
    @IBOutlet weak var foodPhoto19: UIImageView!
    @IBOutlet weak var foodPhoto20: UIImageView!
    @IBOutlet weak var foodPhoto21: UIImageView!
    @IBOutlet weak var foodPhoto22: UIImageView!
    @IBOutlet weak var foodPhoto23: UIImageView!
    @IBOutlet weak var foodPhoto24: UIImageView!
    @IBOutlet weak var foodPhoto25: UIImageView!
    @IBOutlet weak var foodPhoto26: UIImageView!
    @IBOutlet weak var foodPhoto27: UIImageView!
    @IBOutlet weak var foodPhoto28: UIImageView!
    @IBOutlet weak var foodPhoto29: UIImageView!
    @IBOutlet weak var foodPhoto30: UIImageView!
    @IBOutlet weak var foodPhoto31: UIImageView!
    @IBOutlet weak var foodPhoto32: UIImageView!
    @IBOutlet weak var foodPhoto33: UIImageView!
    @IBOutlet weak var foodPhoto34: UIImageView!
    @IBOutlet weak var foodPhoto35: UIImageView!
    @IBOutlet weak var foodPhoto36: UIImageView!
    //Plus buttons
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
    @IBOutlet weak var plusButton17: UIButton!
    @IBOutlet weak var plusButton18: UIButton!
    @IBOutlet weak var plusButton19: UIButton!
    @IBOutlet weak var plusButton20: UIButton!
    @IBOutlet weak var plusButton21: UIButton!
    @IBOutlet weak var plusButton22: UIButton!
    @IBOutlet weak var plusButton23: UIButton!
    @IBOutlet weak var plusButton24: UIButton!
    @IBOutlet weak var plusButton25: UIButton!
    @IBOutlet weak var plusButton26: UIButton!
    @IBOutlet weak var plusButton27: UIButton!
    @IBOutlet weak var plusButton28: UIButton!
    @IBOutlet weak var plusButton29: UIButton!
    @IBOutlet weak var plusButton30: UIButton!
    @IBOutlet weak var plusButton31: UIButton!
    @IBOutlet weak var plusButton32: UIButton!
    @IBOutlet weak var plusButton33: UIButton!
    @IBOutlet weak var plusButton34: UIButton!
    @IBOutlet weak var plusButton35: UIButton!
    @IBOutlet weak var plusButton36: UIButton!
    //Minus buttons
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
    @IBOutlet weak var minusButton17: UIButton!
    @IBOutlet weak var minusButton18: UIButton!
    @IBOutlet weak var minusButton19: UIButton!
    @IBOutlet weak var minusButton20: UIButton!
    @IBOutlet weak var minusButton21: UIButton!
    @IBOutlet weak var minusButton22: UIButton!
    @IBOutlet weak var minusButton23: UIButton!
    @IBOutlet weak var minusButton24: UIButton!
    @IBOutlet weak var minusButton25: UIButton!
    @IBOutlet weak var minusButton26: UIButton!
    @IBOutlet weak var minusButton27: UIButton!
    @IBOutlet weak var minusButton28: UIButton!
    @IBOutlet weak var minusButton29: UIButton!
    @IBOutlet weak var minusButton30: UIButton!
    @IBOutlet weak var minusButton31: UIButton!
    @IBOutlet weak var minusButton32: UIButton!
    @IBOutlet weak var minusButton33: UIButton!
    @IBOutlet weak var minusButton34: UIButton!
    @IBOutlet weak var minusButton35: UIButton!
    @IBOutlet weak var minusButton36: UIButton!
    
    //Count labels
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
    @IBOutlet weak var count17: UILabel!
    @IBOutlet weak var count18: UILabel!
    @IBOutlet weak var count19: UILabel!
    @IBOutlet weak var count20: UILabel!
    @IBOutlet weak var count21: UILabel!
    @IBOutlet weak var count22: UILabel!
    @IBOutlet weak var count23: UILabel!
    @IBOutlet weak var count24: UILabel!
    @IBOutlet weak var count25: UILabel!
    @IBOutlet weak var count26: UILabel!
    @IBOutlet weak var count27: UILabel!
    @IBOutlet weak var count28: UILabel!
    @IBOutlet weak var count29: UILabel!
    @IBOutlet weak var count30: UILabel!
    @IBOutlet weak var count31: UILabel!
    @IBOutlet weak var count32: UILabel!
    @IBOutlet weak var count33: UILabel!
    @IBOutlet weak var count34: UILabel!
    @IBOutlet weak var count35: UILabel!
    @IBOutlet weak var count36: UILabel!
    
    @IBOutlet weak var price1: UILabel!
    @IBOutlet weak var price2: UILabel!
    @IBOutlet weak var price3: UILabel!
    @IBOutlet weak var price4: UILabel!
    @IBOutlet weak var price5: UILabel!
    @IBOutlet weak var price6: UILabel!
    @IBOutlet weak var price7: UILabel!
    @IBOutlet weak var price8: UILabel!
    @IBOutlet weak var price9: UILabel!
    @IBOutlet weak var price10: UILabel!
    @IBOutlet weak var price11: UILabel!
    @IBOutlet weak var price12: UILabel!
    @IBOutlet weak var price13: UILabel!
    @IBOutlet weak var price14: UILabel!
    @IBOutlet weak var price15: UILabel!
    @IBOutlet weak var price16: UILabel!
    @IBOutlet weak var price17: UILabel!
    @IBOutlet weak var price18: UILabel!
    @IBOutlet weak var price19: UILabel!
    @IBOutlet weak var price20: UILabel!
    @IBOutlet weak var price21: UILabel!
    @IBOutlet weak var price22: UILabel!
    @IBOutlet weak var price23: UILabel!
    @IBOutlet weak var price24: UILabel!
    @IBOutlet weak var price25: UILabel!
    @IBOutlet weak var price26: UILabel!
    @IBOutlet weak var price27: UILabel!
    @IBOutlet weak var price28: UILabel!
    @IBOutlet weak var price29: UILabel!
    @IBOutlet weak var price30: UILabel!
    @IBOutlet weak var price31: UILabel!
    @IBOutlet weak var price32: UILabel!
    @IBOutlet weak var price33: UILabel!
    @IBOutlet weak var price34: UILabel!
    @IBOutlet weak var price35: UILabel!
    @IBOutlet weak var price36: UILabel!
    var priceLabels = [UILabel]()
    var countLabels = [UILabel]()
    var plusButtons = [UIButton]()
    var minusButtons = [UIButton]()
    override func viewDidLoad() {
        super.viewDidLoad()
        connectDatabase()
        foodPhoto1.image = UIImage(named: "images/food menu images/foods/avocadobowl.png")
        foodPhoto2.image = UIImage(named: "images/food menu images/foods/baconwrap.png")
        foodPhoto3.image = UIImage(named: "images/food menu images/foods/chickenwrap.png")
        foodPhoto4.image = UIImage(named: "images/food menu images/foods/croissantsandwich.png")
        foodPhoto5.image = UIImage(named: "images/food menu images/foods/englishbreakfast.png")
        foodPhoto6.image = UIImage(named: "images/food menu images/foods/fishandchips.png")
        foodPhoto7.image = UIImage(named: "images/food menu images/foods/greensalad.png")
        foodPhoto8.image = UIImage(named: "images/food menu images/foods/hamcheesesandwich.png")
        foodPhoto9.image = UIImage(named: "images/food menu images/foods/meditarreniansalad.png")
        foodPhoto10.image = UIImage(named: "images/food menu images/foods/pancakes.png")
        foodPhoto11.image = UIImage(named: "images/food menu images/foods/schnitzel.png")
        foodPhoto12.image = UIImage(named: "images/food menu images/foods/simplebreakfast.png")
        foodPhoto13.image = UIImage(named: "images/food menu images/foods/steak.png")
        foodPhoto14.image = UIImage(named: "images/food menu images/foods/vegetarianwrap.png")
        foodPhoto15.image = UIImage(named: "images/food menu images/snacks/apple.png")
        foodPhoto16.image = UIImage(named: "images/food menu images/snacks/banana.png")
        foodPhoto17.image = UIImage(named: "images/food menu images/snacks/bluberryuffin.png")
        foodPhoto18.image = UIImage(named: "images/food menu images/snacks/chips.png")
        foodPhoto19.image = UIImage(named: "images/food menu images/snacks/chocolatebar.png")
        foodPhoto20.image = UIImage(named: "images/food menu images/snacks/chocolatedonut.png")
        foodPhoto21.image = UIImage(named: "images/food menu images/snacks/icecream.png")
        foodPhoto22.image = UIImage(named: "images/food menu images/snacks/proteinbar.png")
        foodPhoto23.image = UIImage(named: "images/food menu images/snacks/rubychocolatedonut.png")
        foodPhoto24.image = UIImage(named: "images/food menu images/drinks/americano.png")
        foodPhoto25.image = UIImage(named: "images/food menu images/drinks/beer.png")
        foodPhoto26.image = UIImage(named: "images/food menu images/drinks/cappucino.png")
        foodPhoto27.image = UIImage(named: "images/food menu images/drinks/coke.png")
        foodPhoto28.image = UIImage(named: "images/food menu images/drinks/gintonic.png")
        foodPhoto29.image = UIImage(named: "images/food menu images/drinks/latte.png")
        foodPhoto30.image = UIImage(named: "images/food menu images/drinks/mimosa.png")
        foodPhoto31.image = UIImage(named: "images/food menu images/drinks/multifruitjuice.png")
        foodPhoto32.image = UIImage(named: "images/food menu images/drinks/orangejuice.png")
        foodPhoto33.image = UIImage(named: "images/food menu images/drinks/red wine.png")
        foodPhoto34.image = UIImage(named: "images/food menu images/drinks/rose wine.png")
        foodPhoto35.image = UIImage(named: "images/food menu images/drinks/tea.png")
        foodPhoto36.image = UIImage(named: "images/food menu images/drinks/white wine.png")
        
        plusButtons.append(contentsOf: [plusButton1,plusButton2,plusButton3,plusButton4,plusButton5,plusButton6,plusButton7,plusButton8,plusButton9,plusButton10,plusButton11,plusButton12,plusButton13,plusButton14,plusButton15])
        plusButtons.append(contentsOf: [plusButton16,plusButton17,plusButton18,plusButton19,plusButton20,plusButton21,plusButton22,plusButton23,plusButton24,plusButton25,plusButton26,plusButton27,plusButton28,plusButton29])
        plusButtons.append(contentsOf: [plusButton30,plusButton31,plusButton32,plusButton33,plusButton34,plusButton35,plusButton36])
        for i in plusButtons.indices {
            plusButtons[i].tag = (i+1) * 2
        }
        minusButtons.append(contentsOf: [minusButton1,minusButton2,minusButton3,minusButton4,minusButton5,minusButton6,minusButton7,minusButton8,minusButton9,minusButton10,minusButton11,minusButton12,minusButton13,minusButton14,minusButton15])
        minusButtons.append(contentsOf: [minusButton16,minusButton17,minusButton18,minusButton19,minusButton20,minusButton21,minusButton22,minusButton23,minusButton24,minusButton25,minusButton26,minusButton27,minusButton28,minusButton29])
        minusButtons.append(contentsOf: [minusButton30,minusButton31,minusButton32,minusButton33,minusButton34,minusButton35,minusButton36])
        for i in minusButtons.indices {
            minusButtons[i].tag = (i+1) * 2 + 1
        }
        
        countLabels.append(contentsOf: [count1,count2,count3,count4,count5,count6,count7,count8,count9,count10,count11,count12,count13,count14,count15])
        countLabels.append(contentsOf: [count16,count17,count18,count19,count20,count21,count22,count23,count24,count25,count26,count27,count28,count29])
        countLabels.append(contentsOf: [count30,count31,count32,count33,count34,count35,count36])
        
        priceLabels.append(contentsOf: [price1,price2,price3,price4,price5,price6,price7,price8,price9,price10,price11,price12,price13,price14,price15,price16])
        priceLabels.append(contentsOf: [price17,price18,price19,price20,price21,price22,price23,price24,price25,price26,price27,price28,price29,price30,price31,price32])
        priceLabels.append(contentsOf: [price33,price34,price35,price36])
       
        for i in countLabels.indices {
            do {
                let products = try self.database.prepare(self.productsTable.filter(self.productId == i + 22))
                for prod in products{
                    countLabels[i].text = String(prod[self.count])
                    priceLabels[i].text = String(prod[self.price]) + " ₺"
                }
            } catch {
                print(error)
            }
        }
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
    func connectDatabase(){
        do {
            let documentDirectory = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
            let fileUrl = documentDirectory.appendingPathComponent("Products").appendingPathExtension("sqlite3")
            let database = try Connection(fileUrl.path)
            self.database = database
        } catch {
            print(error)
        }
    }
    func updateTable(){
        
        do {
            let products = try self.database.prepare(self.productsTable.filter(self.productType == "Food Drink"))
            for product in products {
                let currentCount = Int(countLabels[product[self.productId] - 22].text!) ?? 0
                let updateProduct = self.productsTable.filter(self.productId == product[self.productId]).update(self.count <- currentCount)
                do {
                    try self.database.run(updateProduct)
                } catch {
                    print(error)
                }
            }
        } catch {
            print(error)
        }
    }
    @IBAction func addItemsButtonClicked(_ sender: UIButton) {
        updateTable()
    }
}























