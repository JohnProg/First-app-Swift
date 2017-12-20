import UIKit

class ListViewController: UITableViewController, IListView {
    
    private let SectionHeaderHeight: CGFloat = 25
    private let sections = ["Руководитель", "Сотрудник", "Бухгалтер"]
    private var data = [TableSections: [Employee]]()
    
    enum TableSections: Int {
        case chief = 0,
        common_employee,
        accountant,
        total
    }
    
    private var employees: [Employee]?
    
    private var listController: IListController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        listController = ListController()
        listController?.attachView(newView: self)
        listController?.loadEmployees()
    }

    func showEmployees(loadedEmployees: [Employee]) {
        employees = loadedEmployees
        sortData()
        
        
//        for employee in loadedEmployees {
//            print(employee.position! + " : " + employee.fullName!)
//        }
    }
    
    func sortData() {
        data[.chief] = employees?.filter({$0 .position! == "Руководитель"})
        data[.common_employee] = employees?.filter({$0 .position! == "Сотрудник"})
        data[.accountant] = employees?.filter({$0 .position! == "Бухгалтер"})
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return TableSections.total.rawValue
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let tableSection = TableSections(rawValue: section), let employees = data[tableSection] {
            return employees.count
        }
        return 0
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if let tableSection = TableSections(rawValue: section), let employees = data[tableSection], employees.count > 0 {
            return SectionHeaderHeight
        }
        return 0
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: tableView.bounds.width, height: SectionHeaderHeight))
        view.backgroundColor = UIColor(red: 245.0/255.0, green: 245.0/255.0, blue: 245.0/255.0, alpha: 1)
        let label = UILabel(frame: CGRect(x: 15, y: 0, width: tableView.bounds.width - 30, height: SectionHeaderHeight))
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.textColor = UIColor.black
        if let tableSection = TableSections(rawValue: section) {
            switch tableSection {
            case .chief:
                label.text = "Руководители"
            case .common_employee:
                label.text = "Сотрудники"
            case .accountant:
                label.text = "Бухгалтеры"
            default:
                label.text = ""
            }
        }
        view.addSubview(label)
        return view
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! EmployeeViewCell
        
        if let tableSection = TableSections(rawValue: indexPath.section), let employee = data[tableSection]?[indexPath.row] {
            if let titleLabel = cell.viewWithTag(10) as? UILabel {
                titleLabel.text = employee.fullName
            }
            if let subtitleLabel = cell.viewWithTag(20) as? UILabel {
                subtitleLabel.text = employee.salary?.stringValue
            }
        }
        return cell
    }
}
