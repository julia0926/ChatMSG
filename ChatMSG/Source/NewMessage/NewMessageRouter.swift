//
//  NewMessageRouter.swift
//  ChatMSG
//
//  Created by Julia on 2023/04/26.
//  Copyright (c) 2023 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol NewMessageRoutingLogic {
  //func routeToSomewhere()
}

protocol NewMessageDataPassing {
    var dataStore: NewMessageDataStore? { get }
}

final class NewMessageRouter: NewMessageRoutingLogic, NewMessageDataPassing {
    weak var viewController: NewMessageViewController?
    var dataStore: NewMessageDataStore?
  

    // MARK: -  Routing
    
//    func routeToSomewhere() {
//        let destinationVC = UIViewController()
//        guard var destinationDS = destinationVC.router?.dataStore else { return }
//        guard let dataStore = dataStore else { return }
//        guard let viewController = viewController else { return }
//        passDataToSomewhere(source: dataStore, destination: &destinationDS)
//        navigateToSomewhere(source: viewController, destination: destinationVC)
//    }

  // MARK: - Navigation
  
//    func navigateToSomewhere(source: NewMessageViewController, destination: SomewhereViewController) {
//        source.show(destination, sender: nil)
//    }
  
  // MARK: - Passing data
  
//    func passDataToSomewhere(source: NewMessageDataStore, destination: inout SomewhereDataStore) {
//        destination.name = source.name
//    }
}
