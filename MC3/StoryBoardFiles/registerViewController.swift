//
//  registerViewController.swift
//  MC3
//
//  Created by tommy on 20/07/20.
//  Copyright © 2020 tommy. All rights reserved.
//

import UIKit
import CloudKit

class registerViewController: UIViewController {

    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var repassword: UITextField!
    @IBOutlet weak var text: UILabel!
    var cbFunc:((_ user:AuthorModel)->Void)? = nil
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        text.isHidden = true
        //view1.layer.cornerRadius = 50
        // Do any additional setup after loading the view.
    }
    
    @IBAction func saveToCloudKit() {
        if password.text != repassword.text {
            text.isHidden = false
            password.text = ""
            repassword.text = ""
        }else {
            text.isHidden = true
            // bkin record
            let newRecord = CKRecord(recordType: "Account")

            // set property
            newRecord.setValue(username.text ?? "", forKey: "username")
            newRecord.setValue(email.text ?? "", forKey: "email")
            newRecord.setValue(password.text ?? "", forKey: "password")

            // save or insert
            let database = CKContainer.default().publicCloudDatabase
            database.save(newRecord) { (record, error) in
            if let err = error {
            print(err.localizedDescription)
            }
            print(record)
            if let action = self.cbFunc {
                action(AuthorModel(name: "", username: "", profileImage: "", password: "", email: "", phone: ""))
            }
            DispatchQueue.main.async {
            //self.dismiss(animated: true, completion: nil)
            self.navigationController?.popViewController(animated: true)
                       }
                   }
        }
       
    }

    
    @IBAction func backToLogin(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
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
