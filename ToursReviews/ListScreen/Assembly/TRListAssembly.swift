//
//  TRListAssembly.swift
//  ToursReviews
//
//  Created by Balu Naik on 7/13/19.
//  Copyright © 2019 Balu Naik. All rights reserved.
//

import UIKit

class TRListAssembly: NSObject {
    
    required override init() {
        super.init()
    }
    
    func assemblyModule() -> UIViewController {
        
        return self.viewControllerForList()
    }
    
    fileprivate func viewControllerForList() -> TRListViewController {
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = mainStoryboard.instantiateViewController(withIdentifier: "TRListViewController") as? TRListViewController
        viewController?.presenter = self.presenterModuleWithVC(controller: viewController!)
        
        return viewController!
    }
    
    fileprivate func presenterModuleWithVC(controller: TRListViewController) -> TRListPresenter {
        let presenter = TRListPresenter()
        presenter.userInterface = controller
        presenter.interactor = self.interactorModuleWithPresenter(presenter: presenter)
        
        return presenter
    }
    
    fileprivate func interactorModuleWithPresenter(presenter: TRListPresenter) -> TRListInteractor {
        let interactor = TRListInteractor()
        interactor.presenter = presenter
        
        return interactor
    }
}

