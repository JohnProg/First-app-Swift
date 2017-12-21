import UIKit

class ListViewController: UITableViewController, IListView {
    
    @IBOutlet var employeeViewTable: UITableView!
    private let CHIEF = "Руководитель"
    private let EMPLOYEE = "Сотрудник"
    private let ACCOUNTANT = "Бухгалтер"
    
    private let SectionHeaderHeight: CGFloat = 25
    private var data = [TableSections: [Employee]]()
    
    //Типы секций. total - количество всех секций
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
        
        navigationItem.leftBarButtonItem = editButtonItem
        
        listController = ListController()
        listController?.attachView(newView: self)
    }
    
    override public func viewDidAppear(_ animated: Bool) {
        listController?.loadEmployees()
    }

    //Отображаем список сотрудников
    func showEmployees(loadedEmployees: [Employee]) {
        employees = loadedEmployees
        sortData()
        employeeViewTable.reloadData()
    }
    
    //Сортировка сотрудников по типу
    func sortData() {
        data[.chief] = employees?.filter({$0 .position! == CHIEF})
        data[.common_employee] = employees?.filter({$0 .position! == EMPLOYEE})
        data[.accountant] = employees?.filter({$0 .position! == ACCOUNTANT})
    }
    
    //Количество секций
    override func numberOfSections(in tableView: UITableView) -> Int {
        return TableSections.total.rawValue
    }

    //Количество сотрудников в одной секции
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let tableSection = TableSections(rawValue: section), let employees = data[tableSection] {
            return employees.count
        }
        return 0
    }
    
    //Возвращает высоту секции
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if let tableSection = TableSections(rawValue: section), let employees = data[tableSection], employees.count > 0 {
            return SectionHeaderHeight
        }
        return 0
    }
    
    //Определяет название секции
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
    
    //Устанавливает информацию о сотрудника в ячейке
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! EmployeeViewCell
        if let tableSection = TableSections(rawValue: indexPath.section), let employee = data[tableSection]?[indexPath.row] {
            cell.lblFullName.text = employee.fullName
            cell.lblSalary.text = employee.salary?.stringValue
        }
        return cell
    }
    
    //Включить/выключить Edit mode
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        employeeViewTable.setEditing(editing, animated: true)
    }
    
    //Удалить ячейку
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCellEditingStyle.delete {
            employees?.remove(at: (indexPath as NSIndexPath).row)
            employeeViewTable.deleteRows(at: [indexPath], with: UITableViewRowAnimation.automatic)
        }
    }
    
    //Включает Edit mode
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return self.isEditing
    }
    
    //Переместить ячейку
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let employee = employees?.remove(at: (sourceIndexPath as NSIndexPath).row)
        employees?.insert(employee!, at: (destinationIndexPath as NSIndexPath).row)
    }
}
