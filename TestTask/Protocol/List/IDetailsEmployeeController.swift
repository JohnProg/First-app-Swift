import Foundation

protocol IDetailsEmployeeController {
    func attachView(viewController: IDetailsEmployeeView)
    func viewIsReady()
    func saveEmployee(employee: Employee)
    func editEmployee(employee: Employee)
}
