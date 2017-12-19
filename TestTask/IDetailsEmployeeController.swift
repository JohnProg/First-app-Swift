import Foundation

protocol IDetailsEmployeeController {
    func attachView(viewController: IDetailsEmployeeView) -> Void
    func viewIsReady() -> Void
    func saveEmployee(employee: Employee) -> Void
    func saveCommonEmployee(employee: CommonEmployee) -> Void
}
