//
//  ContentView.swift
//  EmployeeManager
//
//  Created by FVFH4069Q6L7 on 25/08/2023.
//

import SwiftUI
import RealmSwift

class ContentViewModel : ObservableObject {
    @Published var employees : [EmployeeEntity] = []
    
    func lastId() -> UUID? {
        return employees.last?.id
    }

    func addNew(newEmployee: EmployeeEntity) {
        employees.append(newEmployee)
        RealmWriter.write {
            RealmWriter.instance.add(newEmployee)
        }
    }
    
    func loadEmployees() {
        employees.append(contentsOf: RealmWriter.instance.objects(EmployeeEntity.self))
    }
}

struct ContentView: View {
    @StateObject var contentViewModel = ContentViewModel()
    
    var body: some View {
        NavigationStack {
            ZStack {
                employeeList
                floatingButton
            }
        }
    }
    
    var employeeList : some View {
        ScrollViewReader { scroller in
            ScrollView {
                LazyVStack {
                    ForEach(contentViewModel.employees) { employee in
                        EmployeeView(employee: employee)
                            .id(employee.id)
                    }
                }
                .onChange(of: contentViewModel.employees.count) { _ in
                    let id = contentViewModel.lastId()
                    
                    if id == nil {
                        return
                    }
                    
                    withAnimation(.linear(duration: 1.0)) {
                        scroller.scrollTo(id)
                    }
                }
                .onAppear {
                    if contentViewModel.employees.count == 0 {
                        contentViewModel.loadEmployees()
                    }
                }
            }
        }
    }
    
    var floatingButton : some View {
        VStack {
            Spacer()
            HStack {
                Spacer()
                NavigationLink {
                    let employee = EmployeeEntity()
                    
                    EmployeeInformationView(
                        employee: employee,
                        onResult: {
                            contentViewModel.addNew(newEmployee: employee)
                        })
                } label : {
                    Image(systemName: "plus.circle.fill")
                        .resizable()
                        .frame(width: 60, height: 60)
                        .padding([.trailing, .bottom], 10)
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
