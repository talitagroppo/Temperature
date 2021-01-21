//
//  ContentView.swift
//  Challenge day - 19
//
//  Created by Talita Groppo on 21/01/2021.
//

import SwiftUI

struct ContentView: View {
    @State private var output = 0.0
    @State private var input = ""
    @State private var inputMeasure = "K"
    @State private var outputMeasure = "°C"
    
    let typesOfTemps = ["°C", "°F", "K"]
    
    var body: some View {
        Form {
            Section(header: Text("Input")) {
                TextField("Colocar dado para conversão", text: $input)
            }
            
            Section(header: Text("Medidas para conversão")) {
                Picker("Medida do input", selection: $inputMeasure) {
                    ForEach(typesOfTemps, id: \.self) { type in
                        Text(type).tag(type)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                
                Picker("Medida do output", selection: $outputMeasure) {
                    ForEach(typesOfTemps, id: \.self) { type in
                        Text(type).tag(type)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
            }
            
            Section(header: Text("Output")) {
                HStack {
                    Button("Calcular") {
                        calcularMedida()
                    }
                    Spacer()
                    Text("\(String(format: "%.2f", output)) \(outputMeasure)")
                }
            }
        }
    }
    
    func calcularMedida() {
        let internalInput = Double(input) ?? 0.0
        
        var temp: Measurement<UnitTemperature>
        
        switch inputMeasure {
        case "K":
            temp = Measurement(value: internalInput, unit: UnitTemperature.kelvin)
        case "°C":
            temp = Measurement(value: internalInput, unit: UnitTemperature.celsius)
        default:
            temp = Measurement(value: internalInput, unit: UnitTemperature.fahrenheit)
        }
        
        switch outputMeasure {
        case "K":
            temp.convert(to: .kelvin)
        case "°C":
            temp.convert(to: .celsius)
        default:
            temp.convert(to: .fahrenheit)
        }
        
        
        output = temp.value
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
