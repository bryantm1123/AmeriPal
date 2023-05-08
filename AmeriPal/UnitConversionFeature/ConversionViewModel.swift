import Foundation
import UnitConversion

final class ConversionViewModel: ObservableObject {
    @Published var temperature: Double = 0.0
    @Published var selectedTemperatureUnit: UnitTemperature = .celsius
    @Published var selectedOutputTemperatureUnit: UnitTemperature = .fahrenheit
    
    let temperatureUnits: [UnitTemperature] = [.celsius, .fahrenheit]
    
    private let unitConverter: UnitConversionProviding
    
    init(unitConverter: UnitConversionProviding = UnitConversionProvider()) {
        self.unitConverter = unitConverter
    }
    
    func convertedTemperature() -> String {
        let converted = unitConverter.convertTemperature(value: temperature, from: selectedTemperatureUnit, to: selectedOutputTemperatureUnit)
        
        let measurementFormatter = MeasurementFormatter() // TODO: Move this to package level
        measurementFormatter.unitOptions = .providedUnit
        measurementFormatter.numberFormatter.maximumFractionDigits = 1
        measurementFormatter.numberFormatter.roundingMode = .up
        
        return measurementFormatter.string(from: converted)
    }
}

extension UnitTemperature: Identifiable {}
