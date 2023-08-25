//
//  EmployeeView.swift
//  EmployeeManager
//
//  Created by FVFH4069Q6L7 on 25/08/2023.
//

import SwiftUI

struct EmployeeView: View {
    @ObservedObject var employee : EmployeeEntity
    
    var body: some View {
        NavigationLink {
            EmployeeInformationView(
                employee: employee,
                onResult: {
                    
                })
        } label: {
            HStack {
                AsyncImage(url: URL(string: employee.avatarLink)) { image in
                           image
                               .resizable()
                               .aspectRatio(contentMode: .fill)
                               
                       } placeholder: {
                           Color.gray
                       }
                       .frame(width: 60, height: 60)
                       .cornerRadius(30)
                VStack(alignment: .leading){
                    Text(employee.empName)
                        .bold()
                        .padding([.bottom], 10)
                    Text(MyDateFormatter.getDateDisplayFrom(date: employee.birthDay))
                }.padding([.leading], 10)
                Spacer()
            }
            .padding([.leading, .bottom], 15)
            .foregroundColor(.black)
        }
    }
}

struct EmployeeView_Previews: PreviewProvider {
    static var previews: some View {
        EmployeeView(employee: EmployeeEntity())
    }
}
