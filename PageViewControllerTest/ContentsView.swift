//
//  ContentsView.swift
//  PageViewControllerTest
//
//  Created by 岡本洋明 on 2017/05/28.
//  Copyright © 2017年 岡本洋明. All rights reserved.
//

import UIKit

class ContentsView: UIView {
    
    @IBOutlet weak var containerView: UIView!
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet var tabButtons: [UIButton]!
    
    
    var currentIndex: Int = 0
    var tabButtonPressedBlock: ((_ index: Int) -> Void)?
    var scrollDidChangedBlock: ((_ scroll: CGFloat, _ shouldScroll: Bool) -> Void)?
    
    fileprivate var scrollStart: CGFloat = 0.0



    override func awakeFromNib() {
        super.awakeFromNib()
        
        scrollView.delegate = self
        scrollView.scrollsToTop = false
    }
}

// MARK: - View

extension ContentsView {
    
    fileprivate func randomColor() -> UIColor {
        let red = Float(arc4random_uniform(255)) / 255.0
        let green = Float(arc4random_uniform(255)) / 255.0
        let blue = Float(arc4random_uniform(255)) / 255.0
        return UIColor(colorLiteralRed: red, green: green, blue: blue, alpha: 1.0)
    }
    
    func updateCurrentIndex(_ index: Int, animated: Bool) {
        tabButtons[index].backgroundColor = UIColor(red: 0.88, green: 1.0, blue: 0.87, alpha: 1.0)
        currentIndex = index
    }
}

// MARK: - UIScrollViewDelegate

extension ContentsView: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        // 画面の上に消えている場合
        if scrollView.contentOffset.y > 0.0 || frame.minY < 0.0 {
            scrollDidChangedBlock?(scrollView.contentOffset.y, true)
            scrollView.contentOffset.y = 0.0
        }
        else {
            // 前回呼び出された時からどれだけ下に引っ張ったか
            let scroll = scrollView.contentOffset.y - scrollStart
            
            scrollDidChangedBlock?(scroll, false)
            
            // 次に呼びされる時のためにリセット
            scrollStart = scrollView.contentOffset.y
        }
    }
}


// MARK: - IBAction

extension ContentsView {
    
    @IBAction fileprivate func tabButtonTouchUpInside(_ button: UIButton) {
        tabButtonPressedBlock?(button.tag)
        updateCurrentIndex(button.tag, animated: true)
    }
}
