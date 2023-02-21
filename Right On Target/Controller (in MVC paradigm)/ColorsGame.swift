//Контроллер в терминах MVC

import UIKit

class ColorsGame: UIViewController {
    
    
    // Объявляем(но не инициализиурем) экземпляр игры с цветами
       var game: Game<SecretColorValue>!
    
    // номер "правильной" кнопки
       var correctButtonTag: Int = 0
    
    // вспомогательное свойство, позволяющее работать с аутлетами кнопок, как с коллекцией
      var buttonsCollection: [UIButton]!
    
    
    //элементы на сцене
    // Текстовая метка для вывода HEX
    @IBOutlet weak var hexColorLabel: UILabel!
    
    // Кнопки для выбора цвета
    @IBOutlet weak var buttonOption1: UIButton!
    @IBOutlet weak var buttonOption2: UIButton!
    @IBOutlet weak var buttonOption3: UIButton!
    @IBOutlet weak var buttonOption4: UIButton!
    
    
    
    //MARK: Жизненный цикл
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //инициализируем значение для переменной класса Game через вызов функции фабрики
        game = (GameFactory.getColorGame() as! Game<SecretColorValue>)
                buttonsCollection = [buttonOption1, buttonOption2, buttonOption3, buttonOption4]
                // Обновляем View
                updateScene()
    }
    
    //Кнопка закрытия экрана = удаление View из Памяти
    @IBAction func hideCurrentScene() {
        self.dismiss(animated: true, completion: nil)
    }
    
    private func updateScene() {
            let secretColorString = game.secretValue.value.getByHEXString()
            updateSecretColorLabel(withText: secretColorString)
            updateButtons(withRightSecretValue: game.secretValue)
        }
    
    
    //MARK: Взаимодействие View - Model
    
    // Проверка выбранного пользователем цвета
        @IBAction func compareValue(sender: UIButton) {
            var userValue = game.secretValue
            userValue.value = Color(from: sender.backgroundColor!)
            game.calculateScore(secretValue: game.secretValue, userValue: userValue)
            // Проверяем, окончена ли игра
            if game.isGameEnded {
                // Показываем окно с итогами
                showAlertWith(score: game.score)
                // Рестартуем игру
                game.restartGame()
            } else {
                // Начинаем новый раунд игры
                game.startNewRound()
            }
            updateScene()
        }
    
    
    //MARK: Обновление View
    // Обновление текста загаданного цвета
        private func updateSecretColorLabel(withText newHEXColorText: String ) {
            hexColorLabel.text = "#\(newHEXColorText)"
        }
        
        // Обновление фонового цвета кнопок
        private func updateButtons(withRightSecretValue secretValue: SecretColorValue) {
            // определяем, какая кнопка будет правильной
            correctButtonTag = Array(1...4).randomElement()!
            buttonsCollection.forEach { button in
                if button.tag == correctButtonTag {
                    button.backgroundColor = secretValue.value.getByUIColor()
                } else {
                    var copySecretValueForButton = secretValue
                    copySecretValueForButton.setRandomValue()
                    button.backgroundColor = copySecretValueForButton.value.getByUIColor()
                }
            }
        }
        
        // Отображение всплывающего окна со счетом
        private func showAlertWith( score: Int ) {
            let alert = UIAlertController(
                            title: "Игра окончена",
                            message: "Вы заработали \(score) очков",
                            preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Начать заново", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }

    }
