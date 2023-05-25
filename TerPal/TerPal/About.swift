//
//  About.swift
//  TerPal
//
//  Created by Uyen Nguyen on 4/13/23.
//

import SwiftUI


struct About: View {
    @State private var flag = false
    @Environment(\.dismiss) var dismiss
    @Environment(\.verticalSizeClass) var verticalSizeClass: UserInterfaceSizeClass?
    var backgroundGradient = LinearGradient(
        gradient: Gradient(colors: [Color.white, Color.yellow]),
        startPoint: .top, endPoint: .bottom)
    
    var body: some View {
        if verticalSizeClass == .regular
        {
            ZStack
            {
                backgroundGradient.ignoresSafeArea()
                Button(action: {
                    dismiss()
                }) {Text("Cancel")}
                    .padding(.trailing, 300)
                    .padding(.bottom, 680)
                    
                HStack {
                    Text("Ter")
                        .fontWeight(.bold)
                        .font(.system(size: 100, design: .rounded))
                        .foregroundColor(.black)
                        .shadow(color: Color.gray, radius: 3.5, x: -12, y: -5.6)
                        .padding(.bottom, 330)
                    
                    Text("Pal")
                        .fontWeight(.bold)
                        .font(.system(size: 100, design: .rounded))
                        .foregroundColor(.red)
                        .shadow(color: Color.gray, radius: 3.5, x: -12, y: -5.6)
                        .padding(.bottom, 330)
                }
                
                 
                Path {
                    path in
                    
                    path.move(to: CGPoint(x: 134/3, y: 181/3))
                    path.addCurve(to: CGPoint(x: 157/3, y: 110/3), control1: CGPoint(x: 134/3, y: 181/3), control2: CGPoint(x: 120/3, y: 128/3))
                    path.addCurve(to: CGPoint(x: 242/3, y: 120/3), control1: CGPoint(x: 194/3, y: 92/3), control2: CGPoint(x: 242/3, y: 105/3))
                    path.addCurve(to: CGPoint(x: 134/3, y: 181/3), control1: CGPoint(x: 242/3, y: 135/3), control2: CGPoint(x: 134/3, y: 181/3))
                    path.closeSubpath()
                    path.move(to: CGPoint(x: 135/3, y: 187/3))
                    path.addCurve(to: CGPoint(x: 247/3, y: 132/3), control1: CGPoint(x: 135/3, y: 187/3), control2: CGPoint(x: 226/3, y: 154/3))
                    path.addCurve(to: CGPoint(x: 312/3, y: 85/3), control1: CGPoint(x: 268/3, y: 110/3), control2: CGPoint(x: 288/3, y: 85/3))
                    path.addCurve(to: CGPoint(x: 288/3, y: 141/3), control1: CGPoint(x: 336/3, y: 85/3), control2: CGPoint(x: 288/3, y: 150/3))
                    path.addCurve(to: CGPoint(x: 267/3, y: 203/3), control1: CGPoint(x: 288/3, y: 132/3), control2: CGPoint(x: 246/3, y: 178/3))
                    path.addCurve(to: CGPoint(x: 224/3, y: 198/3), control1: CGPoint(x: 288/3, y: 228/3), control2: CGPoint(x: 224/3, y: 209/3))
                    path.addCurve(to: CGPoint(x: 203/3, y: 185/3), control1: CGPoint(x: 225/4, y: 187/4), control2: CGPoint(x: 203/3, y: 185/3))
                    path.addLine(to: CGPoint(x: 185/3, y: 191/3))
                    path.addCurve(to: CGPoint(x: 171/3, y: 208/3), control1: CGPoint(x: 185/3, y: 191/3), control2: CGPoint(x: 178/3, y: 208/3))
                    path.addCurve(to: CGPoint(x: 145/3, y: 205/3), control1: CGPoint(x: 164/3, y: 208/3), control2: CGPoint(x: 145/3, y: 212/3))
                    path.addCurve(to: CGPoint(x: 135/3, y: 187/3), control1: CGPoint(x: 145/3, y: 198/3), control2: CGPoint(x: 135/3, y: 187/3))
                    path.closeSubpath()
                    path.move(to: CGPoint(x: 135/3, y: 187/3))

                    
                }
                .trim(from: flag ? 0 : 1, to: 1)
                .stroke(lineWidth: 4)
                .fill(AngularGradient(colors: [.red, .green, .blue, .purple, .pink],
                                      center: .center,
                                      startAngle: .degrees(310),
                                      endAngle: .degrees(410)))
                .offset(x:120, y: 282)
                .onAppear {
                    withAnimation(.easeInOut(duration: 3).delay(1).repeatForever(autoreverses:true)) {
                        flag.toggle()
                    }}
                ZStack {
                    RoundedRectangle(cornerRadius: 25)
                        .foregroundColor(.white).opacity(0.40)
                        .shadow(color: Color.black, radius: 3, x: 13, y: 13)
                        .rotationEffect(.init(degrees: 810))
                        .padding(80)
                        .padding(.top, 185)
                    
                    Circle()
                        .stroke(
                            .linearGradient(.init(colors: [Color(.yellow).opacity(3),
                                                           Color(.red).opacity(3)]),
                                            startPoint: .leading, endPoint: .trailing),
                            style: StrokeStyle(lineWidth:35, lineCap: .round, lineJoin:.round))
                        .shadow(color: Color.brown, radius: 3, x: 13, y: 13)
                        .rotationEffect(.init(degrees: -200.0))
                        .padding(120)
                        .padding(.bottom, 105)
                        .rotation3DEffect(
                        .degrees(30),
                        axis: (x: 200, y: 2, z: 0.0))
                    
                    VStack {
                        TypingView(text: "Group8", startTime: 0.1).padding(.bottom, 5).padding(.top, 7).padding(.trailing, 248).font(.title2)
                        
                        TypingView(text: "Tanmay Prakash", startTime: 1.2)
                        TypingView(text: "Justin DeVito", startTime: 2.3)
                        TypingView(text: "Uyen Nguyen", startTime: 3.4)
                        TypingView(text: "Kimberly Juliano", startTime: 4.5)
                        TypingView(text: "Boming Lyu", startTime: 5.6).padding(.bottom, 40)
                    }
                    .foregroundColor(.black).opacity(0.8)
                    .fontWeight(.bold)
                    .offset(x: 0, y: 120)
                    .font(.title3)
                }}}
        
        else {
            
            ZStack
            {
                backgroundGradient.ignoresSafeArea()
                
                Button(action: {
                    dismiss()
                }) {Text("Cancel")}
                    .padding(.trailing, 630)
                    .padding(.bottom, 280)
                    
                HStack {
                    Text("Ter")
                        .rotation3DEffect(
                            .degrees(40),
                            axis: (x: 0, y: 0, z: 0.0))
                        .fontWeight(.bold)
                        .font(.system(size: 80, design: .rounded))
                        .foregroundColor(.black)
                        .shadow(color: Color.gray, radius: 3.5, x: -12, y: -5.6)
                        .padding(.bottom, 270)
                    
                    Text("Pal")
                        .rotation3DEffect(
                            .degrees(40),
                            axis: (x: 0, y: 0, z: 0.0))
                        .fontWeight(.bold)
                        .font(.system(size: 80, design: .rounded))
                        .foregroundColor(.red)
                        .shadow(color: Color.gray, radius: 3.5, x: -12, y: -5.6)
                        .padding(.bottom, 270)
                }
                
                 
                Path {
                    path in
                    
                    path.move(to: CGPoint(x: 134/3, y: 181/3))
                    path.addCurve(to: CGPoint(x: 157/3, y: 110/3), control1: CGPoint(x: 134/3, y: 181/3), control2: CGPoint(x: 120/3, y: 128/3))
                    path.addCurve(to: CGPoint(x: 242/3, y: 120/3), control1: CGPoint(x: 194/3, y: 92/3), control2: CGPoint(x: 242/3, y: 105/3))
                    path.addCurve(to: CGPoint(x: 134/3, y: 181/3), control1: CGPoint(x: 242/3, y: 135/3), control2: CGPoint(x: 134/3, y: 181/3))
                    path.closeSubpath()
                    path.move(to: CGPoint(x: 135/3, y: 187/3))
                    path.addCurve(to: CGPoint(x: 247/3, y: 132/3), control1: CGPoint(x: 135/3, y: 187/3), control2: CGPoint(x: 226/3, y: 154/3))
                    path.addCurve(to: CGPoint(x: 312/3, y: 85/3), control1: CGPoint(x: 268/3, y: 110/3), control2: CGPoint(x: 288/3, y: 85/3))
                    path.addCurve(to: CGPoint(x: 288/3, y: 141/3), control1: CGPoint(x: 336/3, y: 85/3), control2: CGPoint(x: 288/3, y: 150/3))
                    path.addCurve(to: CGPoint(x: 267/3, y: 203/3), control1: CGPoint(x: 288/3, y: 132/3), control2: CGPoint(x: 246/3, y: 178/3))
                    path.addCurve(to: CGPoint(x: 224/3, y: 198/3), control1: CGPoint(x: 288/3, y: 228/3), control2: CGPoint(x: 224/3, y: 209/3))
                    path.addCurve(to: CGPoint(x: 203/3, y: 185/3), control1: CGPoint(x: 225/4, y: 187/4), control2: CGPoint(x: 203/3, y: 185/3))
                    path.addLine(to: CGPoint(x: 185/3, y: 191/3))
                    path.addCurve(to: CGPoint(x: 171/3, y: 208/3), control1: CGPoint(x: 185/3, y: 191/3), control2: CGPoint(x: 178/3, y: 208/3))
                    path.addCurve(to: CGPoint(x: 145/3, y: 205/3), control1: CGPoint(x: 164/3, y: 208/3), control2: CGPoint(x: 145/3, y: 212/3))
                    path.addCurve(to: CGPoint(x: 135/3, y: 187/3), control1: CGPoint(x: 145/3, y: 198/3), control2: CGPoint(x: 135/3, y: 187/3))
                    path.closeSubpath()
                    path.move(to: CGPoint(x: 135/3, y: 187/3))

                    
                }
                .trim(from: flag ? 0 : 1, to: 1)
                .stroke(lineWidth: 4)
                .fill(AngularGradient(colors: [.red, .green, .blue, .purple, .pink],
                                      center: .center,
                                      startAngle: .degrees(310),
                                      endAngle: .degrees(410)))
                .offset(x:290, y: 172)
                .onAppear {
                    withAnimation(.easeInOut(duration: 3).delay(1).repeatForever(autoreverses:true)) {
                        flag.toggle()
                    }}
                ZStack {
                    RoundedRectangle(cornerRadius: 9)
                        .frame(width: 160, height: 290)
                        .foregroundColor(.white).opacity(0.40)
                        .shadow(color: Color.black, radius: 3, x: 13, y: 13)
                        .rotationEffect(.init(degrees: 810))
                        //.padding(10)
                        .padding(.top, 200)
                        //.padding(.trailing, 20)
                    
                    Circle()
                        .stroke(
                            .linearGradient(.init(colors: [Color(.yellow).opacity(3),
                                                           Color(.red).opacity(3)]),
                                            startPoint: .leading, endPoint: .trailing),
                            style: StrokeStyle(lineWidth:27, lineCap: .round, lineJoin:.round))
                        .shadow(color: Color.brown, radius: 3, x: 13, y: 13)
                        .rotationEffect(.init(degrees: -200.0))
                        .padding(99)
                        .padding(.bottom, 115)
                        .padding(.top, 39)
                        .rotation3DEffect(
                        .degrees(30),
                        axis: (x: 200, y: 2, z: 0.0))
                    
                    VStack {
                        TypingView(text: "Group8", startTime: 0.1).padding(.bottom, 10).padding(.top, 7).padding(.trailing, 158).font(.system(size: 16))
                        
                        TypingView(text: "Tanmay Prakash", startTime: 1.2)
                        TypingView(text: "Justin DeVito", startTime: 2.3)
                        TypingView(text: "Uyen Nguyen", startTime: 3.4)
                        TypingView(text: "Kimberly Juliano", startTime: 4.5)
                        TypingView(text: "Boming Lyu", startTime: 5.6).padding(.bottom, 40)
                    }
                    .foregroundColor(.black).opacity(8)
                    .fontWeight(.bold)
                    .offset(x: 0, y: 120)
                    .font(.system(size: 14))
                }}
        }
    }
}

 struct About_Previews: PreviewProvider {
 static var previews: some View {
     ContentView()
 }
 }
 
extension Path {
    func scale(x: CGFloat, y: CGFloat) -> Path {
        return applying(CGAffineTransform(scaleX: x, y: y))
    }}

struct TypingView: View {
    
    @State var names: Array<String.Element>
    @State var start: Double
    @State var opacity: Double = 0
    
    init(text: String, startTime: Double) {
        names = Array(text)
        start = startTime
    }
    
    var body: some View {
        HStack {
            ForEach(0..<names.count) { waitTime in
                Text(String(self.names[waitTime]))
                    .opacity(opacity)
                    .animation(.easeInOut.delay( Double(waitTime ) * 0.08 ), value: opacity)
            }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + start) { opacity = 1}}
        .onTapGesture {
            opacity = 1
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.7){ opacity = 2 }}}}
