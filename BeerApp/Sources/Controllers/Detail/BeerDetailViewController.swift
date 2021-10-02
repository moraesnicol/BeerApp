//
//  BeerDetailViewController.swift
//  BeerApp
//
//  Created by Gabriel on 01/10/21.
//

import UIKit
import Kingfisher

class BeerDetailViewController: UIViewController, UITextViewDelegate {
    
    let imagePoster = UIImageView()
    let divider = UIView()
    let titleLabel = UILabel()
    let unlikededButton = UIButton(type: .roundedRect)
    let textViewDescription = UITextView()
    let anotherLabel = UILabel()
    var titleOriginal = ""
    var titleDescription = ""
    var imageBeerDetail = UIImageView()
    var imageBeerDetail2 = UIImageView()
    var liked = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .primary
        title = "Beer Details"
        
        setupimagePoster()
        setupDivider()
        setuptitleLabel()
        setupLikeButton()
        setupAnotherLabel()
        titleLabel.text = "\(titleOriginal)"
        anotherLabel.text = "\(titleDescription)"
        configImgPoster()
    }
    
    func configImgPoster() {
        imageBeerDetail2 = imageBeerDetail
        imagePoster.image = imageBeerDetail2.image
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        imagePoster.kf.cancelDownloadTask()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        imagePoster.kf.cancelDownloadTask()
    }
    
    
    func  setupimagePoster() {
        view.addSubview(imagePoster)
        imagePoster.translatesAutoresizingMaskIntoConstraints = false
        imagePoster.backgroundColor = .primary
        imagePoster.layer.cornerRadius = 12
        imagePoster.contentMode = .scaleAspectFit
        imagePoster.image = UIImage()
        NSLayoutConstraint.activate([
            imagePoster.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
            imagePoster.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant:20),
            imagePoster.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            imagePoster.widthAnchor.constraint(equalToConstant: 200),
            imagePoster.heightAnchor.constraint(equalToConstant: 220)
        ])
    }
    
    func setupDivider() {
        view.addSubview(divider)
        divider.backgroundColor = .brown
        divider.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            divider.topAnchor.constraint(equalTo: imagePoster.bottomAnchor, constant:15),
            divider.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            divider.trailingAnchor.constraint(equalTo: view.trailingAnchor),//
            divider.heightAnchor.constraint(equalToConstant: 2)
        ])
    }
    
    func setuptitleLabel() {
        view.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.font = UIFont.monospacedDigitSystemFont(ofSize: 20, weight: UIFont.Weight.bold)
        titleLabel.tintColor = .red
        titleLabel.adjustsFontSizeToFitWidth = true
        titleLabel.numberOfLines = 1
        titleLabel.textAlignment = .left
        NSLayoutConstraint.activate([
            titleLabel.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -300),
            titleLabel.leadingAnchor.constraint(equalTo:view.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
        ])
    }
    func setupAnotherLabel() {
        view.addSubview(anotherLabel)
        anotherLabel.translatesAutoresizingMaskIntoConstraints = false
        anotherLabel.font = UIFont(name: "MontSerrat Regular", size: 22)
        anotherLabel.tintColor = .red
        anotherLabel.adjustsFontSizeToFitWidth = true
        anotherLabel.numberOfLines = 0
        anotherLabel.textAlignment = .justified
        NSLayoutConstraint.activate([
            anotherLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            anotherLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            anotherLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
        ])
    }
    
    func setupLikeButton(){
        let imageViewButtonTop = UIImageView()
        let imageButton = UIImage(named: "miss core")
        imageViewButtonTop.image = imageButton
        imageViewButtonTop.contentMode = .scaleAspectFit
        view.addSubview(unlikededButton)
        unlikededButton.translatesAutoresizingMaskIntoConstraints = false
        unlikededButton.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        unlikededButton.setBackgroundImage(imageViewButtonTop.image, for: .normal)
        unlikededButton.addTarget(self, action: #selector(likeMovie(_:)), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            unlikededButton.topAnchor.constraint(equalTo: divider.bottomAnchor, constant: 15),
            unlikededButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            unlikededButton.widthAnchor.constraint(equalToConstant: 25),
            unlikededButton.heightAnchor.constraint(equalToConstant: 25),
        ])
    }
    
   
    @objc func likeMovie(_ sender:UIButton!) {
        
        if liked {
            sender.setImage(UIImage(named:"miss core"), for: .normal)
            liked = false
            //save remove data
        } else {
            sender.setImage( UIImage(named:"core"), for: .normal)
            liked = true
            //save data
        }
        print("Button tapped")
    }
}
