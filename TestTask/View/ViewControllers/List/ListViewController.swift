import UIKit

class ListViewController: UITableViewController, IListView {
    
    private var listController: IListController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        listController = ListController()
        listController?.attachView(newView: self)
        listController?.loadEmployees()
    }

    func showEmployees(loadedEmployees: [Employee]) {
        for employee in loadedEmployees {
            print(employee.position! + " : " + employee.fullName!)
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }

   

}
