//
//  SearchInteractor.swift
//  iSound
//
//  Created by Игорь Попов on 08.09.2020.
//  Copyright (c) 2020 AirIgor. All rights reserved.
//

import UIKit

protocol SearchBusinessLogic {
  func makeRequest(request: Search.Model.Request.RequestType)
}

class SearchInteractor: SearchBusinessLogic {

    var networkService = NetworkService()
  var presenter: SearchPresentationLogic?
  var service: SearchService?
  
  func makeRequest(request: Search.Model.Request.RequestType) {
    if service == nil {
      service = SearchService()
    }
    switch request {
    case .getTracks(let searchTerm):
        print("interactor .getTracks")
        presenter?.presentData(response: Search.Model.Response.ResponseType.presentFooterView)
        networkService.fetchTrack(searchText: searchTerm) { [weak self] (searchResponse) in
            self?.presenter?.presentData(response: Search.Model.Response.ResponseType.presentTracks(searchResponse: searchResponse))

        }
    }
    
  }
  
}
