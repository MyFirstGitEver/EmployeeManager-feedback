//
//  RealmWriter.swift
//  EmployeeManager
//
//  Created by FVFH4069Q6L7 on 25/08/2023.
//

import Foundation
import RealmSwift

class RealmWriter {
    static let instance = try! Realm()
    
    static func write(onWrite: () -> ()) {
        instance.beginWrite()
        onWrite()
        do {
            try instance.commitWrite()
        } catch let err {
            print(err.localizedDescription)
        }
    }
}
