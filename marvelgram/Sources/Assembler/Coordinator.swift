//
//  Coordinator.swift
//  marvelgram
//
//  Created by Mikhail Chaus on 29.06.2022.
//

import UIKit

protocol Coordinator: AnyObject {
    var childCoordinators: [Coordinator] { get }
    
    func start()
}
