//
//  RxModelView.swift
//  GitTestProject
//
//  Created by finports_dev on 2020/02/19.
//  Copyright © 2020 finports_dev. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

class RxModelView {
    var count = Variable<Int>(0)

    func autoPlus(){
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            let cnt = self.count.value
               if cnt < 3{
                 print("count = \(cnt)")
                 self.count.value = AddCount(value: cnt)
                 self.autoPlus()
                }else{
                 self.count.value = 0
                }
            
        }
    }
    
    
}


