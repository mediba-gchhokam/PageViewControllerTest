//
//  PageViewController.swift
//  PageViewControllerTest
//
//  Created by 岡本洋明 on 2017/05/28.
//  Copyright © 2017年 岡本洋明. All rights reserved.
//

import UIKit

protocol ScrollTabPageViewControllerProtocol {
    var scrollTabPageViewController: ScrollTabPageViewController { get }
    var scrollView: UIScrollView { get }
}


class ScrollTabPageViewController: UIPageViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setViewControllers([getFirst()], direction: .forward, animated: true, completion: nil)
        self.dataSource = self
    }
    
    func getFirst() -> FirstViewController {
        return storyboard!.instantiateViewController(withIdentifier: "FirstViewController") as! FirstViewController
    }

    func getSecond() -> SecondViewController {
        return storyboard!.instantiateViewController(withIdentifier: "SecondViewController") as! SecondViewController
    }
    
    func getThird() -> ThirdViewController {
        return storyboard!.instantiateViewController(withIdentifier: "ThirdViewController") as! ThirdViewController
    }
    
    func updateContentViewFrame() {
        /*
        guard let currentIndex = currentIndex, let vc = pageViewControllers[currentIndex] as? ScrollTabPageViewControllerProtocol else {
            return
        }
        
        if vc.scrollView.contentOffset.y >= -tabViewHeight {
            let scroll = contentViewHeihgt - tabViewHeight
            updateContentView(-scroll)
            vc.scrollView.scrollIndicatorInsets.top = tabViewHeight
        } else {
            let scroll = contentViewHeihgt + vc.scrollView.contentOffset.y
            updateContentView(-scroll)
            vc.scrollView.scrollIndicatorInsets.top = -vc.scrollView.contentOffset.y
        }
 */
    }
 
    
    func updateLayoutIfNeeded() {
        /*
        if shouldUpdateLayout {
            let vc = pageViewControllers[updateIndex] as? ScrollTabPageViewControllerProtocol
            let shouldSetupContentOffsetY = vc?.scrollView.contentInset.top != contentViewHeihgt
            
            let scroll = scrollContentOffsetY
            setupContentInset()
            setupContentOffsetY(updateIndex, scroll: -scroll)
            shouldUpdateLayout = shouldSetupContentOffsetY
        }
 */
    }
}

extension ScrollTabPageViewController : UIPageViewControllerDataSource {
    
    public func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController?
    {
        if viewController is ThirdViewController
        {
            return getSecond()
        } else if viewController is SecondViewController
        {
            return getFirst()
        }
        else if viewController is FirstViewController
        {
            return getThird()
        }
        else {
            return nil
        }
    }
    
    public func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController?
    {
        if viewController is FirstViewController
        {
            return getSecond()
        } else if viewController is SecondViewController
        {
            return getThird()
        }else if viewController is ThirdViewController
        {
            return getFirst()
        } else {
            return nil
        }
    }
}
