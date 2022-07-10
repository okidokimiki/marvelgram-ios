//
//  Coordinator.swift
//  marvelgram
//
//  Created by Mikhail Chaus on 29.06.2022.
//

protocol Coordinator: AnyObject {
    var childCoordinators: [Coordinator] { get }
    
    func start()
}
