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


class ScrollTabPageViewController: UIPageViewController, UIScrollViewDelegate {
    
//    fileprivate let contentViewHeihgt: CGFloat = 280.0
//    fileprivate let tabViewHeight: CGFloat = 44.0
//    fileprivate var pageViewControllers: [UIViewController] = []
//    fileprivate var contentsView: ContentsView!
//    fileprivate var scrollContentOffsetY: CGFloat = 0.0
    fileprivate var shouldScrollFrame: Bool = true  // contentViewが呼び出しごとに移動する距離
//    fileprivate var shouldUpdateLayout: Bool = false
//    fileprivate var updateIndex: Int = 0

    
    var profileHeader: ProfileHeaderView!
    
    private var firstVC : FirstViewController?
    private var secondVC : SecondViewController?
    private var thirdVC : ThirdViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let nib = UINib.init(nibName: "ProfileHeaderView", bundle: nil)
        profileHeader = nib.instantiate(withOwner: nil, options: nil).first as! ProfileHeaderView
        self.view.addSubview(profileHeader)

        self.setViewControllers([getFirst()], direction: .forward, animated: true, completion: nil)
        dataSource = self
   //     delegate = self
        
        setupprofileHeader()
        
        let scrollView = UIScrollView.init(frame: CGRect(x: 0, y: 0, width: 320, height: 200))
        self.view.addSubview(scrollView)
        scrollView.backgroundColor = UIColor.red
        scrollView.delegate = self

    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        print("きた")
    }
    
    fileprivate func setupprofileHeader() {
        profileHeader.tabButtonPressedBlock = { [weak self] (index: Int) in
            guard let uself = self else {
                return
            }
            
            var vc : UIViewController?
            
            if index == 0 {
                vc = uself.getFirst()

            }
            else if index == 1 {
                vc = uself.getSecond()

            }
            else if index == 2 {
                vc = uself.getThird()

            }

            uself.setViewControllers([vc!], direction: .forward, animated: false, completion: nil)

            
            /*
            uself.shouldUpdateLayout = true
            uself.updateIndex = index
            let direction: UIPageViewControllerNavigationDirection = (uself.currentIndex < index) ? .forward : .reverse
            uself.setViewControllers([uself.pageViewControllers[index]],
                                     direction: direction,
                                     animated: true,
                                     completion: { [weak self] (completed: Bool) in
                                        guard let uself = self else {
                                            return
                                        }
                                        if uself.shouldUpdateLayout {
                                            uself.setupContentOffsetY(index, scroll: -uself.scrollContentOffsetY)
                                            uself.shouldUpdateLayout = false
                                        }
            })
 */
        }
        
        profileHeader.scrollDidChangedBlock = { [weak self] (scroll: CGFloat, shouldScrollFrame: Bool) in
            self?.shouldScrollFrame = shouldScrollFrame
            self?.updateContentOffsetY(scroll)
        }
        view.addSubview(profileHeader)

    }
    
    func getFirst() -> FirstViewController {
        
        if let firstVC = self.firstVC {
            return firstVC
        }
        
        self.firstVC = storyboard!.instantiateViewController(withIdentifier: "FirstViewController") as? FirstViewController
        return self.firstVC!
    }

    func getSecond() -> SecondViewController {
        if let secondVC = self.secondVC {
            return secondVC
        }
        self.secondVC = storyboard!.instantiateViewController(withIdentifier: "SecondViewController") as? SecondViewController
        return self.secondVC!
    }
    
    func getThird() -> ThirdViewController {
        if let thirdVC = self.thirdVC {
            return thirdVC
        }
        self.thirdVC = storyboard!.instantiateViewController(withIdentifier: "ThirdViewController") as? ThirdViewController
        return self.thirdVC!
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
    
    // テーブルビューのスクロールを調整
    fileprivate func updateContentOffsetY(_ scroll: CGFloat) {
        let vc = viewControllers?.first as! ScrollTabPageViewControllerProtocol
        vc.scrollView.contentOffset.y += scroll
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

// MARK: - UIPageViewControllerDelegate

//extension ScrollTabPageViewController: UIPageViewControllerDelegate {
//    
//    func pageViewController(_ pageViewController: UIPageViewController, willTransitionTo pendingViewControllers: [UIViewController]) {
//        if let vc = pendingViewControllers.first, let index = pageViewControllers.index(of: vc) {
//            shouldUpdateLayout = true
//            updateIndex = index
//        }
//        
//    }
//    
//    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
//        guard let _ = previousViewControllers.first, let currentIndex = currentIndex else {
//            return
//        }
//        
//        if shouldUpdateLayout {
//            setupContentInset()
//            setupContentOffsetY(currentIndex, scroll: -scrollContentOffsetY)
//        }
//        
//        if currentIndex >= 0 && currentIndex < contentsView.tabButtons.count {
//            contentsView.updateCurrentIndex(currentIndex, animated: false)
//        }
//    }
//}

