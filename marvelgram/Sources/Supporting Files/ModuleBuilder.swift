import UIKit

protocol ModuleBuilder {
    static func createModule(coordinator: Coordinator) -> UIViewController
}
