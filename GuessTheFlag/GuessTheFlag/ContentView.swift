//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Vinicius on 7/25/25.
//

import SwiftUI

struct ContentView: View {
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Spain", "UK", "Ukraine", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    
    @State private var showingScore = false
    @State private var score: Int = 0
    @State private var scoreTitle = ""
    
    struct LabelView: View {
        let title: String
        let subtitle: String
        
        var body: some View {
            VStack {
                Text(title)
                    .font(.largeTitle)
                    .foregroundStyle(.white)
                Text(subtitle)
                    .font(.title2)
                    .foregroundStyle(.white)
            }
            .fontWeight(.semibold)
        }
    }
    
    struct FlagButton: View {
        let imageName: String
        let action: () -> Void
        
        var body: some View {
            Button(action: action) {
                Image(imageName)
                    .cornerRadius(10)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.primary, lineWidth: 3)
                    )
            }
        }
    }
    
    var body: some View {
        ZStack {
            RadialGradient(
                stops: [
                    .init(color: Color(red: 0.1 , green: 0.2 , blue: 0.45), location: 0.3),
                    .init(color: Color(red: 0.76, green: 0.15, blue: 0.3), location: 0.3)
                ],
                center: .top,
                startRadius: 150,
                endRadius: 700)
                .ignoresSafeArea()
            
            VStack {
                Spacer()
                
                VStack(spacing: 30) {
                    LabelView(title: "Guess the flag", subtitle: "Tap the flag of")
                    
                    VStack (spacing: 20){
                        
                        Text(countries[correctAnswer])
                            .font(.largeTitle)
                            .fontWeight(.bold)
                        
                        ForEach(0..<3) { number in
                            FlagButton(imageName: countries[number]) {
                                flagTapped(number)
                            }
                        }
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.vertical)
                    .background(.regularMaterial)
                    .clipShape(RoundedRectangle(cornerRadius: 30))
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical)
                
                Text("Score: \(score)")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundStyle(.primary)
                    .padding(8)
                    .background(.regularMaterial)
                    .clipShape(.capsule)
                
                Spacer()
            }
            .padding()
            .fontDesign(.rounded)
            
        }.alert(scoreTitle, isPresented: $showingScore){
            Button("Continue", action: askQuestion)
        } message: {
            Text("Your score is: \(score)")
        }
    }
    
    func flagTapped(_ number: Int){
        if number == correctAnswer {
            scoreTitle = "Correct"
            score += 1
        } else {
            scoreTitle = "Wrong. That’s the flag of \(countries[number])"
        }
        
        showingScore = true
    }
    
    func askQuestion(){
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
}

#Preview {
    ContentView()
}
