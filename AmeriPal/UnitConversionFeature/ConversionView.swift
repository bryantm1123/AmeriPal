import SwiftUI

struct ConversionView: View {
    @ObservedObject var conversionViewModel = ConversionViewModel()
    
    var body: some View {
        VStack {
            TextField(value: $conversionViewModel.temperature, format: .number) {
                Text("Enter temperature")
            }
            .keyboardType(.decimalPad)
            .padding()
            
            makeTemperaturePickerView(label: "Input Unit", with: $conversionViewModel.selectedTemperatureUnit)
            
            makeTemperaturePickerView(label: "Output Unit", with: $conversionViewModel.selectedOutputTemperatureUnit)
            
            Text(conversionViewModel.convertedTemperature())
                .padding()
            
            Spacer()
        }
        .padding()
    }
    
    private func makeTemperaturePickerView( // TODO: Maybe replace with @ViewBuilder
        label: String,
        with selection: Binding<UnitTemperature>
    ) -> some View {
        Picker(label, selection: selection) {
            ForEach(conversionViewModel.temperatureUnits, id: \.self) { unit in
                Text(unit.symbol)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ConversionView()
    }
}
