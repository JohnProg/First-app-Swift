import UIKit

class ListViewController: UITableViewController, IListView {
    
    @IBOutlet var employeeViewTable: UITableView!
    var listIsEmpty: UILabel!
    
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
        
        employeeViewTable.tableFooterView = UIView()
        
        navigationItem.leftBarButtonItem = editButtonItem
        
        listController = ListController()
        listController?.attachView(newView: self)
    }
    
    override public func viewDidAppear(_ animated: Bool) {
        listController?.loadEmployees()
    }

    //Отображаем список сотрудников
    func showEmployees(loadedEmployees: [Employee]) {
        if loadedEmployees.count == 0 {
            showListIsEmptyView()
        } else {
            employeeViewTable.backgroundView = nil
        }
        
        employees = loadedEmployees
        sortEmployeesByType()
        employeeViewTable.reloadData()
    }
    
    func showListIsEmptyView() {
        listIsEmpty = UILabel(frame: CGRect(x: 0,
                                            y: 0,
                                            width: self.view.bounds.size.width,
                                            height: self.view.bounds.size.height))
        
        listIsEmpty.numberOfLines = 0
        listIsEmpty.textAlignment = .center
        listIsEmpty.text = NSLocalizedString("list_is_empty", comment: "")
        employeeViewTable.backgroundView = listIsEmpty
    }
    
    //Сортировка сотрудников по типу
    func sortEmployeesByType() {
        data[.chief] = employees?.filter({$0 .position! == PosisitionsEmployee.Chief.rawValue})
        data[.common_employee] = employees?.filter({$0 .position! == PosisitionsEmployee.CommonEmployee.rawValue})
        data[.accountant] = employees?.filter({$0 .position! == PosisitionsEmployee.Accountant.rawValue})
    }
    
    //Открывает экран для редактирования
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "editEmployee" {
            let detailsView = segue.destination as! DetailsEmployeeVeiwController
            let indexPath = employeeViewTable.indexPathForSelectedRow
            
            let tableSection = TableSections(rawValue: (indexPath?.section)!)
            detailsView.employee = data[tableSection!]?[(indexPath?.row)!]
        }
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
                label.text = NSLocalizedString("section_chiefs", comment: "")
            case .common_employee:
                label.text = NSLocalizedString("section_employee", comment: "")
            case .accountant:
                label.text = NSLocalizedString("section_accountant", comment: "")
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
            cell.lblSalary.text = NSLocalizedString("salary", comment: "") + ": \(employee.salary ?? 0)"
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
            let tableSection = TableSections(rawValue: (indexPath.section))
            let employee = data[tableSection!]?[(indexPath.row)]
            listController?.removeEmployee(employee: employee!)
            listController?.loadEmployees()
        }
    }
    
    //Определяет можно ли перемещать ячейку
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return self.isEditing
    }
    
    override func tableView(_ tableView: UITableView,
                            targetIndexPathForMoveFromRowAt sourceIndexPath: IndexPath,
                            toProposedIndexPath proposedDestinationIndexPath: IndexPath) -> IndexPath {
        if sourceIndexPath.section != proposedDestinationIndexPath.section {
            return sourceIndexPath
        }
        return proposedDestinationIndexPath
    }
    
    //Переместить ячейку
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        if sourceIndexPath.section != destinationIndexPath.section {
            return
        }
        
        let tableSection = TableSections(rawValue: (sourceIndexPath.section))
        let employee = data[tableSection!]?[(sourceIndexPath.row)]
        data[tableSection!]?.remove(at: (sourceIndexPath.row))
        data[tableSection!]?.insert(employee!, at: destinationIndexPath.row)        
        
        listController?.sortByUser(employees: data[tableSection!]!, typeEmployee: (employee?.position)!)
    }
    
    @IBAction func sortByAlphabet(_ sender: Any) {
        listController?.sortByAlphabet()
        listController?.loadEmployees()
    }
}
