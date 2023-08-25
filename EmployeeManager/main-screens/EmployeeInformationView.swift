//
//  EmployeeInformationView.swift
//  EmployeeManager
//
//  Created by FVFH4069Q6L7 on 25/08/2023.
//

import SwiftUI

extension String {
    public subscript(_ idx: Int) -> Character {
        self[self.index(self.startIndex, offsetBy: idx)]
    }
}

struct EmployeeInformationView: View {
    let employee : EmployeeEntity
    let onResult: () -> ()
    
    @State private var employeeName : String = ""
    @State private var employeeBirthday: String = ""
    @State private var showsWarning : Bool = false

    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ZStack {
            VStack {
                AsyncImage(url: URL(string: employee.avatarLink)) { image in
                           image
                               .resizable()
                               .aspectRatio(contentMode: .fill)
                               
                       } placeholder: {
                           Color.gray
                       }
                       .frame(width: 100, height: 100)
                       .cornerRadius(50)
                
                nameEditor
                birthdayEditor
                completeButtons
                Spacer()
            }
            .navigationBarBackButtonHidden()
            
            warningDialog
                .offset(y: showsWarning ? 0: 1000)
        }
    }
    
    var warningDialog: some View {
        VStack(spacing: 15) {
            Image(systemName: "exclamationmark.triangle.fill")
                .resizable()
                .frame(width: 30, height: 30)
                .foregroundColor(.yellow)
            Text("Định dạng ngày không chính xác(định dạng dd/MM/yyyy)")
                .multilineTextAlignment(.center)
            Button(action: {
                withAnimation(.spring()) {
                    showsWarning = false
                }
            }) {
                Text("OK")
            }
        }
        .background(.white)
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .shadow(radius: 5)
        .frame(maxHeight: 150)
        .padding(30)
    }
    
    var completeButtons: some View {
        HStack (spacing: 30){
            Button(action: {
                let date = MyDateFormatter.getDateFromString(str: employeeBirthday)
                
                if date == nil {
                    withAnimation(.spring()) {
                        showsWarning = true
                    }
                }
                else {
                    RealmWriter.write {
                        employee.empName = employeeName
                        employee.birthDay = date!
                    }

                    
                    onResult()
                    dismiss()
                }
            }) {
                Text("Hoàn tất thay đổi")
            }
            Button(action: {
                dismiss()
            }) {
                Text("Huỷ thay đổi")
            }
        }
    }
    
    var nameEditor : some View {
        HStack {
            Image(systemName: "menucard.fill")
                .resizable()
                .frame(width: 40, height: 40)
                .padding([.trailing, .leading], 20)
            Spacer()
            TextField("", text: $employeeName)
                .onAppear {
                    employeeName = employee.empName
                }
                .textFieldStyle(RoundedBorderTextFieldStyle())
        }
    }
    
    var birthdayEditor : some View {
        return HStack {
            Image(systemName: "birthday.cake.fill")
                .resizable()
                .frame(width: 40, height: 40)
                .padding([.trailing, .leading], 20)
            Spacer()
            TextField("", text: $employeeBirthday)
                .onAppear {
                    employeeBirthday = MyDateFormatter.getDateDisplayFrom(date: employee.birthDay)
                }
                .textFieldStyle(RoundedBorderTextFieldStyle())
        }
    }
}

struct EmployeeInformationView_Previews: PreviewProvider {
    static var previews: some View {
        EmployeeInformationView(
            employee: EmployeeEntity(),
            onResult: {
                
            })
    }
}
