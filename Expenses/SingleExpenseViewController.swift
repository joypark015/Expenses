//
//  SingleExpenseViewController.swift
//  Expenses
//
//  Created by Park, Joy (MU-Student) on 4/26/19.
//
//

import UIKit

class SingleExpenseViewController: UIViewController {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var amountTextField: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    var existingExpense: Expense?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameTextField.delegate = self
        amountTextField.delegate = self
        
        nameTextField.text = existingExpense?.name
        
        if let amount = existingExpense?.amount {
            amountTextField.text = "\(amount)"
        }
        
        if let date = existingExpense?.date {
            datePicker.date = date
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func saveExpense(_ sender: Any) {
        let name = nameTextField.text
        let amountText = amountTextField.text ?? ""
        let amount = Double(amountText) ?? 0.0
        let date = datePicker.date
        
        var expense: Expense?
        
        if let existingExpense = existingExpense {
            existingExpense.name = name
            existingExpense.amount = amount
            existingExpense.date = date
            
            expense = existingExpense
        } else {
            expense = Expense(name: name, amount: amount, date: date)
        }
        
        if let expense = expense {
            do {
                let managedContext = expense.managedObjectContext
                
                try managedContext?.save()
                
                self.navigationController?.popViewController(animated: true)
            } catch {
                print("context could not be saved")
            }
        }
    }
}

extension SingleExpenseViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
