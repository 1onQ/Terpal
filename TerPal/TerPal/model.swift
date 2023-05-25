//
//  model.swift
//  TerPal
//
//  Created by Justin DeVito on 3/12/23.
//

import Foundation
import SwiftUI

class TerPal: ObservableObject {
    @Published var courses: [Course]
    
    private let k: String = "data"
    
    init() {
        if let di = UserDefaults.standard.getCodable([Course].self, forKey: k) {
            courses = di
        }
        else {
            courses = []
            
            // for testing
            /*
            let formatter = DateFormatter()
            formatter.dateFormat = "HH:mm"
            let two = formatter.date(from: "14:00")!
            let myTime = CourseTimes(tuesday: [two], thursday: [two])
            let myTime2 = CourseTimes(tuesday: [two, two], wednesday: [formatter.date(from: "17:32")!], thursday: [two], friday: [formatter.date(from: "17:32")!])
            courses.append(Course(name: "CMSC436", section: "0101", color: .red, times: myTime))
            courses.append(Course(name: "CMSC414" ,section: "0101", color: .blue, times: myTime2))
            courses.append(Course(name: "CMSC430", section: "0101", color: .green, times: myTime))
             */
        }

        try? UserDefaults.standard.setCodable(courses, forKey: k)
    }
    
    // Struct to store a course's info, must be hashable for use in ForEach
    struct Course: Hashable, Codable {
        var name: String
        var section: String
        var color: Color
        var times: CourseTimes
        var building: String = "ESJ"
        var location: [String]? = ["-76.941914","38.986699"]
        
        func hash(into hasher: inout Hasher) {
            hasher.combine(name)
        }
        
        func setAllNotifications(minsBefore: Int) {
            let beforeTime = TimeInterval(minsBefore * 60)
            
            // Monday
            if times.monday != nil {
                for classTime in times.monday! {
                    setNotification(weekday: 2, time: classTime - beforeTime)
                }
            }
            // Tuesday
            if times.tuesday != nil {
                for classTime in times.tuesday! {
                    setNotification(weekday: 3, time: classTime - beforeTime)
                }
            }
            // Wednesday
            if times.wednesday != nil {
                for classTime in times.wednesday! {
                    setNotification(weekday: 4, time: classTime - beforeTime)
                }
            }
            // Thursday
            if times.thursday != nil {
                for classTime in times.thursday! {
                    setNotification(weekday: 5, time: classTime - beforeTime)
                }
            }
            // Friday
            if times.friday != nil {
                for classTime in times.friday! {
                    setNotification(weekday: 6, time: classTime - beforeTime)
                }
            }
        }
        
        func removeAllNotifications() {
            UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [name])
        }
        
