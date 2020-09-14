//
//  BaseViewController.swift
//  BeerPal
//
//  Created by Krzysztof Babis on 01.09.2020 r..
//  Copyright © 2020 Krzysztof Babis. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class BaseViewController: UIViewController {
    let disposeBag = DisposeBag()
    
    private let emptyStateView = EmptyStateView()
    private let errorStateView = ErrorStateView()
    private let loadingStateView = LoadingStateView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpStateViews()
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func bindState(of viewModel: StateManaging) {
        viewModel.stateManager.currentState.drive(rx.viewState).disposed(by: disposeBag)
        
        if let reloadingViewModel = viewModel as? DataReloading {
            emptyStateView.reloadingDelegate = reloadingViewModel
            errorStateView.reloadingDelegate = reloadingViewModel
        }
    }
}

extension BaseViewController: StateRendering {
    func render(_ state: DataState) {
        [emptyStateView, errorStateView, loadingStateView].forEach { $0.alpha = 0 }
        
        switch state {
        case .empty(let message):
            emptyStateView.message = message
            emptyStateView.alpha = 1
        case .error(let message):
            errorStateView.message = message
            errorStateView.alpha = 1
        case .loading:
            loadingStateView.alpha = 1
        default:
            break
        }
    }
}

extension Reactive where Base: BaseViewController {
    var viewState: Binder<DataState> {
        return Binder(self.base) { viewController, state  in
            viewController.render(state)
        }
    }
}

extension BaseViewController {
    private func setUpStateViews() {
        [emptyStateView, errorStateView, loadingStateView].forEach { setUpSubview($0) }
    }
    
    private func setUpSubview(_ subview: UIView) {
        view.addSubview(subview)
        subview.alpha = 0
        subview.snp.makeConstraints { $0.edges.equalToSuperview() }
    }
}
