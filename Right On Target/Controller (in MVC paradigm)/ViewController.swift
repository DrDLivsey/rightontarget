//Контроллер в терминах MVC

import UIKit

class ViewController: UIViewController {
    
    //создаем сущность "Игра"
    var game: Game!
    
    //элементы на сцене
    @IBOutlet var slider: UISlider!
    @IBOutlet var label: UILabel!
        
    
    //MARK: Жизненный цикл
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Создаем генератор случайных чисел
        let generator = NumberGenerator(startValue: 1, endValue: 50)!
        //создаем сущность игра
        game = Game(valueGenerator: generator, rounds: 5)
        //Обновляем данные о текущем значении загаданного числа
        updateLabelWithSecretNumber(newText: String(game.currentRound.currentSecretValue))
    }
    
    @IBAction func hideCurrentScene() {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    //MARK: Взаимодействие View - Model
    
    //Проверка выбранного пользователем числа
    @IBAction func checkNumber() {
        //высчитываем очки за раунд
        game.currentRound.calculateScore(with: Int(slider.value))
        //проверяем окончена ли игра
        if game.isGameEnded {
            showAlertWith(score: game.score)
            //начинаем игру заново
            game.restartGame()
        } else {
            game.startNewRound()
        }
        //Обновляем данные о текущем значении загаданного числа
        updateLabelWithSecretNumber(newText: String(game.currentRound.currentSecretValue))
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


