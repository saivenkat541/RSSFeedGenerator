//
//  RssDetailViewController.swift
//  RSSFeedGenerator
//
//  Created by Sai Venkat Kancharlapalli on 4/7/20.
//  Copyright © 2020 Sai Venkat Kancharlapalli. All rights reserved.
//

import UIKit

class RssDetailViewController: UIViewController, UINavigationBarDelegate {
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpNavigation()
        view.backgroundColor = .white
        view.addSubview(iTunesButton)
        view.addSubview(profileImageView)
        view.addSubview(copyright)
        containerView.addSubview(nameLabel)
        containerView.addSubview(jobTitleDetailedLabel)
        containerView.addSubview(releaseDate)
        containerView.addSubview(genre)
        view.addSubview(containerView)
        autoLayoutConstraints()
    }
    
    // MARK: - UIControls
    let iTunesButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("iTunes Store", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.setTitleColor(.gray, for: .selected)
        button.layer.cornerRadius = 20
        button.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        button.addTarget(self, action:#selector(buttonClicked), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    @objc func buttonClicked() {
        if let url = detailResults?.url {
            guard let requestUrl = URL(string: url) else { return }
            if UIApplication.shared.canOpenURL(requestUrl) {
                UIApplication.shared.open(requestUrl, options: [:], completionHandler: nil)
            }
        }
    }
    
    let profileImageView:UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFill // image will never be strecthed vertially or horizontally
        img.translatesAutoresizingMaskIntoConstraints = false // enable autolayout
        img.layer.cornerRadius = 35
        img.clipsToBounds = true
        return img
    }()
    
    let containerView:UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        view.backgroundColor = #colorLiteral(red: 0.9882352941, green: 0.9725490196, blue: 0.9098039216, alpha: 1)
        view.layer.borderWidth = 1.0
        view.layer.cornerRadius = 15
        view.layer.borderColor = UIColor.lightGray.cgColor
        return view
    }()
    
    let nameLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = .black
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.numberOfLines = 0
        label.textColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let copyright:UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 10)
        label.textColor = .black
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let releaseDate:UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = .black
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let genre: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = .black
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let jobTitleDetailedLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textColor =  .black
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.numberOfLines = 0
        label.layer.cornerRadius = 2
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: - Global Declarations
    var genreResults : [Genres] = [Genres]() //Genre array
    var genreName : [String] = [] //Genre name array
    
    var detailResults : Results? {
        didSet{
            guard let contactItem = detailResults else {return}
            if let name = contactItem.name {
                nameLabel.text = name
            }
            if let jobTitle = contactItem.artistName {
                jobTitleDetailedLabel.text = " \(jobTitle) "
            }
            if let country = contactItem.artworkUrl100 {
                profileImageView.loadImageUsingCache(withUrl: country)
            }
            
            if let copyrightText = contactItem.copyright {
                copyright.text = copyrightText
            }
            
            if let releaseDateText = contactItem.releaseDate {
                releaseDate.text = "Release Date: \(releaseDateText)"
            }
            
            if let genrenames = contactItem.genres {
                genreResults = genrenames
                for i in genreResults {
                    if let i = i.name {
                        genreName.append(i)
                    }
                }
                genre.text = genreName.joined(separator: ", ")
            }
        }
    }
    
    // MARK: - Navigation Setup
    func setUpNavigation() {
        navigationItem.title = Constants.navBarTitleName
        self.navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
        self.navigationController?.navigationBar.tintColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor(red: 1, green: 1, blue: 1, alpha: 1)]
    }
    
    // MARK: - Constraints
    private func autoLayoutConstraints() {
        
        //Profile Image
        profileImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        profileImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 10).isActive = true
        profileImageView.heightAnchor.constraint(equalToConstant: 350).isActive = true
        profileImageView.widthAnchor.constraint(equalToConstant: 350).isActive = true
        
        //Copyright
        copyright.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        copyright.topAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: 8).isActive = true
        
        //Container View
        containerView.centerXAnchor.constraint(equalTo:view.centerXAnchor).isActive = true
        containerView.topAnchor.constraint(equalTo: copyright.bottomAnchor, constant: 10).isActive = true
        containerView.leadingAnchor.constraint(equalTo:view.leadingAnchor, constant:10).isActive = true
        containerView.trailingAnchor.constraint(equalTo:view.trailingAnchor, constant:-10).isActive = true
        containerView.heightAnchor.constraint(equalToConstant:150).isActive = true
        
        //Name Label
        nameLabel.topAnchor.constraint(equalTo:self.containerView.topAnchor).isActive = true
        nameLabel.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
        
        //Title Label
        jobTitleDetailedLabel.leadingAnchor.constraint(equalTo:self.containerView.leadingAnchor).isActive = true
        jobTitleDetailedLabel.topAnchor.constraint(equalTo:self.nameLabel.bottomAnchor, constant: 16).isActive = true
        jobTitleDetailedLabel.trailingAnchor.constraint(equalTo:self.containerView.trailingAnchor).isActive = true
        
        //Release Date
        releaseDate.topAnchor.constraint(equalTo:self.jobTitleDetailedLabel.bottomAnchor, constant: 8).isActive = true
        releaseDate.leadingAnchor.constraint(equalTo:self.containerView.leadingAnchor).isActive = true
        releaseDate.trailingAnchor.constraint(equalTo: self.containerView.trailingAnchor).isActive = true
        
        //Genre
        genre.topAnchor.constraint(equalTo:self.releaseDate.bottomAnchor, constant: 8).isActive = true
        genre.leadingAnchor.constraint(equalTo:self.containerView.leadingAnchor).isActive = true
        genre.trailingAnchor.constraint(equalTo: self.containerView.trailingAnchor).isActive = true
        
        //iTunes Button
        iTunesButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        iTunesButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        iTunesButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20).isActive = true
        iTunesButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
    }
}