        func setNotification(weekday: Int, time: Date) {
            let calendar = Calendar.current
            var date = DateComponents()
            date.hour = calendar.component(.hour, from: time)
            date.minute = calendar.component(.minute, from: time)
            date.weekday = weekday // monday
            let trigger = UNCalendarNotificationTrigger(dateMatching: date, repeats: true)
            let content = UNMutableNotificationContent()
            content.title = name + " reminder"
            let request = UNNotificationRequest(identifier: name, content: content, trigger: trigger)
            UNUserNotificationCenter.current().add(request)
        }
    }
    
    struct CourseTimes: Hashable, Codable {
        var monday: [Date]?
        var tuesday: [Date]?
        var wednesday: [Date]?
        var thursday: [Date]?
        var friday: [Date]?
        
        func getStrings() -> [String] {
            var arr: [String] = []
            
            if monday != nil {arr.append("M " + getString(monday!))}
            if tuesday != nil {arr.append("Tu " + getString(tuesday!))}
            if wednesday != nil {arr.append("W " + getString(wednesday!))}
            if thursday != nil {arr.append("Th " + getString(thursday!))}
            if friday != nil {arr.append("F " + getString(friday!))}
            
            return arr
        }
        
        func getString(_ dates: [Date]) -> String {
            var str = dates[0].formatted(date: .omitted, time: .shortened)
            for i in 1..<dates.count {
                str += "\n" + dates[i].formatted(date: .omitted, time: .shortened)
            }
            return str
        }
    }
    
    func addCourse(name: String, section: String, color: Color, timesArr: [[String]], buildin:String) {
        // key = building, value = [long, lat]
        var build:[String: [String]] = ["":[]]
        //list["A.V. Williams"] = ["-76.9363418604721", "38.99079905"]
        build["AVW"] = ["-76.9363418604721", "38.99079905"]
        build["Adele H. Stamp Student Union"] = ["-76.9447218233957","38.98816455"]
        build["SSU"] = ["-76.9447218233957","38.98816455"]
        build["Animal Science/Agricultural Engineering"] = ["-76.9394592785606","38.99164625"]
        build["ANS"] = ["-76.9394592785606","38.99164625"]
        build["Architecture"] = ["-76.9475462198212","38.98423555"]
        build["ARC"] = ["-76.9475462198212","38.98423555"]
        build["Art-Sociology"] = ["-76.9478947752967","38.98528145"]
        build["ASY"] = ["-76.9478947752967","38.98528145"]
        build["Computer and Space Sciences"] = ["-76.9425669540912","38.9909812"]
        build["Atlantic"] = ["-76.9425669540912","38.9909812"]
        build["CSS"] = ["-76.9425669540912","38.9909812"]
        build["Benjamin"] = ["-76.9474215","38.9867095"]
        build["EDU"] = ["-76.9474215","38.9867095"]
        build["Biology-Psychology"] = ["-76.9425929312518","38.98872265"]
        build["BPS"] = ["-76.9425929312518","38.98872265"]
        build["Biosciences Research"] = ["-76.9428094130756","38.98897595"]
        build["BRB"] = ["-76.9428094130756","38.98897595"]
        build["Cambridge Community Center"] = ["-76.9429981","38.99217805"]
        build["CCC"] = ["-76.9429981","38.99217805"]
        build["Chemical and Nuclear Engineering"] = ["-76.9395374654513","38.99060895"]
        build["CHE"] = ["-76.9395374654513","38.99060895"]
        build["Chemistry"] = ["-76.940171718657","38.98959475"]
        build["CHM"] = ["-76.940171718657","38.98959475"]
        build["Clarice Smith Performing Arts Center"] = ["-76.9504434053224","38.9906807"]
        build["Cole Student Activities"] = ["-76.9467662555511","38.98797155"]
        build["PAC"] = ["-76.9504434053224","38.9906807"]
        build["COL"] = ["-76.9467662555511","38.98797155"]
        build["Computer Science Instructional Center"] = ["-76.9361946","38.98999465"]
        build["CSI"] = ["-76.9361946","38.98999465"]
        build["Edward St. John Learning And Teaching Center"] = ["-76.941914","38.986699"]
        build["ESJ"] = ["-76.941914","38.986699"]
        build["EAB"] = ["-76.9370872500394","38.99073865"]
        build["Engineering Annex"] = ["-76.9370872500394","38.99073865"]
        build["Engineering Laboratory"] = ["-76.9379467111811","38.98926235"]
        build["EGL"] = ["-76.9379467111811","38.98926235"]
        build["Francis Scott Key Hall"] = ["-76.9430892753028","38.98506175"]
        build["KEY"] = ["-76.9430892753028","38.98506175"]
        build["Geology"] = ["-76.9409099576973","38.9881304"]
        build["GEO"] = ["-76.9409099576973","38.9881304"]
        build["Golf Course Clubhouse"] = ["-76.9547070820405","38.99113325"]
        build["GLF"] = ["-76.9547070820405","38.99113325"]
        build["H.J. Patterson Hall"] = ["-76.9432766035148","38.98708535"]
        build["HJP"] = ["-76.9432766035148","38.98708535"]
        build["Harrison Lab"] = ["-76.9356386027744","38.98703195"]
        build["Green Houses"] = ["-76.9356386027744","38.98703195"]
        build["HAR"] = ["-76.9356386027744","38.98703195"]
        build["Holzapfel Hall"] = ["-76.9418893729789","38.98687755"]
        build["Horticulture"] = ["-76.9418893729789","38.98687755"]
        build["HZF"] = ["-76.9418893729789","38.98687755"]
        build["Hornbake Library"] = ["-76.9415740921482","38.9881767"]
        build["HBK"] = ["-76.9415740921482","38.9881767"]
        build["Institute for Physical Science and Technology"] = ["-76.94097235","38.9909191"]
        build["IPT"] = ["-76.94097235","38.9909191"]
        build["Instructional Television Facility"] = ["-76.9383093000325","38.98957525"]
        build["ITV"] = ["-76.9383093000325","38.98957525"]
        build["J.M. Patterson"] = ["-76.940295409728","38.9905177"]
        build["JMP"] = ["-76.940295409728","38.9905177"]
        build["Jimenez Hall"] = ["-76.94455005","38.9867867"]
        build["JMZ"] = ["-76.94455005","38.9867867"]
        build["Jull Hall"] = ["-76.9435848","38.99087705"]
        build["JUL"] = ["-76.9435848","38.99087705"]
        build["Kim Engineering"] = ["-76.938025589911","38.9909099"]
        build["KEB"] = ["-76.938025589911","38.9909099"]
        build["Jeong H. Kim Engineering"] = ["-76.938025589911","38.9909099"]
        build["Knight Hall"] = ["-76.9484189","38.98677255"]
        build["KNI"] = ["-76.9484189","38.98677255"]
        build["LeFrak Hall"] = ["-76.9436347921034","38.9836849"]
        build["LEF"] = ["-76.9436347921034","38.9836849"]
        build["Marie Mount Hall"] = ["-76.94075799224","38.9850013"]
        build["MMH"] = ["-76.94075799224","38.9850013"]
        build["Martin Hall"] = ["-76.9379744096244","38.9888688"]
        build["EGR"] = ["-76.9379744096244","38.9888688"]
        build["Mathematics"] = ["-76.9390688130666","38.98862265"]
        build["MTH"] = ["-76.9390688130666","38.98862265"]
        build["McKeldin Library"] = ["-76.9451004712142","38.98598155"]
        build["MCK"] = ["-76.9451004712142","38.98598155"]
        build["Microbiology"] = ["-76.9434034376443","38.98811525"]
        build["MCB"] = ["-76.9434034376443","38.98811525"]
        build["Morrill Hall"] = ["-76.944173786884","38.9843126"]
        build["MOR"] = ["-76.944173786884","38.9843126"]
        build["Nyumburu Cultural Center"] = ["-76.9438057866404","38.9881339"]
        build["NCC"] = ["-76.9438057866404","38.9881339"]
        build["Physics"] = ["-76.94007719774","38.9886972"]
        build["PHY"] = ["-76.94007719774","38.9886972"]
        build["Plant Science Building"] = ["-76.9413596237531","38.98873715"]
        build["PLS"] = ["-76.9413596237531","38.98873715"]
        build["Preinkert Field House"] = ["-76.9461320708538","38.9844511"]
        build["PKT"] = ["-76.9461320708538","38.9844511"]
        build["Queen Anne's Hall"] = ["-76.9460068545931","38.98519025"]
        build["QAN"] = ["-76.9460068545931","38.98519025"]
        build["Reckord Armory"] = ["-76.9389662139866","38.9860268"]
        build["ARM"] = ["-76.9389662139866","38.9860268"]
        build["Ritchie Coliseum"] = ["-76.936456447182","38.98504805"]
        build["RIT"] = ["-76.936456447182","38.98504805"]
        build["School of Public Health Building"] = ["-76.9431633838994","38.9934922"]
        build["SPH"] = ["-76.9431633838994","38.9934922"]
        build["Shoemaker"] = ["-76.942745495777","38.9839376"]
        build["SHM"] = ["-76.942745495777","38.9839376"]
        build["Shriver Laboratory"] = ["-76.94191685","38.98727505"]
        build["SHR"] = ["-76.94191685","38.98727505"]
        build["Skinner Building"] = ["-76.9418413304917","38.98480955"]
        build["SKN"] = ["-76.9418413304917","38.98480955"]
        build["South Campus Dining Hall"] = ["-76.9436837393588","38.983048"]
        build["SDH"] = ["-76.9436837393588","38.983048"]
        build["Stamp"] = ["-76.9447218233957","38.98816455"]
        build["SSU"] = ["-76.9447218233957","38.98816455"]
        build["Adele H. Stamp Student Union"] = ["-76.9447218233957","38.98816455"]
        build["Susquehanna Hall"] = ["-76.943749743933","38.9820745"]
        build["SQH"] = ["-76.943749743933","38.9820745"]
        build["Symons Hall"] = ["-76.9406455474374","38.9870811"]
        build["SYM"] = ["-76.9406455474374","38.9870811"]
        build["Taliaferro Hall"] = ["-76.9430948392412","38.98484635"]
        build["TLF"] = ["-76.9430948392412","38.98484635"]
        build["Tawes Fine Arts"] = ["-76.9483238494655","38.98598645"]
        build["TWS"] = ["-76.9483238494655","38.98598645"]
        build["IRB"] = ["-76.937218","38.991039"]
        build["The Brendan Iribe Center"] = ["-76.937218","38.991039"]
        build["Turner Hall"] = ["-76.9373371743758","38.98614065"]
        build["Visitor Center"] = ["-76.9373371743758","38.98614065"]
        build["TUR"] = ["-76.9373371743758","38.98614065"]
        build["Tydings Hall"] = ["-76.9440007655894","38.9848516"]
        build["TYD"] = ["-76.9440007655894","38.9848516"]
        build["UMUC/Inn & Conference Center"] = ["-76.9540770364453","38.9860659"]
        build["ICC"] = ["-76.9540770364453","38.9860659"]
        build["Van Munching Hall"] = ["-76.9470382916646","38.9830467"]
        build["VMH"] = ["-76.9470382916646","38.9830467"]
        build["Wind Tunnel"] = ["-76.9368484609687","38.9899002"]
        build["WTU"] = ["-76.9368484609687","38.9899002"]
        build["Woods Hall"] = ["-76.9418451233709","38.9851106"]
        build["WDS"] = ["-76.9418451233709","38.9851106"]
        

        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        
        var times = CourseTimes()
        for i in 0..<timesArr.count {
            if timesArr[i][0] == "Mondays" {
                if times.monday != nil {
                    times.monday?.append(formatter.date(from: timesArr[i][1])!)
                }
                else {
                    times.monday = [formatter.date(from: timesArr[i][1])!]
                }
            }
            else if timesArr[i][0] == "Tuesdays" {
                if times.tuesday != nil {
                    times.tuesday?.append(formatter.date(from: timesArr[i][1])!)
                }
                else {
                    times.tuesday = [formatter.date(from: timesArr[i][1])!]
                }
            }
            else if timesArr[i][0] == "Wednesdays" {
                if times.wednesday != nil {
                    times.wednesday?.append(formatter.date(from: timesArr[i][1])!)
                }
                else {
                    times.wednesday = [formatter.date(from: timesArr[i][1])!]
                }
            }
            else if timesArr[i][0] == "Thursdays" {
                if times.thursday != nil {
                    times.thursday?.append(formatter.date(from: timesArr[i][1])!)
                }
                else {
                    times.thursday = [formatter.date(from: timesArr[i][1])!]
                }
            }
            else if timesArr[i][0] == "Fridays" {
                if times.friday != nil {
                    times.friday?.append(formatter.date(from: timesArr[i][1])!)
                }
                else {
                    times.friday = [formatter.date(from: timesArr[i][1])!]
                }
            }
        }
        // Handle wrong building entered by user, default is ESJ
        if build["\(buildin)"] == nil{
            courses.append(Course(name: name, section: section, color: color, times: times, building: "ESJ", location: build["ESJ"]))
            try? UserDefaults.standard.setCodable(courses, forKey: k)
        }
        else {
            courses.append(Course(name: name, section: section, color: color, times: times, building: buildin, location: build["\(buildin)"]))
            try? UserDefaults.standard.setCodable(courses, forKey: k)
        }
        
    }
    
    func removeCourse(course: Course) {
        courses.remove(at: courses.firstIndex(of: course)!)
        try? UserDefaults.standard.setCodable(courses, forKey: k)
    }
    
    func editCourse(course: Course) {
        //TODO
    }
    
    func getClassTimes() -> [Date]{
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        let start = formatter.date(from: "8:00")!
        var timesList: [Date] = []
        for i in 0...56 {
            timesList.append(start + TimeInterval(i*60))
        }
        
        return timesList
    }
}

