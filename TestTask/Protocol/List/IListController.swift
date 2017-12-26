import Foundation

protocol IListController {
    func attachView(newView: IListView)
    func loadEmployees()
    func sortByAlphabet()
    func sortByUser(employees: [Employee], typeEmployee: String)
    func removeEmployee(employee: Employee)
}
