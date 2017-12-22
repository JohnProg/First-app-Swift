import Foundation

class EmployeeRepository {
    
    public func saveEmployee(employee: Employee) -> Void {
        employee.commit()
    }
    
    public func removeEmployee(employee: Employee) -> Void {
        employee.remove()
    }
    
    public func getAllEmployees() -> [Employee] {
        var employees = CommonEmployee.query().fetch().reversed()
        employees.append(contentsOf: Chief.query().fetch().reversed())
        employees.append(contentsOf: Accountant.query().fetch().reversed())
        
        var i = 0
        for employee in employees {
            print("Employee \(i) = \(employee)")
            i += 1
        }
        
        return employees as! [Employee]
    }
    
    public func editEmployee(editedEmploye: Employee) -> Void {
        Employee.query().where(withFormat: "id == %@", withParameters: [editedEmploye.id]).fetch().removeAll()
        editedEmploye.commit()
    }
    
    public func sortByUser(employee: Employee) {
//        Employee.query()
//            .where(withFormat: "id == %@", withParameters: [employeeId])
//            .fetch()
//            .removeAll()
    }
    
    //Тупо костыли. Руки надо бы отрубить :(
    public func sortByAlphabet() {
        var querySortedEmployees = CommonEmployee.query().order(by: "fullName").fetch().reversed()
        querySortedEmployees.append(contentsOf: Chief.query().order(by: "fullName").fetch().reversed())
        querySortedEmployees.append(contentsOf: Accountant.query().order(by: "fullName").fetch().reversed())
        
        CommonEmployee.query().fetch().removeAll()
        Chief.query().fetch().removeAll()
        Accountant.query().fetch().removeAll()
        
        let sortedEmployees = querySortedEmployees as! [Employee]
        var i = 0
        
        for employee in sortedEmployees {
            employee.id = NSNumber.init(value: i)
            employee.commit()
            i += 1
        }
    }
    
}
