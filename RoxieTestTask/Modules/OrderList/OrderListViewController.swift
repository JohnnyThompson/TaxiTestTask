//
//  OrderListViewController.swift
//  RoxieTestTask
//
//  Created by Евгений Карпов on 20.01.2022.
//

import UIKit

protocol OrderListViewInputProtocol: AnyObject {
  func reloadData(for section: OrderSectionViewModel)
  func showAlert(with error: String)
}

protocol OrderListViewOutputProtocol: AnyObject {
  init(view: OrderListViewInputProtocol)
  func viewDidLoad()
  func didTapCell(at indexPath: IndexPath)
}

final class OrderListViewController: UIViewController {
  // MARK: - Properties
  private let tableView = UITableView()
  private var section: SectionRowPresentable = OrderSectionViewModel()
  private let configurator: OrderListConfiguratorInputProtocol = OrderListConfigurator()
  private var didSetupConstraints = false
  var presenter: OrderListViewOutputProtocol!
  
  
  // MARK: - Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    configurator.configure(with: self)
    presenter.viewDidLoad()
    setupViews()
  }
  
  override func updateViewConstraints() {
    super.updateViewConstraints()
    if !didSetupConstraints {
      view.backgroundColor = .mainWhite()
      tableView.backgroundColor = .clear
      setupConstraints()
      didSetupConstraints = true
    }
  }
  
  // MARK: - Public functions
  func prepareDetailsVC(with order: Order) {
    let detailsVC = OrderDetailsViewController()
    let configurator: OrderDetailsConfiguratorInputProtocol = OrderDetailsConfigurator()
    configurator.configure(with: detailsVC, and: order)
    navigationController?.pushViewController(detailsVC, animated: true)
  }
}

// MARK: - OrderListViewInputProtocol
extension OrderListViewController: OrderListViewInputProtocol {
  func reloadData(for section: OrderSectionViewModel) {
    self.section = section
    tableView.reloadData()
  }
  func showAlert(with error: String) {
    let alertController = UIAlertController(title: "Error", message: error, preferredStyle: .alert)
    alertController.addAction(UIAlertAction(title: "OK", style: .default))
    present(alertController, animated: true)
  }
}

// MARK: - UITableViewDataSource
extension OrderListViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    self.section.rows.count
  }
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let viewModel = section.rows[indexPath.row]
    tableView.register(OrderListTableViewCell.self, forCellReuseIdentifier: viewModel.cellIdentifier)
    guard let cell = tableView.dequeueReusableCell(withIdentifier: viewModel.cellIdentifier, for: indexPath) as? OrderListTableViewCell else {
      fatalError("Creating cell from OrderListTableViewCell failed")
    }
    cell.viewModel = viewModel
    return cell
  }
}

// MARK: - UITableViewDelegate
extension OrderListViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    presenter.didTapCell(at: indexPath)
  }
}

// MARK: - SetupViews
extension OrderListViewController {
  private func setupConstraints() {
    tableView.translatesAutoresizingMaskIntoConstraints = false
    view.addSubview(tableView)
    
    NSLayoutConstraint.activate([
      tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
      tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
      tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
      tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10)
    ])
  }
  private func setupViews() {
    tableView.dataSource = self
    tableView.delegate = self
    tableView.showsVerticalScrollIndicator = false
    tableView.separatorStyle = .none
    setupNavigationController()
  }  
  private func setupNavigationController() {
    title = "TAXI NAME"
    if #available(iOS 13.0, *) {
      navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "text.justify") ?? UIImage(), style: .plain, target: self, action: nil)
      navigationItem.leftBarButtonItem?.tintColor = .white
      navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "info.circle") ?? UIImage(), style: .plain, target: self, action: nil)
      navigationItem.rightBarButtonItem?.tintColor = .white
      navigationController?.navigationBar.prefersLargeTitles = true
      let navBarAppearance = UINavigationBarAppearance()
      navBarAppearance.configureWithOpaqueBackground()
      navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
      navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
      navBarAppearance.backgroundColor = .mainYellow()
      navigationController?.navigationBar.standardAppearance = navBarAppearance
      navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
    }
  }
}
