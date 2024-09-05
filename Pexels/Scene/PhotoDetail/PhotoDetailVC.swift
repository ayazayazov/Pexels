//
//  PhotoDetailVC.swift
//  Pexels
//
//  Created by Ayaz Ayazov on 1/9/24.
//

import UIKit

class PhotoDetailVC: UIViewController {
    private let viewModel = PhotoDetailVM()
    var photoID: Int?

    private let cellImage: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = false
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    private let photoDesc: UILabel = {
        let il = UILabel()
        il.font = .systemFont(ofSize: 24, weight: .semibold)
        il.textColor = .white
        il.textAlignment = .left
        il.numberOfLines = 0
        il.translatesAutoresizingMaskIntoConstraints = false
        return il
    }()

    private let photoResolutionDesc: UILabel = {
        let il = UILabel()
        il.font = .systemFont(ofSize: 20, weight: .regular)
        il.textColor = .white
        il.textAlignment = .left
        il.translatesAutoresizingMaskIntoConstraints = false
        return il
    }()

    private let scrollView: UIScrollView = {
        let sv = UIScrollView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()
    
    private let scrollStackViewContainer: UIStackView = {
        let sv = UIStackView()
        sv.axis = .vertical
        sv.spacing = 10
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()
  
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        self.tabBarController?.tabBar.isHidden = true
        self.tabBarController?.tabBar.isTranslucent = true
        self.navigationController?.isNavigationBarHidden = false
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        configureViewModel(id: photoID)
        setupView()
    }
    
    func configureViewModel(id: Int?) {
        viewModel.getPhotosID(id: id)
        viewModel.error = { errorMessage in
            print("Error(HomeVC44): \(errorMessage)")
            //            self.showAlertController(title: "", message: errorMessage)
        }
        viewModel.success = {
            self.title = "\(self.viewModel.photoData?.photographer ?? "empty")"
            self.cellImage.loadImage(url: self.viewModel.photoData?.imageName ?? "")
            self.photoDesc.text = "\(self.viewModel.photoData?.alt ?? "empty")"
            self.photoResolutionDesc.text = "Resolution: \(self.viewModel.photoData?.width ?? 0000)x\(self.viewModel.photoData?.height ?? 0000)"
        }
    }
    
    private func setupView() {
        view.addSubview(scrollView)
        scrollView.addSubview(scrollStackViewContainer)
        
        scrollStackViewContainer.addArrangedSubview(cellImage)
        scrollStackViewContainer.addArrangedSubview(photoDesc)
        scrollStackViewContainer.addArrangedSubview(photoResolutionDesc)

        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            scrollStackViewContainer.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            scrollStackViewContainer.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            scrollStackViewContainer.topAnchor.constraint(equalTo: scrollView.topAnchor),
            scrollStackViewContainer.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            scrollStackViewContainer.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            cellImage.topAnchor.constraint(equalTo: scrollStackViewContainer.topAnchor),
            cellImage.rightAnchor.constraint(equalTo: scrollStackViewContainer.rightAnchor),
            cellImage.leftAnchor.constraint(equalTo: scrollStackViewContainer.leftAnchor),
            cellImage.heightAnchor.constraint(equalToConstant: 600),
            
            photoDesc.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: 10),
            photoDesc.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 10),
    
            photoResolutionDesc.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            photoResolutionDesc.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 10),
        ])
    }


}
