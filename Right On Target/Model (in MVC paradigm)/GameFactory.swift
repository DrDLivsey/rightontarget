import Foundation

/**
Сущность "Раунд"
*/

protocol GameRoundProtocol {
    //Количество заработанных за раунд очков
    var score: Int { get }
    //загаданное значение
    var currentSecretValue: Int { get }
    //подсчет заработанных за раунд очков
    func calculateScore(with value: Int)
}


class GameRound: GameRoundProtocol {
    var score: Int = 0
    var currentSecretValue: Int = 0
    init (secretValue: Int) {
        currentSecretValue = secretValue
    }
    //подсчет количества очков для игры с числами
    func calculateScore(with value: Int) {
        if value > currentSecretValue {
            score += 50 - value + currentSecretValue
        } else if value < currentSecretValue {
            score += 50 - currentSecretValue + value
        } else {
            score += 50
        }
    }
    //подсчет количества очков для игры с цветами
    func calculateScoreForColorGame(with value: Int) {
        if value == currentSecretValue {
            score += 1
        }
    }
}
