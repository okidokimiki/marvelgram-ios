import UIKit

protocol ModuleBuilder {
    static func createModule(with type: ModuleType, coordinator: Coordinator) -> UIViewController
}

enum ModuleType {
    case heroDetails(HeroDetailsDataSource?)
    case `default`
}
