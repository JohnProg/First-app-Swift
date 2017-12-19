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
    }
    
}
