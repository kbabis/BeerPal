//
//  BeerRecipeViewController.swift
//  BeerPal
//
//  Created by Krzysztof Babis on 22.10.2020 r..
//  Copyright © 2020 Krzysztof Babis. All rights reserved.
//

import RxSwift
import RxDataSources

final class BeerRecipeViewController: BaseTableViewController {
    private var recipeView: ListView!
    private let viewModel: BeerRecipeViewModel
    
    override func loadView() {
        recipeView = ListView()
        view = recipeView
    }
    
    init(viewModel: BeerRecipeViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) is not supported")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = viewModel.output.title
        navigationItem.largeTitleDisplayMode = .never
        recipeView.tableView.allowsSelection = false
        registerCells(for: recipeView.tableView)
        makeBindings()
    }
    
    private func makeBindings() {
        let dataSource = prepareDataSource()
        
        recipeView.tableView
            .rx.setDelegate(self)
            .disposed(by: disposeBag)
        
        viewModel.output.sections
            .drive(recipeView.tableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
    }
    
    private func prepareDataSource() -> RxTableViewSectionedReloadDataSource<BeerRecipeSection> {
        let dataSource = RxTableViewSectionedReloadDataSource<BeerRecipeSection>(configureCell: { (_, tableView, indexPath, item) -> UITableViewCell in
            switch item {
            case .ingredient(name: let name), .pairingFood(name: let name):
                let cell: RecipeIngredientTableViewCell = tableView.dequeueReusableCell(for: indexPath)
                cell.name = name
                return cell
            case .method(name: let name, index: let index):
                let cell: RecipeMethodTableViewCell = tableView.dequeueReusableCell(for: indexPath)
                cell.name = name
                cell.index = index
                return cell
            case .tip(content: let content, contributor: let contributor):
                let cell: RecipeTipsTableViewCell = tableView.dequeueReusableCell(for: indexPath)
                cell.tips = content
                cell.contributor = contributor
                return cell
            }
        })
        
        dataSource.titleForHeaderInSection = { dataSource, index in
            dataSource.sectionModels[index].header
        }
        
        return dataSource
    }
    
    private func registerCells(for tableView: UITableView) {
        tableView.register(RecipeIngredientTableViewCell.self, forCellReuseIdentifier: RecipeIngredientTableViewCell.reuseIdentifier)
        tableView.register(RecipeMethodTableViewCell.self, forCellReuseIdentifier: RecipeMethodTableViewCell.reuseIdentifier)
        tableView.register(RecipeTipsTableViewCell.self, forCellReuseIdentifier: RecipeTipsTableViewCell.reuseIdentifier)
    }
}

extension BeerRecipeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 20
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        view.tintColor = .black
        
        guard let header = view as? UITableViewHeaderFooterView else { return }
        
        header.textLabel?.textColor = Theme.Colors.Texts.primary
        header.textLabel?.font = Theme.Fonts.getFont(ofSize: .xLarge, weight: .bold)
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
}

