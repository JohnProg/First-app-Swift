import Foundation


class DetailsEmployeeController : IDetailsEmployeeController {
    
    private var view: IDetailsEmployeeView?
    
    public func attachView(viewController: IDetailsEmployeeView) {
        view = viewController
    }
    
    public func viewIsReady() {
        
    }
    
    public func saveEmployee(employee: Employee) {
        let employeeRepository = EmployeeRepository()
        employeeRepository.saveEmployee(employee: employee)
    }
    
    public func editEmployee(employee: Employee) {
        let employeeRepository = EmployeeRepository()
        employeeRepository.editEmployee(editedEmploye: employee)
    }
    
}
