import Foundation

protocol IListController {
    func attachView(newView: IListView)
    func loadEmployees()
    func sortByAlphabet()
    func sortByUser(employee: [Employee])
    func removeEmployee(employee: Employee)
}
