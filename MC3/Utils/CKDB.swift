//
//  CKDB.swift
//  MC3
//
//  Created by Peter Andrew on 12/08/20.
//  Copyright © 2020 Aghawidya Adipatria. All rights reserved.
//

import Foundation
import CloudKit

class CKDB {
    public static var db = CKContainer.default().publicCloudDatabase
    public static func AuthorCK(_ user:AuthorModel)->CKRecord {
        let record = CKRecord(recordType: "User")
        record.setValue(user.id, forKey:"id")
        record.setValue(user.name, forKey:"name")
        record.setValue(user.username, forKey:"username")
        record.setValue(user.profileImage, forKey:"profileImage")
        record.setValue(user.password, forKey:"password")
        record.setValue(user.email, forKey:"email")
        record.setValue(user.phone, forKey:"phone")
        record.setValue(user.youtube, forKey:"youtube")
        record.setValue(user.instagram, forKey:"instagram")
        record.setValue(user.discord, forKey:"discord")
        record.setValue(user.whatsapp, forKey:"whatsapp")
        record.setValue(user.facebook, forKey:"facebook")
        record.setValue(user.line, forKey:"line")
        return record
    }
}
