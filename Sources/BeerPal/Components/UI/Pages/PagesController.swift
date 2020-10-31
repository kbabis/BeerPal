//
//  PagesController.swift
//  BeerPal
//
//  Created by Krzysztof Babis on 13.10.2020 r..
//  Copyright © 2020 Krzysztof Babis. All rights reserved.
//

import UIKit

final class PagesController: UIViewController {
    private let viewControllers: [UIViewController]
    private let pageViewController: UIPageViewController
    private var pagesView: PagesView!
    private var selectedIndex: Int
    
    override func loadView() {
        pagesView = PagesView()
        view = pagesView
    }
    
    init(viewControllers: [UIViewController]) {
        self.viewControllers = viewControllers
        self.pageViewController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: [:])
        self.selectedIndex = 0
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) is not supported")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.largeTitleDisplayMode = .never
        setUpSegmentedControl()
        setUpPageViewController()
    }
    
    private func setViewController(atIndex index: Int, direction: UIPageViewController.NavigationDirection) {
        self.pageViewController.setViewControllers([self.viewControllers[index]], direction: direction, animated: true) { [weak self] completed in
            guard
                let self = self,
                completed
            else { return }
            
            self.selectedIndex = index
        }
    }
    
    @objc
    private func indexDidChange(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex > selectedIndex {
            let nextIndex = selectedIndex + 1
            for index in nextIndex...sender.selectedSegmentIndex {
                self.setViewController(atIndex: index, direction: .forward)
            }
        } else if sender.selectedSegmentIndex < selectedIndex {
            let previousIndex = selectedIndex - 1
            for index in (sender.selectedSegmentIndex...previousIndex).reversed() {
                self.setViewController(atIndex: index, direction: .reverse)
            }
        }
    }
}

extension PagesController: UIPageViewControllerDelegate {
    public func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard
            let index = viewControllers.firstIndex(of: viewController),
            index > 0
        else { return nil }
        
        return self.viewControllers[index - 1]
    }
    
    public func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard var index = viewControllers.firstIndex(of: viewController) else { return nil }
        
        index += 1
        guard index < viewControllers.count else { return nil }
        
        return self.viewControllers[index]
    }
}

extension PagesController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController,
                            didFinishAnimating finished: Bool,
                            previousViewControllers: [UIViewController],
                            transitionCompleted completed: Bool) {
        guard
            let viewControllers = pageViewController.viewControllers,
            let lastViewController = viewControllers.last,
            let index = self.viewControllers.firstIndex(of: lastViewController),
            finished,
            completed
        else { return }
        
        self.selectedIndex = index
        self.pagesView.segmentedControl.selectedSegmentIndex = index
    }
}

extension PagesController {
    private func setUpPageViewController() {
        addChild(pageViewController)
        pagesView.pagesContainerView.addSubview(pageViewController.view)
        pageViewController.didMove(toParent: self)
        
        pageViewController.delegate = self
        pageViewController.dataSource = self
        
        if let firstViewController = viewControllers.first {
            pageViewController.setViewControllers([firstViewController], direction: .forward, animated: false)
        }
    }
    
    private func setUpSegmentedControl() {
        pagesView.segmentedControl.setSegments(viewControllers.compactMap { $0.title })
        pagesView.segmentedControl.selectedSegmentIndex = 0
        pagesView.segmentedControl.addTarget(self, action: #selector(indexDidChange(_:)), for: .valueChanged)
    }
}
