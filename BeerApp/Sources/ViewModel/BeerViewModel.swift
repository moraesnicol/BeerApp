//
//  BeerViewModel.swift
//  BeerApp
//
//  Created by Gabriel on 28/09/21.
//

import UIKit
import Alamofire
import Foundation

 class BeerViewModel {
    
    weak var homeViewController: HomeViewController?
    var arrBeer = [BeerModelApi]()
    public var idResquest = ""
    
    func getAllBeerDataAF(id: String?) {
        
        let baseUrl = "https://api.punkapi.com/v2/beers/\(idResquest)"
        AF.request(baseUrl).response { response in
            if let data = response.data {
                do {
                    let beerResponse = try? JSONDecoder().decode([BeerModelApi].self, from: data)
                    self.arrBeer.append(contentsOf: beerResponse ?? [])
                    DispatchQueue.main.async {
                        self.homeViewController?.beerTableView.reloadData()
                    }
                    print("@@@@ beerResponseArray: \(self.arrBeer)")
                }
            }
        }
    }
    
    func getSearchBeerDataAF(query: String?) {
        let baseUrl = "https://api.punkapi.com/v2/beers?beer_name=\(query?.replacingOccurrences(of: " ", with: ""))"
        AF.request(baseUrl).response { response in
            if let data = response.data {
                do {
                    let beerResponse = try? JSONDecoder().decode([BeerModelApi].self, from: data)
                    self.arrBeer.append(contentsOf: beerResponse ?? [])
                    DispatchQueue.main.async {
                        self.homeViewController?.beerTableView.reloadData()
                    }
                    print("@@@@ beerResponseArray: \(self.arrBeer)")
                }
            }
        }
    }
    
    
    
    func numberOfRowsInSection(section: Int) -> Int {
        if arrBeer.count != 0 {
            print(arrBeer.count)
            return arrBeer.count
        }
        return 0
    }
    
    func cellForRowAt(indexPath: IndexPath) -> BeerModelApi {
        return   arrBeer[indexPath.row]
    }
    
}
