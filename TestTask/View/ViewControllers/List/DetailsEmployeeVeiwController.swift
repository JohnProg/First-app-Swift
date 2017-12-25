import UIKit

class DetailsEmployeeVeiwController: UIViewController, IDetailsEmployeeView {

    @IBOutlet weak var typeEmployee: UISegmentedControl!
    
    @IBOutlet weak var fieldFullName: UITextField!
    @IBOutlet weak var fieldSalary: UITextField!
    
    @IBOutlet weak var fieldBuisnessHours: UITextField!
    
    @IBOutlet weak var fieldWorkplace: UITextField!
    @IBOutlet weak var fieldLunchTime: UITextField!
    
    @IBOutlet weak var typeAccountant: UISegmentedControl!
    @IBOutlet weak var txtTypeAccountant: UILabel!
    
    @IBOutlet weak var btnSave: UIBarButtonItem!
    
    private var model: IDetailsEmployeeController?
    private var isEditMode = false
    var employee: Employee?
    
    override func viewDidLoad() {
        model = DetailsEmployeeController()
        model?.attachView(viewController: self)
        
        if employee != nil {
            self.title = "Edit employee"
            setFieldsForEditMode(employee: employee!)
            isEditMode = true
        }
        
        visibleFields()
        
        super.viewDidLoad()
    }
    
    @IBAction func changeTypeEmployee(_ sender: Any) {
        visibleFields()
    }
    
    @IBAction func saveEmployee(_ sender: Any) {
        if isEditMode {
            saveEditedEmployee()
        } else {
            saveNewEmployee()
        }
    }
    
    func saveEditedEmployee() {
        switch typeEmployee.selectedSegmentIndex {
        case 0:
            let chief = Chief()
            chief.id = employee?.id
            chief.position = "Руководитель"
            chief.fullName = fieldFullName.text
            chief.salary = NSNumber(value: Int(fieldSalary.text!)!)
            chief.buisnesTime = fieldBuisnessHours.text
            model?.editEmployee(employee: chief)
        case 1:
            let commonEmployee = CommonEmployee()
            commonEmployee.id = employee?.id
            commonEmployee.position = "Сотрудник"
            commonEmployee.fullName = fieldFullName.text
            commonEmployee.salary = NSNumber(value: Int(fieldSalary.text!)!)
            commonEmployee.lunchTime = fieldLunchTime.text
            commonEmployee.numberWorkspace = NSNumber(value: Int(fieldWorkplace.text!)!)
            model?.editEmployee(employee: commonEmployee)
        case 2:
            let accountant = Accountant()
            accountant.id = employee?.id
            accountant.position = "Бухгалтер"
            accountant.fullName = fieldFullName.text
            accountant.salary = NSNumber(value: Int(fieldSalary.text!)!)
            accountant.lunchTime = fieldLunchTime.text
            accountant.numberWorkspace = NSNumber(value: Int(fieldWorkplace.text!)!)
            accountant.typeAccountant = typeAccountant.selectedSegmentIndex == 0 ? "salary" : "materials"
            model?.editEmployee(employee: accountant)
        default:
            break
        }
    }
    
    func saveNewEmployee() {
        switch typeEmployee.selectedSegmentIndex {
        case 0:
            let chief = Chief()
            chief.position = "Руководитель"
            chief.fullName = fieldFullName.text
            chief.salary = NSNumber(value: Int(fieldSalary.text!)!)
            chief.buisnesTime = fieldBuisnessHours.text
            model?.saveEmployee(employee: chief)
        case 1:
            let commonEmployee = CommonEmployee()
            commonEmployee.position = "Сотрудник"
            commonEmployee.fullName = fieldFullName.text
            commonEmployee.salary = NSNumber(value: Int(fieldSalary.text!)!)
            commonEmployee.lunchTime = fieldLunchTime.text
            commonEmployee.numberWorkspace = NSNumber(value: Int(fieldWorkplace.text!)!)
            model?.saveEmployee(employee: commonEmployee)
        case 2:
            let accountant = Accountant()
            accountant.position = "Бухгалтер"
            accountant.fullName = fieldFullName.text
            accountant.salary = NSNumber(value: Int(fieldSalary.text!)!)
            accountant.lunchTime = fieldLunchTime.text
            accountant.numberWorkspace = NSNumber(value: Int(fieldWorkplace.text!)!)
            accountant.typeAccountant = typeAccountant.selectedSegmentIndex == 0 ? "salary" : "materials"
            model?.saveEmployee(employee: accountant)
        default:
            break
        }
    }
    
    
    
    
    
    func visibleFields() {
        switch typeEmployee.selectedSegmentIndex {
        case 0:
            fieldBuisnessHours.isEnabled = true
            fieldWorkplace.isEnabled = false
            fieldLunchTime.isEnabled = false
            typeAccountant.isEnabled = false
            txtTypeAccountant.isEnabled = false
        case 1:
            fieldWorkplace.isEnabled = true
            fieldLunchTime.isEnabled = true
            fieldBuisnessHours.isEnabled = false
            typeAccountant.isEnabled = false
            txtTypeAccountant.isEnabled = false
        case 2:
            fieldWorkplace.isEnabled = true
            fieldLunchTime.isEnabled = true
            typeAccountant.isEnabled = true
            txtTypeAccountant.isEnabled = true
            fieldBuisnessHours.isEnabled = false
        default:
            break
        }
    }
    
    func setFieldsForEditMode(employee: Employee) {
        fieldFullName.text = employee.fullName
        fieldSalary.text = employee.salary?.stringValue
        
        switch employee.position! {
        case "Руководитель":
            typeEmployee.selectedSegmentIndex = 0
            let chief = employee as! Chief
            fieldBuisnessHours.text = chief.buisnesTime
        case "Сотрудник":
            typeEmployee.selectedSegmentIndex = 1
            let commonEmployee = employee as! CommonEmployee
            fieldWorkplace.text = commonEmployee.numberWorkspace?.stringValue
            fieldLunchTime.text = commonEmployee.lunchTime
        case "Бухгалтер":
            typeEmployee.selectedSegmentIndex = 2
            let accountant = employee as! Accountant
            fieldWorkplace.text = accountant.numberWorkspace?.stringValue
            fieldLunchTime.text = accountant.lunchTime
            typeAccountant.selectedSegmentIndex = accountant.typeAccountant == "salary" ? 0 : 1
        default:
            break
        }
    }
}
