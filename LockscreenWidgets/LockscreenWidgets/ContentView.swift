//
//  ContentView.swift
//  LockscreenWidgets
//
//  Created by Paul Yanez on 6/2/23.
//

import SwiftUI

struct ContentView: View {
    @State var showRing: Bool = false
    
    var body: some View {
        VStack(spacing: 0) {
            VStack(spacing: -10) {
                HStack(spacing: 4.0) {
                    Text("Mon 25")
                        .foregroundColor(Color(hex: 0xA9F7FF))
                    
                    Image(systemName: "cloud.moon.rain.fill")
                        .foregroundColor(Color(hex: 0xA9F7FF))
                    
                    Text(" 24°")
                        .foregroundColor(Color(hex: 0xA9F7FF))
                }
                
                Text("12:45")
                    .font(Font.custom("NewYorkExtraLarge-Heavy", size: 80, relativeTo: .largeTitle))
                    .foregroundColor(Color(hex: 0xA9F7FF))
            }
            
            LazyVGrid(columns: Array(repeating: .init(.flexible()), count: 3)) {
                VStack(alignment: .leading) {
                    Image(systemName: "figure.mind.and.body")
                        .font(.title)
                        .foregroundColor(.white)
                        .frame(width: 60, height: 60)
                        .background(.thickMaterial.opacity(0.3))
                        .clipShape(Circle())
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                
                VStack {
                    HStack(spacing: 20) {
                        ZStack {
                            ForEach(ringsLightBlue.indices, id: \.self) { index in
                                ZStack {
                                    Circle()
                                        .stroke(ringsLightBlue[index].keyColor.opacity(0.16), lineWidth: 12)
                                    Circle()
                                        .trim(from: 0, to: showRing ? ringsLightBlue[index].progress / 100 : 0)
                                        .stroke(ringsLightBlue[index].keyColor, style: StrokeStyle(lineWidth: 12, lineCap: .round, lineJoin: .round))
                                        .rotationEffect(.init(degrees: -90))
                                }
                                .padding(CGFloat(index) * 13)
                                
                                .onAppear {
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                                        withAnimation(.interactiveSpring(response: 1, dampingFraction: 1, blendDuration: 1).delay(Double(index) * 0.1)) {
                                            showRing = true
                                        }
                                    }
                                }
                                .onDisappear {
                                    showRing = false
                                }
                            }
                        }
                    }
                    .padding(10)
                    .frame(width: 130, height: 130)
                        .foregroundColor(.white)
                        .scaleEffect(x: 0.65, y: 0.65)
                }
                
                VStack {
                    Image(systemName: "bed.double.fill")
                        .font(.title3)
                        .foregroundColor(.white)
                        .frame(width: 60, height: 60)
                        .background(.thickMaterial.opacity(0.3))
                        .clipShape(Circle())
                }
                .frame(maxWidth: .infinity, alignment: .trailing)
            }
            .padding(.horizontal, 60)
            .frame(height: 90)

            Spacer()
            
            HStack(spacing: 50.0) {
                Button(action: {
                    // place action to perform when button is tapped
                }) {
                    Image(systemName: "flashlight.off.fill")
                        .font(.title3)
                        .foregroundColor(.white)
                        .frame(width: 54, height: 54)
                        .background(.thickMaterial.opacity(0.4))
                        .clipShape(Circle())
                }
                
                HStack {
                    Circle()
                        .frame(width: 12, height: 12)
                        .foregroundColor(.white)
                    
                    Text("3 Notifications")
                        .font(.caption)
                        .fontWeight(.medium)
                        .foregroundColor(Color.white)
                }
                
                Button(action: {
                    // place action to perform when button is tapped
                }) {
                    Image(systemName: "camera.fill")
                        .font(.title3)
                        .foregroundColor(.white)
                        .frame(width: 54, height: 54)
                        .background(.thickMaterial.opacity(0.4))
                        .clipShape(Circle())
                }
            }
        }.statusBarHidden(true)
        .padding(.top, 20)
        .background(
            Image("background-ocean2")
                .resizable()
                .scaledToFill()
                .frame(height: UIScreen.main.bounds.height)
                .ignoresSafeArea()
        )
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct Ring: Identifiable {
    var id = UUID().uuidString
    var progress: CGFloat
    var keyColor: Color
}

var ringsLightBlue:[Ring] = [
    Ring(progress: CGFloat.random(in: 80..<95), keyColor: Color.white),
    Ring(progress: CGFloat.random(in: 80..<95), keyColor: Color.white),
    Ring(progress: CGFloat.random(in: 80..<95), keyColor: Color.white)
]
