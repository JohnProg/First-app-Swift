import Foundation


class ListController: IListController {
    
    private var view: IListView?
    private let employeeRepository: EmployeeRepository
    
    init() {
        employeeRepository = EmployeeRepository()
    }
    
    func attachView(newView: IListView) {
        view = newView
    }
    
    func loadEmployees() {
        view?.showEmployees(loadedEmployees: employeeRepository.getAllEmployees())
    }
    
    func sortByAlphabet() {
        employeeRepository.sortByAlphabet()
    }
    
    func sortByUser(employees: [Employee], typeEmployee: String) {
        employeeRepository.sortByUser(employees: employees, typeEmployee: typeEmployee)
    }
    
    func removeEmployee(employee: Employee)  {
        employeeRepository.removeEmployee(employee: employee)
    }
    
}
