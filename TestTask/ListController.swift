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
    
    
}
