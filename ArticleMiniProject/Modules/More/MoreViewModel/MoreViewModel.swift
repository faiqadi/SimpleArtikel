//
//  MoreViewModel.swift
//  ArticleMiniProject
//
//  Created by faiq adi on 25/04/25.
//

import RxSwift
import RxCocoa

class MoreViewModel{
    
    let api = NetworkService.sharedInstance
    
    var listDataRelay =  BehaviorRelay<DataState<[Article]?>>(value: .initiate)
    var searchDataRelay =  BehaviorRelay<DataState<[Article]?>>(value: .initiate)
    
    func getArtikelList(count: Int){
        listDataRelay.accept(.loading)
        api.getArtikel(count: count){[weak self] status, successResponse, errorResponse, error in
            guard let self, status else {
                self?.listDataRelay.accept(.error(errorResponse ?? error ?? .custom(message: "Unexpected error")))
                return
            }
            listDataRelay.accept(.next(successResponse?.results))
        }
    }
    func getBlogList(count: Int){
        listDataRelay.accept(.loading)
        api.getBlog(count: count){[weak self] status, successResponse, errorResponse, error in
            guard let self, status else {
                self?.listDataRelay.accept(.error(errorResponse ?? error ?? .custom(message: "Unexpected error")))
                return
            }
            listDataRelay.accept(.next(successResponse?.results))
        }
    }
    func getReportList(count: Int){
        listDataRelay.accept(.loading)
        api.getReports(count: count){[weak self] status, successResponse, errorResponse, error in
            guard let self, status else {
                self?.listDataRelay.accept(.error(errorResponse ?? error ?? .custom(message: "Unexpected error")))
                return
            }
            listDataRelay.accept(.next(successResponse?.results))
        }
    }
    
    func searchArtikel(title: String, type: MorePageType){
        searchDataRelay.accept(.loading)
       
        switch type {
        case .Artikel:
            api.getArtikelSearch(title: title){[weak self] status, successResponse, errorResponse, error in
                guard let self, status else {
                    self?.searchDataRelay.accept(.error(errorResponse ?? error ?? .custom(message: "Unexpected error")))
                    return
                }
                searchDataRelay.accept(.next(successResponse?.results))
            }
        case .Blog:
            api.getBlogContain(title: title){[weak self] status, successResponse, errorResponse, error in
                guard let self, status else {
                    self?.searchDataRelay.accept(.error(errorResponse ?? error ?? .custom(message: "Unexpected error")))
                    return
                }
                searchDataRelay.accept(.next(successResponse?.results))
            }
        case .Reports:
            api.getReportContain(title: title){[weak self] status, successResponse, errorResponse, error in
                guard let self, status else {
                    self?.searchDataRelay.accept(.error(errorResponse ?? error ?? .custom(message: "Unexpected error")))
                    return
                }
                searchDataRelay.accept(.next(successResponse?.results))
            }
        }
    }
    
    
}
