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
    
    let emptyStateView = EmptyStateView()
    let errorStateView = ErrorStateView()
    let loadingStateView = LoadingStateView()
    var hasContent: Bool {
        return false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpStateViews()
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func bindState(of manager: StateManaging, dataReloader: DataReloading?) {
        manager.currentState.drive(rx.viewState).disposed(by: disposeBag)
        setDataReloader(dataReloader)
    }
    
    func setDataReloader(_ reloader: DataReloading?) {
        emptyStateView.reloadingDelegate = reloader
        errorStateView.reloadingDelegate = reloader
    }
}

extension BaseViewController: StateRendering {
    func render(_ state: DataState) {
        [emptyStateView, errorStateView, loadingStateView].forEach { $0.alpha = 0 }
        
        switch state {
        case .empty(let message):
            emptyStateView.message = message
            emptyStateView.alpha = hasContent ? 0 : 1
        case .error(let message):
            showError(message, isDataOriented: hasContent)
        case .loading:
            loadingStateView.alpha = hasContent ? 0 : 1
        default:
            break
        }
    }
    
    func showError(_ message: String, isDataOriented: Bool) {
        if isDataOriented {
            showPopUp(message)
        } else {
            errorStateView.message = message
            errorStateView.alpha = 1
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
