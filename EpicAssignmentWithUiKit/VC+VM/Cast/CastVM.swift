//
//  CastVM.swift
//  EpicAssignmentWithUiKit
//
//  Created by Himash Nadeeshan on 2021-11-10.
//

import Foundation
import Combine

class CastVM {
    var tabItems = ["Action", "Commedy", "Drama", "Fantacy", "Horror", "Mystery", "Romance", "Thriller"]
    var castList : [Cast] = []
    var networkManager: APIService
    var cancellables = Set<AnyCancellable>()
    
    init(networkManager: APIService = NetworkManager()) {
        self.networkManager = networkManager
    }
}

//MARK: Networkcall
extension CastVM: CastService{
    func getCastList(limit: Int, completion: @escaping (_ status : Bool, _ message: String) -> ()) {
        let cancellable = self.getCastList(limit: 5)
            .sink(receiveCompletion: { result in
                switch result {
                case .failure(let error):
                    print("Handle error: \(error)")
                    completion(false, error.localizedDescription)
                case .finished:
                    completion(true, "Success!")
                    break
                }
                
            }) { (cast) in
                self.castList = cast
        }
        cancellables.insert(cancellable)
    }
}
