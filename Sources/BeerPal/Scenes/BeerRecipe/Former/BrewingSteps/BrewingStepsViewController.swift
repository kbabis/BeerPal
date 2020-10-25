//
//  BrewingStepsViewController.swift
//  BeerPal
//
//  Created by Krzysztof Babis on 15.10.2020 r..
//  Copyright © 2020 Krzysztof Babis. All rights reserved.
//

import UIKit

final class BrewingStepsViewController: BaseTableViewController {
    private var brewingStepsView: ListView!
    private let headerView = BrewingStepsHeaderView()
    private let viewModel: BrewingStepsViewModel
    
    override func loadView() {
        brewingStepsView = ListView()
        view = brewingStepsView
    }
    
    init(viewModel: BrewingStepsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        self.title = viewModel.output.title
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) is not supported")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        brewingStepsView.refreshControl.removeFromSuperview()
        configureTableView(brewingStepsView.tableView, cellType: UITableViewCell.self, estimatedRowHeight: 60)
        makeBindings()
    }
    
    private func makeBindings() {
        brewingStepsView.tableView
            .rx.setDelegate(self)
            .disposed(by: disposeBag)
        
        viewModel.output.tips
            .drive(headerView.tipsLabel.rx.text)
            .disposed(by: disposeBag)
        
        viewModel.output.contributor
            .drive(headerView.contributorLabel.rx.text)
            .disposed(by: disposeBag)
        
        viewModel.output.items
            .drive(brewingStepsView.tableView.rx.items(cellIdentifier: UITableViewCell.reuseIdentifier, cellType: UITableViewCell.self)) { (_, step, cell) in
                cell.textLabel?.text = step
            }.disposed(by: disposeBag)
        
        brewingStepsView.tableView.isScrollEnabled = false
    }
}

extension BrewingStepsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return UITableView.automaticDimension
    }
}
