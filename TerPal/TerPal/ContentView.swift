//
//  ContentView.swift
//  TerPal
//
//  Created by Justin DeVito on 3/12/23.
//

import SwiftUI
import MapKit

struct ContentView: View {
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    @StateObject var model: TerPal = TerPal()
    @State private var showingSheet = false
    @State private var showingSheet2 = false
    @State private var showingSheet3 = false
    @State private var editing = false
    @State private var settings = false
    @State private var s = "" // test
    //@Binding var isDarkMode: Bool
    @AppStorage("isDarkMode") private var isDarkMode = false
    
    var tapGesture: some Gesture  {
            TapGesture().onEnded{
            }
        }
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    ForEach(model.courses, id: \.self) {
                        course in
                        HStack {
                            CourseItem(course)
                            if editing {
                                ZStack {
                                    Button(action: {
                                        model.removeCourse(course: course)
                                    }) {
                                        Image(systemName: "trash")
                                            .foregroundColor(.red)
                                    }
                                    /*
                                    .offset(y: 20)
                                    Button(action: {
                                        //TODO
                                    }) {
                                        Image(systemName: "square.and.pencil")
                                            .foregroundColor(.blue)
                                    }
                                    .offset(y: -20)
                                     */
                                }
                                
                            }
                        }
                            
                        // JUST FOR TESTING
                        /*
                        Button(action: {
                            course.setAllNotifications(minsBefore: 5)
                        }) {Text("Set Reminders")}
                        Button(action: {
                            course.removeAllNotifications()
                        }) {Text("Remove Reminders")}
                        */
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        editing.toggle()
                    }) {
                        if editing {
                            Text("Done")
                        } else {
                            Text("Edit")
                        }
                    }
                }
                ToolbarItem(placement: .principal) {
                    Button(action: {
                        showingSheet2.toggle()
                    }) {
                        Text("TerPal 🐢")
                    }}
                ToolbarItem(placement: .automatic) {
                    Button(action: {
                        settings.toggle()
                    }) {
                        Image(systemName: "gearshape.fill")
                    }}
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        showingSheet.toggle()
                    }) {
                        Image(systemName: "plus")
                    }
                }
            }
        }
        
        .preferredColorScheme(isDarkMode ? .dark : .light)
        // Add course sheet
        .sheet(isPresented: $showingSheet) {
            AddCourseView().environmentObject(model)
        }
        .sheet(isPresented: $showingSheet2) {
            About()
        }
        .sheet(isPresented: $settings) {
            Settings()
        }

        
        
    }
}

// Rounded rectangle containing course info
struct CourseItem: View {
    @AppStorage("isDarkMode") private var isDarkMode = false
    @EnvironmentObject var model: TerPal
    
    var course: TerPal.Course
    
    init(_ course: TerPal.Course) {
        self.course = course
    }
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 25.0)
                .foregroundColor(isDarkMode ? .gray : course.color)
                .frame(width:350, height:125)
            
            Button(action: {
                mapOpening(course.location!)
            }){
                Text("\(course.building)")
            }
            .font(.system(size: 20, weight: .bold, design: .default))
            .foregroundColor(.white)
            .frame(width:298, height:100, alignment: .leading)
            .offset(y: -30)
            .disabled(course.location == nil)
            Text("\(course.name)")
                .font(.system(size: 30, weight: .heavy, design: .default))
                .foregroundColor(.white)
                .frame(width:300, height:100, alignment: .leading)
                .offset(y: 3)
            Text("Section \(course.section)")
                .font(.system(size: 20, weight: .bold, design: .default))
                .foregroundColor(.white)
                .frame(width:298, height:100, alignment: .leading)
                .offset(y: 33)
            
            VStack() {
                ForEach(course.times.getStrings(), id: \.self) { str in
                    Text("\(str)")
                        .font(.system(size: 16, weight: .bold, design: .default))
                        .foregroundColor(.white)
                        .multilineTextAlignment(.trailing)
                }
            }
            .frame(width:300, height:100, alignment: .trailing)
        }
    }
    
    func mapOpening(_ loc:[String]) {
        
        let url = URL(string: "maps://?saddr=&daddr=\(loc[1]),\(loc[0])")
        if UIApplication.shared.canOpenURL(url!) {
              UIApplication.shared.open(url!, options: [:], completionHandler: nil)
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    
    static var previews: some View {
        ContentView()
        //AddCourseView()
    }
}
