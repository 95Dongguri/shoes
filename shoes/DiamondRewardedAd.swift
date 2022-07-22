//
//  DiamondRewardedAd.swift
//  shoes
//
//  Created by 김동혁 on 2022/07/22.
//

import GoogleMobileAds

class DiamondRewardedAd: NSObject, GADFullScreenContentDelegate {
    private var rewardedAd: GADRewardedAd?
    
    func loadRewardedAd() {
        let request = GADRequest()
        
        GADRewardedAd.load(
            withAdUnitID: "ca-app-pub-3940256099942544/5224354917",
            request: request) { [self] ad, error in
                if let error = error {
                    print("광고 불러오기 실패: \(error.localizedDescription)")
                    return
                }
                
                rewardedAd = ad
                rewardedAd?.fullScreenContentDelegate = self
            }
    }
    
    func adDidDismissFullScreenContent(_ ad: GADFullScreenPresentingAd) {
        loadRewardedAd()
    }
    
    func showRewardedAd(vc: UIViewController) {
        if rewardedAd != nil {
            rewardedAd!.present(fromRootViewController: vc, userDidEarnRewardHandler: {
                let reward = self.rewardedAd!.adReward
                print("\(reward.amount), \(reward.type)")
            })
        } else {
            print("광고가 준비되지 않았습니다.")
        }
    }
}
