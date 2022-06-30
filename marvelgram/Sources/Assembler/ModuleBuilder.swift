//
//  ModuleBuilder.swift
//  marvelgram
//
//  Created by Mikhail Chaus on 07.06.2022.
//

import UIKit

protocol ModuleBuilder {
    static func createModule(with type: ModuleType, _ coordinator: Coordinator) -> UIViewController
}
