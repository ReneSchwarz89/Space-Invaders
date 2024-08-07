//
//  ContentView.swift
//  Space Invaders Homage
//
//  Created by Michel Matys on 05.08.24.
//

import SwiftUI
import SpriteKit
import GameKit

struct ContentView: View {
    @State private var showGameScene = false
    @State private var showCountdown = false
    @State private var countdownFinished = false
    @State private var playerName = ""
    @State private var playersMaxScore = 0
    @State public var playerLives = 3
    @State public var playerScore = 0
    
    var body: some View {
        ZStack {
            if !showGameScene {
                Image("background-contenview")
                    .resizable()
                    .scaledToFill()
                    .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
                    .clipped()
                    .edgesIgnoringSafeArea(.all)
                
                VStack {
                    Spacer()
                    
                    Button("Spiel Starten") {
                        showCountdown = true
                    }
                    .padding()
                    .background(Color.brown)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .shadow(radius: 10)
                    .position(x: UIScreen.main.bounds.width / 2, y: UIScreen.main.bounds.height - 150)
                }
            }
            
            if showCountdown {
                            CountdownOverlay(countdownFinished: $countdownFinished, showCountDown: $showCountdown, showGameScene: $showGameScene)
                        }
            
            if showGameScene && countdownFinished {
                SpriteView(scene: GameScene(size: CGSize(width: 400, height: 800), playerScore: $playerScore))
                    .ignoresSafeArea()
                
                VStack {
                    VStack{
                        HStack {
                            ZStack{
                                RoundedRectangle(cornerRadius: 10)
                                    .frame(maxWidth: 120, maxHeight: 30)
                                    .foregroundColor(.brown)
                                    .opacity(0.8)
                                Text("HighScore: \(playersMaxScore)")
                                    .foregroundColor(.white)
                            }
                            Spacer()
                            ZStack{
                                RoundedRectangle(cornerRadius: 10)
                                    .frame(maxWidth: 120, maxHeight: 30)
                                    .foregroundColor(.brown)
                                    .opacity(0.8)
                                Text("Lives: \(playerLives)")
                                    .foregroundColor(.white)
                            }
                        }
                        .padding(.top, 14)
                        
                        HStack {
                            // Unsichtbarer Platzhalter
                            Button(action: {}) {
                                Image(systemName: "pause")
                                    .font(.title)
                                    .padding()
                                    .background(Color.clear)
                                    .clipShape(Circle())
                                    .foregroundColor(.clear)
                                    .shadow(radius: 10)
                            }
                            Spacer()
                            Text("\(playerScore)")
                                .font(.system(size: 24)) // Größere Schriftgröße
                                .foregroundColor(.yellow) // Andere Farbe
                            Spacer()
                            Button(action: {
                                showGameScene = false
                            }) {
                                Image(systemName: "power")
                                    .font(.title)
                                    .padding()
                                    .background(Color.clear)
                                    .clipShape(Circle())
                                    .foregroundColor(.brown)
                                    .shadow(radius: 10)
                            }
                        }
                        .padding(.leading, 8)
                        .padding(.top, -8)
                    }
                    .edgesIgnoringSafeArea(.top)
                    Spacer()
                }
            }
        }
    }
}

struct CountdownOverlay: View {
    @Binding var countdownFinished: Bool
    @Binding var showCountDown: Bool
    @Binding var showGameScene: Bool
    @State private var countdown = 3
    
    var body: some View {
        if countdown > 0 {
            ZStack {
                Color.black.opacity(0.4)
                    .edgesIgnoringSafeArea(.all)
                
                Text("\(countdown)")
                    .font(.system(size: 60))
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .onAppear {
                        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
                            if countdown > 1 {
                                countdown -= 1
                            } else {
                                timer.invalidate()
                                countdownFinished = true
                                showCountDown = false
                                showGameScene = true
                            }
                        }
                    }
            }
        }
    }
}

#Preview {
    ContentView()
}
