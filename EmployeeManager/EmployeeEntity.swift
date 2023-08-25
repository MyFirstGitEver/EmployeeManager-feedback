//
//  EmployEntity.swift
//  EmployeeManager
//
//  Created by FVFH4069Q6L7 on 25/08/2023.
//

import Foundation
import RealmSwift

class EmployeeEntity : Object, Identifiable {
    var id = UUID()
    @objc dynamic var empName: String = "Tên nhân viên"
    @objc dynamic var avatarLink: String = "https://i.dummyjson.com/data/products/1/thumbnail.jpg"
    @objc dynamic var birthDay: Date = Date.now
    
    func writeData(empName: String, avatarLink: String, birthDay: Date) -> EmployeeEntity {
        self.empName = empName
        self.avatarLink = avatarLink
        self.birthDay = birthDay
        
        return self
    }
}
