//
//  loginViewController.swift
//  MC3
//
//  Created by tommy on 20/07/20.
//  Copyright © 2020 tommy. All rights reserved.
//

import UIKit
import CloudKit

class loginViewController: UIViewController {
    var accounts: [CKRecord] = []
    var backFunc:((_ user:AuthorModel)->Void)? = nil
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        label.isHidden = true
        // Do any additional setup after loading the view.
    }
    
//    override func viewWillAppear(_ animated: Bool) {
//        //init database
//        let database = CKContainer.default().publicCloudDatabase
//        
//        //init record
//        let predicate = NSPredicate(value: true)
//        let query = CKQuery(recordType: "Account", predicate: predicate)
//        
//        //execute query
//        database.perform(query, inZoneWith: nil) { (records, error) in
//            if let fetched = records {
//                self.accounts = fetched
//                DispatchQueue.main.async {
//                }
//            }
//        }
//    }
    
    
    @IBAction func login(_ sender: Any) {
        var count = 0
        let jumlah = accounts.count
        if let action = backFunc {
            action(AuthorModel(name: "", username: "", profileImage: "", password: "", email: "", phone: ""))
        }
        while count < jumlah {
            let record = accounts[count]
            if username.text == record.value(forKey: "email") as? String {
                if password.text == record.value(forKey: "password") as? String {
                    label.isHidden = true
                    print("login success")
                }
            }else{
                label.isHidden = false
                password.text = ""
            }
            
            count += 1
        }
        
    }
    
    @IBAction func toRegisterPage(_ sender: Any) {
        performSegue(withIdentifier: "toRegister", sender: nil)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "toRegister":
            if let vc = segue.destination as? registerViewController {
                vc.cbFunc = self.backFunc
            }
        default:
            print("error")
        }
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
