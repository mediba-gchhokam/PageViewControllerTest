//
//  FirstViewController.swift
//  PageViewControllerTest
//
//  Created by 岡本洋明 on 2017/05/28.
//  Copyright © 2017年 岡本洋明. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {

    @IBOutlet fileprivate weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        scrollTabPageViewController.updateLayoutIfNeeded()
    }
}

// MARK: - UITableVIewDataSource

extension FirstViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "Cell")
        cell.textLabel?.text = String(indexPath.row)
        return cell
    }
}


// MARK: - UIScrollViewDelegate

extension FirstViewController: UITableViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        scrollTabPageViewController.updateContentViewFrame()
    }
}


// MARK: - ScrollTabPageViewControllerProtocol

extension FirstViewController: ScrollTabPageViewControllerProtocol {
    
    var scrollTabPageViewController: ScrollTabPageViewController {
        return parent as! ScrollTabPageViewController
    }
    
    var scrollView: UIScrollView {
        return tableView
    }
}
