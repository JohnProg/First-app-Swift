import Foundation

protocol IListController {
    func attachView(newView: IListView)
    func loadEmployees()
}
