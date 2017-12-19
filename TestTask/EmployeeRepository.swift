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
        let a3 = CommonEmployee.query().fetch().reversed()
        print(a3)
        
        
//        let employees = Employee.query().fetch().accessibilityElements
//        let result = employees as! [Employee]
        
        return a3 as! [Employee]
    }
    
    public func editEmployee(editedEmploye: Employee) -> Void {
        Employee.query().where(withFormat: "id == %@", withParameters: [editedEmploye.id]).fetch().removeAll()
        editedEmploye.commit()
    }
    
}
