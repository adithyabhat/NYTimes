//
//  MainListViewController.swift
//  NYTimes
//
//  Created by Adithya Bhat on 13/01/2022.
//

import UIKit
import RxSwift
import SwiftMessages
import Alamofire

class MainListViewController: UIViewController {

    //MARK: - Properties
    
    private let disposeBag = DisposeBag()
    
    @IBOutlet weak var tableView: UITableView!
    
    var viewModel: MainListViewModel
    
    //MARK: - Init
    
    required init?(coder: NSCoder) {
        viewModel = MainListViewModel()
        super.init(coder: coder)
    }
    
    //MARK: - Override methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupViewModelBindings()
        viewModel.loadArticles()
    }

    //MARK: - Private helper methods
    
    private func setupUI() {
        self.title = viewModel.screenTitle
    }

    private func setupViewModelBindings() {
        viewModel.reloadData.subscribe(onNext: { [weak self] in
            self?.tableView.reloadData()
        }).disposed(by: disposeBag)

        viewModel.onError.subscribe(onNext: { error in
            SwiftMessages.show {
                let view = MessageView.viewFromNib(layout: .cardView)
                view.titleLabel?.text = (error as? AFError)?.localizedDescription ?? "Error loading"
                return view
            }
        }).disposed(by: disposeBag)
    }
}

extension MainListViewController: UITableViewDataSource, UITableViewDelegate {

    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfSections()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "\(MainListTableViewCell.self)") as? MainListTableViewCell
        guard let mainListTableViewCell = cell else { return UITableViewCell() }
        mainListTableViewCell.setup(with: viewModel.item(for: indexPath.row))
        return mainListTableViewCell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
}
