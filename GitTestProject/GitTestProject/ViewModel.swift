//
//  ViewModel.swift
//  GitTestProject
//
//  Created by finports_dev on 2020/02/19.
//  Copyright © 2020 finports_dev. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa


class ViewModel {
        
    struct Inputs {
        let tap: Observable<Void>
    }
    
    private let model = BehaviorRelay<Model>(value: .init(number: 100))
    
    let number: Driver<String>
    
    let disposeBag = DisposeBag()
    
    init(_ inputs: Inputs) {
        
        number = model
            .map { "\($0.number)" }
            .asDriver(onErrorRecover: { _ in .empty() })
        
        inputs.tap
            .withLatestFrom(model)
            .map { model -> Model in
                var nextModel = model
                nextModel.number += 1
                return nextModel
            }.bind(to: model)
            .disposed(by: disposeBag)
    }
}

