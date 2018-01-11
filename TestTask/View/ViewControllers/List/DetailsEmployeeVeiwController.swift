import UIKit
import Toast_Swift

class DetailsEmployeeVeiwController: UIViewController, IDetailsEmployeeView {
    
    @IBOutlet weak var typeEmployee: UISegmentedControl!
    
    @IBOutlet weak var fieldFullName: UITextField!
    @IBOutlet weak var fieldSalary: UITextField!
    
    @IBOutlet weak var fieldBuisnessHours: UITextField!
    
    @IBOutlet weak var fieldWorkspace: UITextField!
    @IBOutlet weak var fieldLunchTime: UITextField!
    
    @IBOutlet weak var typeAccountant: UISegmentedControl!
    @IBOutlet weak var txtTypeAccountant: UILabel!
    
    @IBOutlet weak var btnSave: UIBarButtonItem!
    
    private var controller: IDetailsEmployeeController?
    private var isEditMode = false
    var employee: Employee?
    
    override func viewDidLoad() {
        controller = DetailsEmployeeController()
        controller?.attachView(viewController: self)
        
        if employee != nil {
            self.title = NSLocalizedString("edit_employee", comment: "")
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
        if let editedEmployee = createEmployeeByFields() {
            if isEditMode {
                editedEmployee.id = employee?.id
                controller?.editEmployee(employee: editedEmployee)
            } else {
                controller?.saveEmployee(employee: editedEmployee)
            }
        }
    }
    
    func createEmployeeByFields() -> Employee! {
        switch typeEmployee.selectedSegmentIndex {
        case 0:
            let chief = Chief()
            chief.position = PosisitionsEmployee.Chief.rawValue
            chief.fullName = fieldFullName.text
            if let salary = Int(fieldSalary.text!) {
                chief.salary = NSNumber(value: salary)
            }
            chief.buisnesTime = fieldBuisnessHours.text
            return chief
        case 1:
            let commonEmployee = CommonEmployee()
            commonEmployee.position = PosisitionsEmployee.CommonEmployee.rawValue
            commonEmployee.fullName = fieldFullName.text
            commonEmployee.lunchTime = fieldLunchTime.text
            if let salary = Int(fieldSalary.text!) {
                commonEmployee.salary = NSNumber(value: salary)
            }
            if let numberWorkspace = Int(fieldWorkspace.text!) {
                commonEmployee.numberWorkspace = NSNumber(value: numberWorkspace)
            }
            return commonEmployee
        case 2:
            let accountant = Accountant()
            accountant.position = PosisitionsEmployee.Accountant.rawValue
            accountant.fullName = fieldFullName.text
            accountant.lunchTime = fieldLunchTime.text
            accountant.typeAccountant = typeAccountant.selectedSegmentIndex == 0 ? "salary" : "materials"
            if let salary = Int(fieldSalary.text!) {
                accountant.salary = NSNumber(value: salary)
            }
            if let numberWorkspace = Int(fieldWorkspace.text!) {
                accountant.numberWorkspace = NSNumber(value: numberWorkspace)
            }
            return accountant
        default:
            return nil
        }
    }

    func visibleFields() {
        switch typeEmployee.selectedSegmentIndex {
        case 0:
            fieldBuisnessHours.isEnabled = true
            fieldWorkspace.isEnabled = false
            fieldLunchTime.isEnabled = false
            typeAccountant.isEnabled = false
            txtTypeAccountant.isEnabled = false
        case 1:
            fieldWorkspace.isEnabled = true
            fieldLunchTime.isEnabled = true
            fieldBuisnessHours.isEnabled = false
            typeAccountant.isEnabled = false
            txtTypeAccountant.isEnabled = false
        case 2:
            fieldWorkspace.isEnabled = true
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
        case PosisitionsEmployee.Chief.rawValue:
            typeEmployee.selectedSegmentIndex = 0
            let chief = employee as! Chief
            fieldBuisnessHours.text = chief.buisnesTime
        case PosisitionsEmployee.CommonEmployee.rawValue:
            typeEmployee.selectedSegmentIndex = 1
            let commonEmployee = employee as! CommonEmployee
            fieldWorkspace.text = commonEmployee.numberWorkspace?.stringValue
            fieldLunchTime.text = commonEmployee.lunchTime
        case PosisitionsEmployee.Accountant.rawValue:
            typeEmployee.selectedSegmentIndex = 2
            let accountant = employee as! Accountant
            fieldWorkspace.text = accountant.numberWorkspace?.stringValue
            fieldLunchTime.text = accountant.lunchTime
            typeAccountant.selectedSegmentIndex = accountant.typeAccountant == "salary" ? 0 : 1
        default:
            break
        }
    }
    
    func employeeWasSaved() {
        if isEditMode {
            self.view.makeToast(NSLocalizedString("edited", comment: ""))
        } else {
            self.view.makeToast(NSLocalizedString("added", comment: ""))
        }
        
        navigationController?.popViewController(animated: true)
    }
}
