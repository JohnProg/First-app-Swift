import Foundation

class EmployeeRepository {
    
    public func saveEmployee(employee: Employee) {
        employee.commit()
    }
    
    public func removeEmployee(employee: Employee) {
        employee.remove()
    }
    
    public func getAllEmployees() -> [Employee] {
        var employees = CommonEmployee.query().fetch().reversed()
        employees.append(contentsOf: Chief.query().fetch().reversed())
        employees.append(contentsOf: Accountant.query().fetch().reversed())
        
        return employees as! [Employee]
    }
    
    public func editEmployee(editedEmploye: Employee) {
        Chief.query()
            .where(withFormat: "id = %@", withParameters: [editedEmploye.id])
            .fetch()
            .removeAll()
        
        CommonEmployee.query()
            .where(withFormat: "id = %@", withParameters: [editedEmploye.id])
            .fetch()
            .removeAll()
        
        Accountant.query()
            .where(withFormat: "id = %@", withParameters: [editedEmploye.id])
            .fetch()
            .removeAll()
        
        editedEmploye.commit()
    }
    
    public func sortByUser(employees: [Employee], typeEmployee: String) {
        switch typeEmployee {
        case PosisitionsEmployee.Chief.rawValue:
            Chief.query().fetch().removeAll()
        case PosisitionsEmployee.CommonEmployee.rawValue:
            CommonEmployee.query().fetch().removeAll()
        case PosisitionsEmployee.Accountant.rawValue:
            Accountant.query().fetch().removeAll()
        default:
            break
        }
        
        for i in stride(from: employees.count-1, through: 0, by: -1) {
            employees[i].id = nil
            employees[i].commit()
        }
    }
    
    //Тупо костыли. Руки надо бы отрубить :(
    //Но костыли оправданы. SharkORM багованая ***
    public func sortByAlphabet() {
        var querySortedEmployees = CommonEmployee.query().order(by: "fullName").fetch().reversed()
        querySortedEmployees.append(contentsOf: Chief.query().order(by: "fullName").fetch().reversed())
        querySortedEmployees.append(contentsOf: Accountant.query().order(by: "fullName").fetch().reversed())
        
        CommonEmployee.query().fetch().removeAll()
        Chief.query().fetch().removeAll()
        Accountant.query().fetch().removeAll()
        
        let sortedEmployees = querySortedEmployees as! [Employee]
        for employee in sortedEmployees {
            employee.id = nil
            employee.commit()
        }
    }
    
}
