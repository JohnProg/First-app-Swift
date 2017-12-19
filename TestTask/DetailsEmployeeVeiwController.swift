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
    
    override func viewDidLoad() {
        model = DetailsEmployeeController()
        model?.attachView(viewController: self)
        visibleFields()
        
        super.viewDidLoad()
    }
    
    @IBAction func changeTypeEmployee(_ sender: Any) {
        visibleFields()
    }
    
    @IBAction func saveEmployee(_ sender: Any) {
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
            accountant.typeAccountant = typeAccountant.selectedSegmentIndex == 0 ? "Начисление зарплаты" : "Учет метериалов"
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
}
