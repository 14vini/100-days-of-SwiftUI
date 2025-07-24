//
//  ContentView.swift
//  WeSplit
//
//  Created by Vinicius on 7/17/25.
//

import SwiftUI

struct ContentView: View {

    @State private var billAmount = 0.0
    @State private var numPeople = 2
    @State private var selectedTipPercentage = 20
    @FocusState private var amountIsFocused: Bool
    
    @State var tipPercentages = 20
    
    var tipValue: Double {
        billAmount * Double(selectedTipPercentage) / 100
    }

    var totalAmount: Double {
        billAmount + tipValue
    }

    var amountPerPerson: Double {
        totalAmount / Double(numPeople)
    }
    
    var body: some View {
        NavigationStack{
            Form{
                Section{
                    TextField("Amount", value: $billAmount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
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
                    Picker("Tip percentage", selection: $selectedTipPercentage) {
                        ForEach(0..<101) {
                            Text("\($0) %")
                        }
                    }
                    .pickerStyle(.navigationLink)
                }
                
                Section ("Value of the tip"){
                    Text(tipValue, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                }

                Section ("Total without tip"){
                    Text(billAmount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                }

                
                Section ("Total Amount"){
                    Text(totalAmount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                }
                
                Section ("Amount per person"){
                    Text(amountPerPerson, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                }
                
            }
            .navigationTitle("WeSplit")
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    Button("Done") {
                        amountIsFocused = false
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
