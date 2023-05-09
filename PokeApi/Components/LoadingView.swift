//
//  LoadingView.swift
//  PokeApi
//
//  Created by Parris Louis  on 9/5/23.
//

import Foundation
 

import UIKit

class LoadingView: NSObject {
    
    static let LoadingImageSize:CGFloat = 60
    static let RedLoadingImageSize:CGFloat = 90
    static let LoadingMarginFromTopMultiplier:CGFloat = 1/1.7
    static let LoadingMarginFromCenter:CGFloat = 40
 
    struct PullRefreshImgs {
        static let IMGS = [UIImage(named: "loading1")!, UIImage(named: "loading2")!, UIImage(named: "loading3")!, UIImage(named: "loading4")!, UIImage(named: "loading5")!, UIImage(named: "loading6")!, UIImage(named: "loading7")!, UIImage(named: "loading8")!, UIImage(named: "loading9")!, UIImage(named: "loading10")!, UIImage(named: "loading11")!, UIImage(named: "loading12")!, UIImage(named: "loading13")!, UIImage(named: "loading14")!, UIImage(named: "loading15")!, UIImage(named: "loading16")!, UIImage(named: "loading17")!, UIImage(named: "loading18")!, UIImage(named: "loading19")!, UIImage(named: "loading20")!]
    }
    
    static func animateRedLoading(loading: UIImageView) {
        
        UIView.animate(withDuration: 0.5, animations: {
            loading.transform = loading.transform.rotated(by: CGFloat(Double.pi))
        }) { (finished) in
            animateRedLoading(loading: loading)
        }
    }
    
    static func showLoading(_ viewController: UIViewController, mssg: String? = nil) -> UIView {
        let width = viewController.view.frame.size.width
        let loading = UIImageView.init(frame: CGRect.init(x: width/2.0 - LoadingImageSize/2.0 + 1, y: width*LoadingMarginFromTopMultiplier, width: LoadingImageSize, height: LoadingImageSize))
        let statusLabel = UILabel(frame: CGRect(x: 0, y: width * LoadingMarginFromTopMultiplier + LoadingImageSize + 10, width: width, height: 40))
        loading.animationImages = PullRefreshImgs.IMGS
        loading.animationRepeatCount = 0
        loading.animationDuration = 1
        loading.alpha = 0
        loading.startAnimating()
        let bg = UIView(frame: viewController.view.frame)
        bg.backgroundColor = .black
        bg.alpha = 0.5
        bg.addSubview(loading)
        if let status = mssg {
            statusLabel.text = status
            statusLabel.textAlignment = .center
            bg.addSubview(statusLabel)
        }
        viewController.view.addSubview(bg)
        UIView.animate(withDuration: 0.4, animations: {
            loading.alpha = 1
        })
        return bg
    }
  
}
