//
//  HomeViewModel.swift
//  ArticleMiniProject
//
//  Created by faiq adi on 25/04/25.
//

import Foundation
import RxSwift
import RxCocoa

class HomeViewModel{
    
    let api = NetworkService.sharedInstance
    var listArtikelRelay =  BehaviorRelay<DataState<[Article]?>>(value: .initiate)
    var listBlogRelay =  BehaviorRelay<DataState<[Article]?>>(value: .initiate)
    var listReportRelay =  BehaviorRelay<DataState<[Article]?>>(value: .initiate)
    
    func getArtikelList(count: Int){
        listArtikelRelay.accept(.loading)
        api.getArtikel(count: count){[weak self] status, successResponse, errorResponse, error in
            guard let self, status else {
                self?.listArtikelRelay.accept(.error(errorResponse ?? error ?? .custom(message: "Unexpected error")))
                return
            }
            listArtikelRelay.accept(.next(successResponse?.results))
        }
    }
    func getBlogList(count: Int){
        api.getBlog(count: count){[weak self] status, successResponse, errorResponse, error in
            guard let self, status else {
                self?.listBlogRelay.accept(.error(errorResponse ?? error ?? .custom(message: "Unexpected error")))
                return
            }
            listBlogRelay.accept(.next(successResponse?.results))
        }
    }
    func getReportList(count: Int){
        api.getReports(count: count){[weak self] status, successResponse, errorResponse, error in
            guard let self, status else {
                self?.listReportRelay.accept(.error(errorResponse ?? error ?? .custom(message: "Unexpected error")))
                return
            }
            listReportRelay.accept(.next(successResponse?.results))
        }
    }
}
