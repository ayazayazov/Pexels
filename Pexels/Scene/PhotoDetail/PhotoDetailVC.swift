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

    private let photographerUsername: UILabel = {
        let il = UILabel()
        il.font = .systemFont(ofSize: 16, weight: .bold)
        il.textAlignment = .left
        il.backgroundColor = .yellow
        il.translatesAutoresizingMaskIntoConstraints = false
        return il
    }()
    
    private let cellImage: UIImageView = {
        let iv = UIImageView()
        iv.backgroundColor = .yellow
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = false
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    private let photoDetailNavStack: UIStackView = {
        let sv = UIStackView()
        sv.axis = .horizontal
        sv.distribution = .fillProportionally
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()
    
    private let backButton: UIButton = {
        let ub = UIButton()
        

        
        ub.setBackgroundImage(.likeUnfilled, for: .normal)
        
//        ub.setImage(UIImage(named: "like-unfilled"), for: .normal)
        ub.tintColor = .white
        ub.backgroundColor = .systemBackground
        
        ub.translatesAutoresizingMaskIntoConstraints = false
        return ub
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
        }
    }
    
    private func setupView() {
        view.addSubview(cellImage)
        NSLayoutConstraint.activate([
            cellImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            cellImage.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            cellImage.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            cellImage.heightAnchor.constraint(equalToConstant: 600)
        ])
    }


}
