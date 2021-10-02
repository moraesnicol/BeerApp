//
//  BeerDataManager.swift
//  BeerApp
//
//  Created by Gabriel on 28/09/21.
//

import Foundation
import CoreData


class BeerDataManager {
    static let shared = BeerDataManager()
    var beers: [BeerModel] = []
    
    func loadBeer(with context: NSManagedObjectContext) {
        let fetchRequest: NSFetchRequest<BeerModel> = BeerModel.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "id", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        do {
            beers = try context.fetch(fetchRequest)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func deleteBeer(index: Int, context: NSManagedObjectContext) {
        let beer = beers[index]
        context.delete(beer)
        
        do {
            try context.save()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    
    private init() {
        
    }
    
}
