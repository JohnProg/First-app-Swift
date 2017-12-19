import Foundation

class EmployeeRepository {
    
    public func saveEmployee(employee: Employee) -> Void {
        employee.commit()
    }
    
    public func removeEmployee(employeeId: Int) -> Void {
        Employee.query()
                .where(withFormat: "id == %@", withParameters: [employeeId])
                .fetch()
                .removeAll()
    }
    
    public func getAllEmployees() -> [Employee] {
        var employees = CommonEmployee.query().fetch().reversed()
        employees.append(contentsOf: Chief.query().fetch().reversed())
        employees.append(contentsOf: Accountant.query().fetch().reversed())
        
        return employees as! [Employee]
    }
    
    public func editEmployee(editedEmploye: Employee) -> Void {
        Employee.query().where(withFormat: "id == %@", withParameters: [editedEmploye.id]).fetch().removeAll()
        editedEmploye.commit()
    }
    
}
