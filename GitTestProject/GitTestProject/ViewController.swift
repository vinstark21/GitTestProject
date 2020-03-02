//
//  ViewController.swift
//  GitTestProject
//
//  Created by finports_dev on 2020/02/19.
//  Copyright © 2020 finports_dev. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {
    
    @IBOutlet var label: UILabel!
    @IBOutlet var button: UIButton!
    
    var viewModel : ViewModel!
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let inputs = ViewModel.Inputs(tap: button.rx.tap.map{ _ in})
        
        viewModel = ViewModel(inputs)
        viewModel.number.drive(label.rx.text).disposed(by: disposeBag)
        
    }
}

