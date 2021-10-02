//
//  ViewController.swift
//  BeerApp
//
//  Created by Gabriel on 27/09/21.
//

import UIKit
import Kingfisher
import CoreData

class HomeViewController: UIViewController, NSFetchedResultsControllerDelegate  {
    
    private var viewModelBeer = BeerViewModel()
    let cellBeerReuseIdentifier = "cellBeerReuseIdentifier"
    let searchController = UISearchController(searchResultsController: nil)
    var fetchedResultController: NSFetchedResultsController<BeerModel>!
    var beerResults = [BeerModelApi]()
    var timer: Timer?
    var position: String?
    
    lazy var beerTableView : UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .clear
        tableView.delegate = self
        tableView.dataSource = self
        tableView.reloadData()
        tableView.register(BeerHomeTableViewCell.self, forCellReuseIdentifier: cellBeerReuseIdentifier)
        tableView.separatorColor = .clear
        tableView.showsVerticalScrollIndicator = false
        return tableView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        viewModelBeer.homeViewController = self
        viewModelBeer.getSearchBeerDataAF(query: position)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            if  position == searchController.searchBar.text {
                    self.viewModelBeer.getSearchBeerDataAF(query: position)
                   
              }
            }
 
    func setupNavigationBar() {
        let attributes = [NSAttributedString.Key.font: UIFont(name: "Arial-BoldMT", size: 25)!, NSAttributedString.Key.foregroundColor: UIColor.brown]
        navigationController?.navigationBar.titleTextAttributes = attributes
        navigationController?.navigationBar.barTintColor = .systemYellow
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.tintColor = .white
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationItem.title = "Beer list"
    }
    
    func setupSearchController(){
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchBar.delegate = self
        let textFieldInsideSearchBar = searchController.searchBar.value(forKey: "searchField") as? UITextField
        textFieldInsideSearchBar?.placeholder = "Search a Beer 🍺"
        navigationItem.searchController = searchController
        definesPresentationContext = true
        searchController.searchBar.setCenteredPlaceHolder()
    }
    
}

extension HomeViewController: CodeView {
    
    public func setupView() {
        view.backgroundColor = .primary
        setupHierarchy()
        setupConstraints()
        setupAdditionalConfigurations()
    }
    
    func setupAdditionalConfigurations() {
        setupNavigationBar()
        setupSearchController()
    }
    
    func setupHierarchy() {
        view.addSubview(beerTableView)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            beerTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            beerTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            beerTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant:  -20),
            beerTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -45),
        ])
    }
    
    func navigationDetail() {
        self.navigationController?.navigationBar.backgroundColor = .systemYellow
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.orange, .font: UIFont.systemFont(ofSize: 35, weight: UIFont.Weight.heavy)]
        self.navigationController?.navigationBar.tintColor = .systemYellow
        self.navigationController?.setNavigationBarHidden(navigationController?.isNavigationBarHidden == false, animated: false);
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
    
}

extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let rootVc = BeerDetailViewController()
        let beerCell =   viewModelBeer.cellForRowAt(indexPath: indexPath)
        let poster: String? = beerCell.image_url ?? ""
        let imagePlaceHolder = UIImageView()
        imagePlaceHolder.contentMode = .scaleAspectFit
        imagePlaceHolder.image = UIImage(named: "placeholder")
        guard let url = URL(string: poster ?? "" ) else { return }
        let resource = ImageResource(downloadURL: url, cacheKey: beerCell.image_url)
        let placeholder = imagePlaceHolder.image
        rootVc.imageBeerDetail.kf.setImage(with: resource, placeholder: placeholder)
        rootVc.titleOriginal =  beerCell.name ?? "oie"
        rootVc.titleDescription =  beerCell.description ?? "oie"
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        self.navigationController?.pushViewController(rootVc, animated: true)
    }
}

extension HomeViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 160
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  viewModelBeer.arrBeer.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellBeerReuseIdentifier, for: indexPath) as! BeerHomeTableViewCell
        let beerCell =   viewModelBeer.cellForRowAt(indexPath: indexPath)
        cell.setCellWithValuesOf(beerCell)
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.contentView.backgroundColor = .brown.withAlphaComponent(1.5)
        cell.selectionStyle = .none
        let radius = cell.contentView.layer.cornerRadius
        cell.layer.shadowPath = UIBezierPath(roundedRect: cell.bounds, cornerRadius: radius).cgPath
        cell.contentView.layer.masksToBounds = true
    }
}


extension HomeViewController: UISearchResultsUpdating, UISearchBarDelegate {
    func updateSearchResults(for searchController: UISearchController) {
        
    }
    
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchController.searchBar.resignFirstResponder()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {

    }
    
    }