// Persistence
public extension UserDefaults {
    func setCodable<T: Codable>(_ object: T, forKey: String) throws {
        let jsonData: Data = try JSONEncoder().encode(object)
        set(jsonData, forKey: forKey)
    }
    func getCodable<T: Codable>(_ ot: T.Type, forKey: String) -> T? {
        guard let result = value(forKey: forKey) as? Data else {
            return nil
        }
        return try? JSONDecoder().decode(ot, from: result)
    }
}


// From Peter Friese, to make Color codable
// https://gist.github.com/peterfriese/bb2fc5df202f6a15cc807bd87ff15193
extension Color: Codable {
  init(hex: String) {
    let rgba = hex.toRGBA()
    
    self.init(.sRGB,
              red: Double(rgba.r),
              green: Double(rgba.g),
              blue: Double(rgba.b),
              opacity: Double(rgba.alpha))
  }
  
  public init(from decoder: Decoder) throws {
    let container = try decoder.singleValueContainer()
    let hex = try container.decode(String.self)
    
    self.init(hex: hex)
  }
  
  public func encode(to encoder: Encoder) throws {
    var container = encoder.singleValueContainer()
    try container.encode(toHex)
  }
  
  var toHex: String? {
    return toHex()
  }
  
  func toHex(alpha: Bool = false) -> String? {
    guard let components = cgColor?.components, components.count >= 3 else {
      return nil
    }
    
    let r = Float(components[0])
    let g = Float(components[1])
    let b = Float(components[2])
    var a = Float(1.0)
    
    if components.count >= 4 {
      a = Float(components[3])
    }
    
    if alpha {
      return String(format: "%02lX%02lX%02lX%02lX",
                    lroundf(r * 255),
                    lroundf(g * 255),
                    lroundf(b * 255),
                    lroundf(a * 255))
    }
    else {
      return String(format: "%02lX%02lX%02lX",
                    lroundf(r * 255),
                    lroundf(g * 255),
                    lroundf(b * 255))
    }
  }
}

extension String {
  func toRGBA() -> (r: CGFloat, g: CGFloat, b: CGFloat, alpha: CGFloat) {
    var hexSanitized = self.trimmingCharacters(in: .whitespacesAndNewlines)
    hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")
    
    var rgb: UInt64 = 0
    
    var r: CGFloat = 0.0
    var g: CGFloat = 0.0
    var b: CGFloat = 0.0
    var a: CGFloat = 1.0
    
    let length = hexSanitized.count
    
    Scanner(string: hexSanitized).scanHexInt64(&rgb)
    
    if length == 6 {
      r = CGFloat((rgb & 0xFF0000) >> 16) / 255.0
      g = CGFloat((rgb & 0x00FF00) >> 8) / 255.0
      b = CGFloat(rgb & 0x0000FF) / 255.0
    }
    else if length == 8 {
      r = CGFloat((rgb & 0xFF000000) >> 24) / 255.0
      g = CGFloat((rgb & 0x00FF0000) >> 16) / 255.0
      b = CGFloat((rgb & 0x0000FF00) >> 8) / 255.0
      a = CGFloat(rgb & 0x000000FF) / 255.0
    }
    
    return (r, g, b, a)
  }
}

//dark mode
