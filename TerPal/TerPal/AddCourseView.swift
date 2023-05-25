//
//  AddCourseView.swift
//  TerPal
//
//  Created by Justin DeVito on 3/14/23.
//

import SwiftUI

struct AddCourseView: View {
    @AppStorage("isDarkMode") private var isDarkMode = false
    @EnvironmentObject var model: TerPal
    @Environment(\.dismiss) var dismiss
    
    @State var semester = "Spring 2023"
    let semesterList = ["Spring 2023", "Fall 2022"]
    let weekdayList = ["Mondays", "Tuesdays", "Wednesdays", "Thursdays", "Fridays"]
    let timeList = ["8:00", "8:30", "9:00", "9:30", "10:00", "10:30", "11:00", "11:30", "12:00", "12:30", "13:00", "13:30", "14:00", "14:30", "15:00", "15:30", "16:00", "16:30", "17:00", "17:30", "18:00", "18:30", "19:00", "19:30", "20:00", "20:30", "21:00", "21:30", "22:00"]
    
    @State var code: String = ""
    @State var section: String = ""
    @State var build: String = ""
    @State var color: Color = .red
    @State var reminderOn: Bool = false
    @State var minutes: Int = 5
    @State var classTimes: [[String]] = [];
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    HStack {
                        Text("Code: ")
                        TextField(
                            "CMSC436",
                            text: $code
                        )
                        Text("Section: ")
                        TextField(
                            "0101",
                            text: $section
                        )
                        
                    }
                    HStack {
                        Text("Building: ")
                        TextField(
                            "ESJ",
                            text: $build
                        )
                    }
                    
                    ColorPicker("Color", selection: $color, supportsOpacity: false)
                    if(isDarkMode){
                        Text("Selected color only shows when dark mode is turned off.")
                    }
                }
                Section {
                    Toggle(isOn: $reminderOn) {
                        Text("Reminder Notification")
                    }
                    Stepper("\(minutes) minutes before", value: $minutes, in: 5...45, step: 5).disabled(!reminderOn)
                }
                Section("Class Times") {
                    Button(action: {
                        classTimes.append(["Mondays", "8:00"])
                    }) {Text(Image(systemName: "plus.circle.fill")).foregroundColor(.green) + Text("    add class time")}
                }
                ForEach(0..<classTimes.count, id: \.self) { i in
                    Section {
                        Button(action: {
                            classTimes.remove(at: i)
                        }) {Text(Image(systemName: "minus.circle.fill")).foregroundColor(.red) + Text("    remove class time")}
                        Picker("Weekday", selection: $classTimes[i][0]){
                            ForEach(weekdayList, id: \.self) { day in
                                Text(day)
                            }
                        }
                        Picker("Time", selection: $classTimes[i][1]){
                            ForEach(timeList, id: \.self) { time in
                                Text(time)
                            }
                        }
                    }
                }
            }
            .navigationTitle("Add Course")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        dismiss()
                    }) {Text("Cancel")}
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        model.addCourse(name: code, section: section, color: color, timesArr: classTimes, buildin:build)
                        if reminderOn {
                            model.courses[model.courses.count-1].setAllNotifications(minsBefore: minutes)
                        }
                        dismiss()
                    }) {Text("Done").bold().disabled(code == "" || section == "" || build == "")}
                }
            }
        }.preferredColorScheme(isDarkMode ? .dark : .light)
    }
}

struct AddCourseView_Previews: PreviewProvider {
    static var previews: some View {
        AddCourseView()
    }
}
