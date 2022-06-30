//
//  Coordinator.swift
//  marvelgram
//
//  Created by Mikhail Chaus on 29.06.2022.
//

import Foundation

protocol Coordinator: AnyObject {
    var parent: Coordinator? { get set }
    var childCoordinators: [Coordinator] { get set }
    
    func start()
    func childCoordinatorWillStart(_ chlid: Coordinator)
    func childCoordinatorDidFinish(_ child: Coordinator)
}

extension Coordinator {
    func childCoordinatorWillStart(_ chlid: Coordinator) {
      guard !childCoordinators.contains(where: { $0 === chlid }) else { return }
      childCoordinators.append(chlid)
    }

    func childCoordinatorDidFinish(_ child: Coordinator) {
        guard childCoordinators.isEmpty == false else { return }

        for (index, element) in childCoordinators.enumerated() where element === child {
            childCoordinators.remove(at: index)
            break
        }
    }
}
