//
//  NamePhoneNumberViewController.swift
//  final3
//
//  Created by Yiyun Bao on 12/9/23.
//

import UIKit

class NamePhoneNumberViewController: UIViewController {

    @IBOutlet weak var phoneNumber: UITextField!
    @IBOutlet weak var name: UITextField!
    
    var sendNamePhoneDelegate: SendNamePhoneNumberDelegate?
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func saveNamePhone(_ sender: Any) {
        guard let name = name.text else {return}
        guard let phoneNumber = phoneNumber.text else {return}
        
        sendNamePhoneDelegate?.sendNamePhoneNumber(name: name, phoneNumber: phoneNumber)
        
        self.navigationController?.popViewController(animated: true)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
