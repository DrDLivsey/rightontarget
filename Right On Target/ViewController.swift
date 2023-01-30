//
//  ViewController.swift
//  Right On Target
//
//  Created by Sergey Nikiforov on 20.01.2023.
//

import UIKit

class ViewController: UIViewController {
    
    //создаем сущность "Game"
    var game: Game!
    
    //элементы на сцене
    @IBOutlet var slider: UISlider!
    @IBOutlet var label: UILabel!
        
    
    //MARK: Жизненный цикл
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Создаем экземпляр сущности "Game"
        game = Game(startValue: 1, endValue: 50, rounds: 5)
        //записываем в лейбл загаданное в первый раз число
        updateLabelWithSecretNumber(newText: String(game.currentSecretValue))
    }
    
    
    //MARK: Взаимодействие View - Model
    
    //Проверка выбранного пользователем числа
    @IBAction func checkNumber() {
        //высчитываем очки за раунд
        game.calculateScore(with: Int(slider.value))
        //проверяем окончена ли игра
        if game.isGameEnded {
            showAlertWith(score: game.score)
            //начинаем игру заново
            game.restartGame()
        } else {
            game.startNewRound()
        }
        //Обновляем данные о текущем значении загаданного числа
        updateLabelWithSecretNumber(newText: String(game.currentSecretValue))
    }
        
        
    //MARK: Обновление View
    //Обновление текста загаданного числа
    private func updateLabelWithSecretNumber(newText: String) {
        self.label.text = newText
    }
    
    
    //Отображение всплывающего окна со счетом
    private func showAlertWith (score: Int) {
        let alert = UIAlertController (
            title: "Игра окончена",
            message: "Вы заработали \(score) очков",
            preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Начать заново", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}


