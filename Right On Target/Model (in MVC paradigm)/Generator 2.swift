import Foundation

/**
 Сущность "Генератор случайных чисел"
*/

protocol GeneratorProtocol {
    func getRandomValue() -> Int
}

class NumberGenerator: GeneratorProtocol {
    //начальное значение диапазона для выбора
    private let startRangeValue: Int
    //конечное значение диапазона для выбора
    private let endRangeValue: Int
    init?(startValue: Int, endValue: Int) {
        //Стартовое значение для выбора случайного числа
        //не может быть больше конечного
        guard startValue <= endValue else {
            return nil
        }
        startRangeValue = startValue
        endRangeValue = endValue
    }
    
    //Загадать и вернуть новое случайное значение
    func getRandomValue() -> Int {
        (startRangeValue...endRangeValue).randomElement()!
    }
}

