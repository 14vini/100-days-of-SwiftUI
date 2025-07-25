//
//  ContentView.swift
//  ChallengeConversionTempeture
//
//  Created by Vinicius on 7/24/25.
//

import SwiftUI

struct ContentView: View {
    @State private var temperature: Double = 0
    @State private var selectedInput: String = "Celsius"
    @State private var selectedOutput: String = "Fahrenheit"
    
    let typeOfTemperature = ["Celsius", "Fahrenheit", "Kelvin"]
    
    var convertedTemperature: Double {
        var tempInCelsius: Double
        
        
        switch selectedInput {
        case "Fahrenheit":
            tempInCelsius = (temperature - 32) * 5 / 9
        case "Kelvin":
            tempInCelsius = temperature - 273.15
        default:
            tempInCelsius = temperature
        }// convertendo tudo para celsius pra facilitar
        
        
        switch selectedOutput {
        case "Fahrenheit":
            return (tempInCelsius * 9 / 5) + 32
        case "Kelvin":
            return tempInCelsius + 273.15
        default:
            return tempInCelsius
        }
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Enter and select Input format") {
                    TextField("Temperature", value: $temperature, format: .number)
                        .keyboardType(.decimalPad)
                    
                    Picker("Select", selection: $selectedInput) {
                        ForEach(typeOfTemperature, id: \.self) {
                            Text($0)
                        }
                    }
                    .pickerStyle(.segmented)
                }
                
                Section("Select Output format") {
                    Picker("Select", selection: $selectedOutput) {
                        ForEach(typeOfTemperature, id: \.self) {
                            Text($0)
                        }
                    }
                    .pickerStyle(.segmented)
                }
                
                Section("Result") {
                    Text("\(convertedTemperature, specifier: "%.2f") \(selectedOutput)")
                }
            }
            .navigationTitle("Temp Converter")
        }
    }
}

#Preview {
    ContentView()
}
