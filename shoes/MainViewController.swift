//
//  MainViewController.swift
//  shoes
//
//  Created by 김동혁 on 2022/07/14.
//

import UIKit
import GoogleMobileAds

class MainViewController: UIViewController {
    
    private var status: [Status] = []
    private var diamondRewardedAd = DiamondRewardedAd()
    
    @IBOutlet weak var CurrentStatusView: UIView!
    @IBOutlet weak var CurrentMoneyLabel: UILabel!
    @IBOutlet weak var CurrentDiamondLabel: UILabel!
    @IBOutlet weak var GetMoneyButton: UIButton!
    @IBOutlet weak var ShoesImageView: UIImageView!
    @IBOutlet weak var LevelLabel: UILabel!
    @IBOutlet weak var ShoesNameLabel: UILabel!
    @IBOutlet weak var ProbablityLabel: UILabel!
    @IBOutlet weak var PriceView: UIView!
    @IBOutlet weak var ShoesPriceLabel: UILabel!
    @IBOutlet weak var UpgradeCostLabel: UILabel!
    @IBOutlet weak var GetDiamondButton: UIButton!
    @IBOutlet weak var Plus5Item: UIButton!
    @IBOutlet weak var Plus10Item: UIButton!
    @IBOutlet weak var Plus15Item: UIButton!
    @IBOutlet weak var UpgradeButton: UIButton!
    @IBOutlet weak var SellButton: UIButton!
    
    var currentMoney: UInt = 1000
    var currentDiamond: UInt = 0
    var shoesPrice: UInt = 2
    var upgradeProbablity: UInt = 100
    var currentProbablity: UInt = 100
    var upgradeCost: UInt = 1
    var level = 1
    
    let shoes = ["맨발", "짚신", "고무신", "슬리퍼", "크록스", "샌들"]
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        diamondRewardedAd.loadRewardedAd()
        
        status = UserDefaults.standard.status

        CurrentMoneyLabel.text = "남은 돈: \(status[0].currentMoney)"
        CurrentDiamondLabel.text = "다이아: \(status[0].currentDiamond)"
        LevelLabel.text = "레벨: \(status[0].level)"
        ShoesPriceLabel.text = "가격: \(status[0].shoesPrice)"
        UpgradeCostLabel.text = "강화비용: \(status[0].upgradeCost)"
        ProbablityLabel.text = "확률: \(status[0].upgradeProbablity)%"
        ShoesNameLabel.text = shoes[level - 1]
        
        currentMoney = status[0].currentMoney
        currentDiamond = status[0].currentDiamond
        level = status[0].level
        shoesPrice = status[0].shoesPrice
        upgradeCost = status[0].upgradeCost
        upgradeProbablity = status[0].upgradeProbablity
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        saveData()
    }
    
    @IBAction func tapGetMoneyButton(_ sender: Any) {
        if currentDiamond > 0 {
            currentDiamond -= 1
            CurrentDiamondLabel.text = "다이아: \(currentDiamond)"
            currentMoney += 1000
            CurrentMoneyLabel.text = "남은 돈: \(currentMoney)"
        }
        
        upgradeButtonToggle()
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
            if probablity < Float(upgradeProbablity) {
                upgrade()
                
                upgradeProbablity = 55
                ProbablityLabel.text = "확률: \(upgradeProbablity)%"
            } else {
                fail()
                alert()
            }
        } else if level == 3 {
            if probablity < Float(upgradeProbablity) {
                upgrade()
                
                upgradeProbablity = 50
                ProbablityLabel.text = "확률: \(upgradeProbablity)%"
            } else {
                fail()
                alert()
            }
        } else if level == 4 {
            if probablity < Float(upgradeProbablity) {
                upgrade()
                
                upgradeProbablity = 45
                ProbablityLabel.text = "확률: \(upgradeProbablity)%"
            } else {
                fail()
                alert()
            }
        } else if level == 5 {
            if probablity < Float(upgradeProbablity) {
                upgrade()
                
                upgradeProbablity = 40
                ProbablityLabel.text = "확률: \(upgradeProbablity)%"
            } else {
                fail()
                alert()
            }
        } else if level == 6 {
            if probablity < Float(upgradeProbablity) {
                upgrade()
            } else {
                fail()
                alert()
            }
        }
        
        upgradeButtonToggle()
        
        print(probablity)
    }
    
    @IBAction func tapGetDiamondButton(_ sender: Any) {
        diamondRewardedAd.showRewardedAd(vc: self)
        
        currentDiamond += 10
        CurrentDiamondLabel.text = "다이아: \(currentDiamond)"
    }
    
    
    @IBAction func tapSellButton(_ sender: Any) {
        currentMoney += UInt(shoesPrice)
        CurrentMoneyLabel.text = "남은 돈: \(currentMoney)"
        UpgradeButton.isEnabled = true
        
        reset()
    }
    
    @IBAction func tapPlus5Button(_ sender: Any) {
        ProbablityLabel.textColor = .systemRed
        currentProbablity = upgradeProbablity
        itemEnabled(false)
        SellButton.isEnabled = false
        
        upgradeProbablity += 5
        ProbablityLabel.text = "확률: \(upgradeProbablity)%"
    }
    
    @IBAction func tapPlus10Button(_ sender: Any) {
        ProbablityLabel.textColor = .systemRed
        currentProbablity = upgradeProbablity
        itemEnabled(false)
        SellButton.isEnabled = false

        upgradeProbablity += 10
        ProbablityLabel.text = "확률: \(upgradeProbablity)%"
    }

    @IBAction func tapPlus15Button(_ sender: Any) {
        ProbablityLabel.textColor = .systemRed
        currentProbablity = upgradeProbablity
        itemEnabled(false)
        SellButton.isEnabled = false

        upgradeProbablity += 15
        ProbablityLabel.text = "확률: \(upgradeProbablity)%"
    }
}

