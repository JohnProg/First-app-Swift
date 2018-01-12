import Foundation

class EmployeeRepository {
    
    public func saveEmployee(newEmployee: Employee) {
        var employees: [Employee]
        
        switch newEmployee.position {
        case PosisitionsEmployee.Chief.rawValue?:
            employees = Chief.query().fetch().reversed() as! [Employee]
        case PosisitionsEmployee.CommonEmployee.rawValue?:
            employees = CommonEmployee.query().fetch().reversed() as! [Employee]
        case PosisitionsEmployee.Accountant.rawValue?:
            employees = Accountant.query().fetch().reversed() as! [Employee]
        default:
            return
        }
        
        print(employees)
        
        employees.append(newEmployee)
        
        print(employees)
        
        if let typeEmployee = newEmployee.position {
            removeDataFromTable(typeEmployee: typeEmployee)
        }
        
        for i in stride(from: employees.count-1, through: 0, by: -1) {
            employees[i].id = nil
            employees[i].commit()
        }
    }
    
    public func removeEmployee(employee: Employee) {
        employee.remove()
    }
    
    public func getAllEmployees() -> [Employee] {
        var employees = CommonEmployee.query().fetch().reversed()
        employees.append(contentsOf: Chief.query().fetch().reversed())
        employees.append(contentsOf: Accountant.query().fetch().reversed())
        
        print(employees)
        
        return employees as! [Employee]
    }
    
    public func editEmployee(editedEmploye: Employee) {
        switch editedEmploye.position {
        case PosisitionsEmployee.Chief.rawValue?:
            Chief.query()
                .where(withFormat: "id = %@", withParameters: [editedEmploye.id])
                .fetch()
                .removeAll()
        case PosisitionsEmployee.CommonEmployee.rawValue?:
            CommonEmployee.query()
                .where(withFormat: "id = %@", withParameters: [editedEmploye.id])
                .fetch()
                .removeAll()
        case PosisitionsEmployee.Accountant.rawValue?:
            Accountant.query()
                .where(withFormat: "id = %@", withParameters: [editedEmploye.id])
                .fetch()
                .removeAll()
        default:
            break
        }
        
        editedEmploye.commit()
    }
    
    public func sortByUser(employees: [Employee], typeEmployee: String) {
        removeDataFromTable(typeEmployee: typeEmployee)
        
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
        
        removeDataFromAllTables()
        
        let sortedEmployees = querySortedEmployees as! [Employee]
        for employee in sortedEmployees {
            employee.id = nil
            employee.commit()
        }
    }
    
    private func removeDataFromTable(typeEmployee: String) {
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
    }
    
    private func removeDataFromAllTables() {
        CommonEmployee.query().fetch().removeAll()
        Chief.query().fetch().removeAll()
        Accountant.query().fetch().removeAll()
    }
    
}
