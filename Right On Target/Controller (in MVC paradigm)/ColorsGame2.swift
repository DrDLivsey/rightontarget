//Контроллер в терминах MVC

import UIKit

class ColorsGame2: UIViewController {
    
    //создаем сущность "Игра"
    var game: Game!
    
    
    //элементы на сцене
    @IBOutlet weak var hexColorLabel: UILabel!
    @IBOutlet weak var buttonOption1: UIButton!
    @IBOutlet weak var buttonOption2: UIButton!
    @IBOutlet weak var buttonOption3: UIButton!
    @IBOutlet weak var buttonOption4: UIButton!
    
    //переменные, которые используются в коде
    var buttonsColorArray = [String]()
    var buttonPosition = 0
    var indexButtonPressed = 0
    
    
    
    //MARK: Жизненный цикл
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Создаем генератор случайных чисел
        let generator = NumberGenerator(startValue: 0x1, endValue: 0xf)!
        //создаем сущность игра
        game = Game(valueGenerator: generator, rounds: 5)
        updateButtonLabel()
    }
    
    //Кнопка закрытия экрана = удаление View из Памяти
    @IBAction func hideCurrentScene() {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    //MARK: Взаимодействие View - Model
    
    
    
    
    
    
    
    //MARK: Обновление View
    //Обновление текста в лейбле и кнопок
    private func updateButtonLabel() {
        
        let buttonArray = [buttonOption1, buttonOption2, buttonOption3, buttonOption4]
        
        for button in buttonArray {
            var newColor = [Int]()
            for _ in 1...6 {
                newColor.append(game.currentRound.currentSecretValue)
            }
            
            buttonsColorArray.append(newColor.map{String($0)}.joined()
            button?.setTitle("\(newColor)", for: UIControl.State.normal)
            button?.backgroundColor = UIColor(hex: newColor)
        }
        
        buttonPosition = chooseAnswer()
        self.hexColorLabel.text = buttonsColorArray[buttonPosition]
        buttonsColorArray.removeAll()
        print("\(buttonPosition)")
    }
    
    
    private func chooseAnswer()-> Int {
        let chosenHexColor = buttonsColorArray.randomElement()
        buttonPosition = buttonsColorArray.firstIndex(of: chosenHexColor!)!
        return buttonPosition
        
    }
    
    private func checkIfAnswerCorrect (_ indexInArray: Int,
                                       _ indexOfPressedButton: Int) {
        if indexInArray == indexOfPressedButton {
            print("Угадал")
        } else {
            print("Не угадал")
        }
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
    
    
    
    
    
    //создание HEX-кода для цвета
    func randomHexGenerator()->String{
        var arrayString = ["#"]
        let a = ["1","2","3","4","5","6","7","8","9","a","b","c","d","e","f"]
        
        for _ in 1...6 {
            arrayString.append(a[Int.random(in: 1..<15)])
        }
        let resultString = arrayString.joined()
        return resultString
    }
    
    
    
    
    @IBAction func buttonPressed (_ sender: UIButton) {
        indexButtonPressed = sender.tag
        checkIfAnswerCorrect(buttonPosition, indexButtonPressed)
        updateButtonLabel()
        
    }
    
}
