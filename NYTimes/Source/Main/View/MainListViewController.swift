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
import NVActivityIndicatorView

class MainListViewController: UIViewController {

    //MARK: - Properties
    
    private let disposeBag = DisposeBag()
    private lazy var activityIndicatorView: NVActivityIndicatorView = makeActivityIndicatorView()
    
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

        viewModel.loadingIndicator.subscribe(onNext: { [weak self] show in
            show ?
            self?.activityIndicatorView.startAnimating() :
            self?.activityIndicatorView.stopAnimating()
        }).disposed(by: disposeBag)
        
        viewModel.onError.subscribe(onNext: { error in
            SwiftMessages.show {
                let view = MessageView.viewFromNib(layout: .cardView)
                view.configureTheme(.error)
                view.configureContent(title: "Error",
                                      body: (error as? AFError)?.localizedDescription ?? "Error loading")
                view.button?.isHidden = true
                return view
            }
        }).disposed(by: disposeBag)
    }
    
    private func makeActivityIndicatorView() -> NVActivityIndicatorView {
        let frame = CGRect(origin: .zero, size: CGSize(width: 60, height: 60))
        let view = NVActivityIndicatorView(frame: frame,
                                           type: .ballSpinFadeLoader,
                                           color: .darkGray)
        let viewBounds = self.view.bounds
        view.center = CGPoint(x: viewBounds.width / 2, y: viewBounds.height / 2)
        self.view.addSubview(view)
        return view
    }
    
    private func openInWebpage(article: Article) {
        let webViewController = WebViewController(title: article.title,
                                                  url: article.url)
        self.navigationController?.pushViewController(webViewController, animated: true)
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
        tableView.deselectRow(at: indexPath, animated: true)
        openInWebpage(article: viewModel.item(for: indexPath.row))
    }
    
}