private extension MainViewController {
    func upgrade() {
        level += 1
        currentMoney -= UInt(upgradeCost)
        shoesPrice *= 4
        upgradeCost *= 2
        upgradeProbablity = currentProbablity
        
        CurrentMoneyLabel.text = "남은 돈: \(currentMoney)"
        CurrentDiamondLabel.text = "다이아: \(currentDiamond)"
        LevelLabel.text = "레벨: \(level)"
        ShoesNameLabel.text = shoes[level - 1]
        ShoesPriceLabel.text = "가격: \(shoesPrice)"
        UpgradeCostLabel.text = "강화비용: \(upgradeCost)"
                
        SellButton.isEnabled = true
        ProbablityLabel.textColor = .label
        itemEnabled(true)
    }
    
    func fail() {
        currentMoney -= UInt(upgradeCost)
        CurrentMoneyLabel.text = "남은 돈: \(currentMoney)"
        ProbablityLabel.text = "확률: \(upgradeProbablity)%"
        upgradeProbablity = currentProbablity
        
        itemEnabled(true)
    }
    
    func reset() {
        shoesPrice = 2
        upgradeProbablity = 100
        upgradeCost = 1
        level = 1
        currentProbablity = upgradeProbablity
        
        LevelLabel.text = "레벨: \(level)"
        ShoesPriceLabel.text = "가격: \(shoesPrice)"
        UpgradeCostLabel.text = "강화비용: \(upgradeCost)"
        ProbablityLabel.text = "확률: \(upgradeProbablity)%"
        ShoesNameLabel.text = shoes[level - 1]
        
        ProbablityLabel.textColor = .label

        upgradeButtonToggle()
        itemEnabled(true)
    }
    
    func retry() {
//        upgradeProbablity = currentProbablity
        currentMoney -= UInt((shoesPrice / 3))
        CurrentMoneyLabel.text = "남은 돈: \(currentMoney)"
        ProbablityLabel.text = "확률: \(currentProbablity)%"
        ProbablityLabel.textColor = .label

        saveData()
        
        upgradeButtonToggle()
        itemEnabled(true)
    }
    
    func alert() {
        let alert = UIAlertController(
            title: "실패 😭",
            message: """
            강화를 실패했습니다.
            재시도 비용 \(shoesPrice / 3)원.
            """,
            preferredStyle: .alert
        )
        
        let resetAction = UIAlertAction(title: "처음으로", style: .cancel) { _ in
            self.reset()
            self.SellButton.isEnabled = true
        }
        
        let retryAction = UIAlertAction(title: "재시도", style: .default) { _ in
            self.retry()
            self.SellButton.isEnabled = false
        }
        
        [resetAction, retryAction].forEach { alert.addAction($0) }
        
        present(alert, animated: true) {
            let retryCost = self.shoesPrice / 3
            
            /*
             재시도 비용 > 남은 돈 이거나 강화비용 > (남은 돈 - 재시도 비용) 이면 재시도버튼 비활성화
             */
            if retryCost > self.currentMoney || self.upgradeCost > (self.currentMoney - retryCost) {
                retryAction.isEnabled = false
            }
        }
    }
    
    func itemEnabled(_ bool: Bool) {
        [Plus5Item, Plus10Item, Plus15Item].forEach { $0?.isEnabled = bool }
    }
    
    func upgradeButtonToggle() {
        if currentMoney < upgradeCost {
            UpgradeButton.isEnabled = false
            itemEnabled(false)
        } else {
            UpgradeButton.isEnabled = true
            itemEnabled(true)
        }
    }
    
    func saveData() {
        let currentData = Status(currentMoney: currentMoney, currentDiamond: currentDiamond, shoesPrice: shoesPrice, upgradeProbablity: upgradeProbablity, upgradeCost: upgradeCost, level: level, shoes: shoes[level - 1])
        
        UserDefaults.standard.status = [currentData]
    }
}
