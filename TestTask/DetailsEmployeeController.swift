import Foundation


class DetailsEmployeeController : IDetailsEmployeeController {
    
    private var view: IDetailsEmployeeView?
    
    public func attachView(viewController: IDetailsEmployeeView) -> Void {
        view = viewController
    }
    
    public func viewIsReady() -> Void {
        
    }
    
    public func saveEmployee(employee: Employee) -> Void {
        
        employee.commit()
        
        let count = Employee.query().count()
        let count2 = Chief.query().count()
        let count3 = CommonEmployee.query().count()
        let count4 = Accountant.query().count()

        print("count in db: \(count)")
        print("count in db: \(count2)")
        print("count in db: \(count3)")
        print("count in db: \(count4)")
        
    }
    
    public func saveCommonEmployee(employee: CommonEmployee) -> Void {
        employee.commit()
        
        
        let count = CommonEmployee.query().count()
        print("count in db: \(count)")
        
        let result = CommonEmployee.query().fetch()
        var empl = CommonEmployee()
        for employee in result! {
            empl = employee as! CommonEmployee
        }
        
//        let a3 = CommonEmployee.query().fetch()
//        print(a3)
//        print(empl.lunchTime)
        print(empl.fullName)
        print(empl.salary)
        print(empl.lunchTime)
        print(empl.numberWorkspace)
        
        print("adsf")
    }
    
    
    
}
