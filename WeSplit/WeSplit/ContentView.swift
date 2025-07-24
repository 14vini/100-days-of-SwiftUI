//
//  ContentView.swift
//  WeSplit
//
//  Created by Vinicius on 7/17/25.
//

import SwiftUI

struct ContentView: View {

    @State private var checkAmount = 0.0
    @State private var numPeople = 2
    @State private var tipPercentage = 20
    @FocusState private var amountIsFocused: Bool
    
    let tipPercentages = [10, 15, 20, 25, 0]
    
    var totalPerPerson: Double {
        let peopleCount = Double(numPeople + 2)
        let tipSelection = Double(tipPercentage)
        
        let tipValue = (checkAmount / 100) * tipSelection
        let totalValue = checkAmount + tipValue
        let totalPerPersonValue = totalValue / peopleCount
        
        return totalPerPersonValue
        
    }
    
    var body: some View {
        VStack{
            NavigationStack{
                Form{
                    Section{
                        TextField("Amount", value: $checkAmount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                            .keyboardType(.decimalPad)
                            .focused($amountIsFocused)
                        
                        Picker("Number of people", selection: $numPeople){
                            ForEach(2..<100){
                                Text("\($0) people")
                            }
                        }
                        .pickerStyle(.navigationLink)
                        
                    }
                    
                    Section ("how much do you want to tip?"){
                        Picker("Tip percentage", selection: $tipPercentage) {
                            ForEach(tipPercentages, id: \.self) {
                                Text($0, format: .percent)
                            }
                        }
                        .pickerStyle(.segmented)
                    }
                    
                    Section{
                        Text(totalPerPerson, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                    }
                    
                }
                .navigationTitle("WeSplit")
                .toolbar {
                    if amountIsFocused {
                        Button("Done") {
                            amountIsFocused = false
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
