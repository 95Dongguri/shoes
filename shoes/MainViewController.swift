//
//  MainViewController.swift
//  shoes
//
//  Created by 김동혁 on 2022/07/14.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet weak var CurrentStatusView: UIView!
    @IBOutlet weak var CurrentMoneyLabel: UILabel!
    @IBOutlet weak var CurrentDiamondLabel: UILabel!
    @IBOutlet weak var ShoesImageView: UIImageView!
    @IBOutlet weak var LevelLabel: UILabel!
    @IBOutlet weak var ShoesNameLabel: UILabel!
    @IBOutlet weak var ProbablityLabel: UILabel!
    @IBOutlet weak var PriceView: UIView!
    @IBOutlet weak var ShoesPriceLabel: UILabel!
    @IBOutlet weak var UpgradeCostLabel: UILabel!
    @IBOutlet weak var UpgradeButton: UIButton!
    @IBOutlet weak var SellButton: UIButton!
    
    var currentMoney = 10000
    var currentDiamond = 0
    var shoesPrice = 2
    var upgradeProbablity = 100
    var upgradeCost = 1
    var level = 1
    
    let shoes = ["맨발", "짚신", "고무신", "슬리퍼", "크록스", "샌들"]
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        CurrentMoneyLabel.text = "남은 돈: \(currentMoney)"
        CurrentDiamondLabel.text = "다이아: \(currentDiamond)"
        LevelLabel.text = "레벨: \(level)"
        ShoesPriceLabel.text = "가격: \(shoesPrice)"
        UpgradeCostLabel.text = "강화비용: \(upgradeCost)"
        ProbablityLabel.text = "확률: \(upgradeProbablity)%"
        ShoesNameLabel.text = shoes[0]
    }

    @IBAction func tapUpgradeButton(_ sender: Any) {
        /*
         1 - 100%
         2 - 96%
         3 - 92%
         4 - 88%
         5 - 84%
         6 - 80%
         7 - 75%
         8 - 70%
         9 - 65%
         10 - 60%
         11 - 55%
         12 - 50%
         13 - 45%
         14 - 40%
         15 - 35%
         16 - 30%
         17 - 27%
         18 - 24%
         19 - 21%
         20 - 18%
         21 - 15%
         22 - 12%
         23 - 10%
         24 - 8%
         25 - 6%
         26 - 4%
         27 - 2%
         28 - 1%
         */
        
        let probablity = Float.random(in: 0...1) * 100
                
        if level == 1 {
            upgrade()
            
            upgradeProbablity = 60
            ProbablityLabel.text = "확률: \(upgradeProbablity)%"
        } else if level == 2 { // 96 %
            if probablity > Float(upgradeProbablity) {
                upgrade()
                
                upgradeProbablity = 55
                ProbablityLabel.text = "확률: \(upgradeProbablity)%"
            } else {
                fail()
                alert()
            }
        } else if level == 3 {
            if probablity > Float(upgradeProbablity) {
                upgrade()
                
                upgradeProbablity = 50
                ProbablityLabel.text = "확률: \(upgradeProbablity)%"
            } else {
                fail()
                alert()
            }
        } else if level == 4 {
            if probablity > Float(upgradeProbablity) {
                upgrade()
                
                upgradeProbablity = 45
                ProbablityLabel.text = "확률: \(upgradeProbablity)%"
            } else {
                fail()
                alert()
            }
        } else if level == 5 {
            if probablity > Float(upgradeProbablity) {
                upgrade()
                
                upgradeProbablity = 40
                ProbablityLabel.text = "확률: \(upgradeProbablity)%"
            } else {
                fail()
                alert()
            }
        } else if level == 6 {
            if probablity > Float(upgradeProbablity) {
                upgrade()
            } else {
                fail()
                alert()
            }
        }
        
        print(probablity)
    }
    
    @IBAction func tapSellButton(_ sender: Any) {
        currentMoney += shoesPrice
        CurrentMoneyLabel.text = "남은 돈: \(currentMoney)"
        
        reset()
    }
    
    func reset() {
        shoesPrice = 2
        upgradeProbablity = 100
        upgradeCost = 1
        level = 1
        LevelLabel.text = "레벨: \(level)"
        ShoesPriceLabel.text = "가격: \(shoesPrice)"
        UpgradeCostLabel.text = "강화비용: \(upgradeCost)"
        ProbablityLabel.text = "확률: \(upgradeProbablity)%"
        ShoesNameLabel.text = shoes[level - 1]
    }
    
    func upgrade() {
        level += 1
        currentMoney -= upgradeCost
        shoesPrice *= 4
        upgradeCost *= 2
        
        CurrentMoneyLabel.text = "남은 돈: \(currentMoney)"
        CurrentDiamondLabel.text = "다이아: \(currentDiamond)"
        LevelLabel.text = "레벨: \(level)"
        ShoesNameLabel.text = shoes[level - 1]
        ShoesPriceLabel.text = "가격: \(shoesPrice)"
        UpgradeCostLabel.text = "강화비용: \(upgradeCost)"
        
        SellButton.isEnabled = true
    }
    
    func sellButtonisEnabled() {
        SellButton.isEnabled = false
    }
    
    func fail() {
        currentMoney -= upgradeCost
        CurrentMoneyLabel.text = "남은 돈: \(currentMoney)"
    }
    
    func alert() {
        let alert = UIAlertController(title: "실패 😭", message: "강화를 실패했습니다.", preferredStyle: .alert)
        
        let resetAction = UIAlertAction(title: "처음으로", style: .cancel) { _ in
            self.reset()
        }
        let retryAction = UIAlertAction(title: "재시도", style: .default) { _ in
            self.sellButtonisEnabled()
        }
        
        [resetAction, retryAction].forEach { alert.addAction($0) }
        
        present(alert, animated: true)
    }
}
