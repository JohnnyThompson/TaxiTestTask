//
//  OrderDetailsViewController.swift
//  RoxieTestTask
//
//  Created by Евгений Карпов on 20.01.2022.
//

import UIKit

protocol OrderDetailsViewInputProtocol: AnyObject {
  func displayVehicleImage(with imageData: Data)
  func displayVehicleImage(from cacheKey: String)
  func displayOrderTime(with title: String)
  func displayModelNameLabel(with title: String)
  func displayRegNumber(with title: String)
  func displayDriverName(with title: String)
  func showAlert(with error: String)
}

protocol OrderDetailsViewOutputProtocol: AnyObject {
  init(view: OrderDetailsViewInputProtocol)
  func showDetails()
}

class OrderDetailsViewController: UIViewController {
  
  // MARK: - Properties
  private let vehicleImage = UIImageView()
  private let timeLabel = UILabel(font: .helvetica14Light())
  private let orderTimeLabel = LabelWithLine(font: .helvetica17())
  private let modelNameLabel = LabelWithLine(font: .helvetica17())
  private let regNumberLabel = LabelWithLine(font: .helvetica17())
  private let driverNameLabel = LabelWithLine(font: .helvetica17())
  private let activityIndicator = UIActivityIndicatorView()
  private let imageManager: ImageManagerProtocol = ImageManager()
  
  var presenter: OrderDetailsViewOutputProtocol!
  
  // MARK: - Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    setupViews()
    presenter.showDetails()
  }
  
  override func updateViewConstraints() {
    super.updateViewConstraints()
    view.backgroundColor = .mainWhite()
    setupConstraints()
  }
  
  // MARK: - Private functions
  private func setupViews() {
    title = "Детали заказа"
    navigationController?.navigationBar.tintColor = .mainWhite()
    vehicleImage.contentMode = .scaleAspectFill
    vehicleImage.layer.cornerRadius = 2
    vehicleImage.clipsToBounds = true
    activityIndicator.startAnimating()
    activityIndicator.hidesWhenStopped = true
  }
  
  private func setupConstraints() {
    let customView = UIView()
    customView.backgroundColor = .mainGray()
    customView.layer.cornerRadius = 7
    customView.translatesAutoresizingMaskIntoConstraints = false
    
    let detailsStackView = UIStackView(arrangedSubviews: [orderTimeLabel,
                                                          modelNameLabel,
                                                          regNumberLabel,
                                                          driverNameLabel],
                                       axis: .vertical,
                                       spacing: 10)
    detailsStackView.backgroundColor = .mainGray()
    detailsStackView.layer.cornerRadius = 7
    
    view.addSubview(customView)
    customView.addSubviews([detailsStackView, vehicleImage, activityIndicator])
    
    NSLayoutConstraint.activate([
      customView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 15),
      customView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 15),
      customView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -15),
      customView.bottomAnchor.constraint(equalTo: vehicleImage.bottomAnchor, constant: 10),
      
      detailsStackView.topAnchor.constraint(equalTo: customView.topAnchor, constant: 10),
      detailsStackView.leadingAnchor.constraint(equalTo: customView.safeAreaLayoutGuide.leadingAnchor, constant: 10),
      detailsStackView.trailingAnchor.constraint(equalTo: customView.safeAreaLayoutGuide.trailingAnchor, constant: -10),
      
      vehicleImage.topAnchor.constraint(equalTo: detailsStackView.bottomAnchor, constant: 10),
      vehicleImage.leadingAnchor.constraint(equalTo: customView.leadingAnchor, constant: 10),
      vehicleImage.trailingAnchor.constraint(equalTo: customView.trailingAnchor, constant: -10),
      vehicleImage.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.29),
      
      activityIndicator.centerXAnchor.constraint(equalTo: vehicleImage.centerXAnchor),
      activityIndicator.centerYAnchor.constraint(equalTo: vehicleImage.centerYAnchor)
    ])
  }
}

// MARK: - OrderDetailsViewInputProtocol
extension OrderDetailsViewController: OrderDetailsViewInputProtocol {
  func displayVehicleImage(with imageData: Data) {
    vehicleImage.image = UIImage(data: imageData)
    activityIndicator.stopAnimating()
    activityIndicator.isHidden = true
  }  
  
  func displayVehicleImage(from cacheKey: String) {
    imageManager.loadImageFromCache(with: cacheKey) { [unowned self] image in
      vehicleImage.image = image
      activityIndicator.stopAnimating()
    } failure: { [unowned self] error in
      showAlert(with: error.localizedDescription)
    }
  }
  
  func displayOrderTime(with title: String) {
    orderTimeLabel.text = title
  }
  
  func displayModelNameLabel(with title: String) {
    modelNameLabel.text = title
  }
  
  func displayRegNumber(with title: String) {
    regNumberLabel.text = title
  }
  
  func displayDriverName(with title: String) {
    driverNameLabel.text = title
  }
  
  func showAlert(with error: String) {
    let alertController = UIAlertController(title: "Error", message: error, preferredStyle: .alert)
    alertController.addAction(UIAlertAction(title: "OK", style: .default))
    present(alertController, animated: true)
  }
}
