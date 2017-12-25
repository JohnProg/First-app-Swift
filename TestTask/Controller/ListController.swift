import Foundation


class ListController: IListController {
    
    private var view: IListView?
    
    func attachView(newView: IListView) {
        view = newView
    }
    
    func loadEmployees() {
        let employeeRepository = EmployeeRepository()
        view?.showEmployees(loadedEmployees: employeeRepository.getAllEmployees())
    }
    
    func sortByAlphabet() {
        let employeeRepository = EmployeeRepository()
        employeeRepository.sortByAlphabet()
    }
    
    func sortByUser(employee: [Employee]) {
        
    }
    
    func removeEmployee(employee: Employee)  {
        let employeeRepository = EmployeeRepository()
        employeeRepository.removeEmployee(employee: employee)
    }
    
    
}
