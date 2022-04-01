//
//  ViewController.swift
//  UISegmentedControl
//
//  Created by Белов Руслан on 21.03.2022.
//

import UIKit

class ViewController: UIViewController {
    
    var uiElements = ["UISegmentedControl", "UILabel", "UISlider", "UITextField", "UIButton", "UIDatePicker" ]
    
    var selectedElement: String?
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var doneButton: UIButton!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var switchLabel: UILabel!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        slider.value = 1
//        label.isHidden = true // делает его скрывающимся
        label.text = String(slider.value)
        label.font = label.font.withSize(25)
        label.textAlignment = .center
        label.numberOfLines = 2
        
        segmentedControl.insertSegment(withTitle: "GREN", at: 2, animated: true)
        
        slider.minimumValue = 0
        slider.maximumValue = 1
        slider.minimumTrackTintColor = .orange
        slider.maximumTrackTintColor = .black
        slider.thumbTintColor = .gray
        
        datePicker.locale = Locale(identifier: "ru_RU")
        
        choiceUiElement()
        
        createToolbar()
    }
    func hideAllElements() {
        segmentedControl.isHidden = true
        label.isHidden = true
        slider.isHidden = true
        doneButton.isHidden = true
        datePicker.isHidden = true
    }
    
    
    func choiceUiElement() {
        let elementPicker = UIPickerView().self
        elementPicker.delegate = self
        
        textField.inputView = elementPicker
        
        //костамизация
        elementPicker.backgroundColor = .brown
    }
    
    
    func createToolbar() {
        
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
         
        let doneButton = UIBarButtonItem(title: "Done",
                                         style: .plain,
                                         target: self,
                                         action: #selector(dismissKeyboard))
        
        toolbar.setItems([doneButton], animated: true)
        toolbar.isUserInteractionEnabled = true
        
        textField.inputAccessoryView = toolbar
        
        toolbar.tintColor = .white
        toolbar.barTintColor = .brown
    }
    
       @objc func dismissKeyboard() {
            view.endEditing(true)
        }
    
    @IBAction func choiseSegmented(_ sender: UISegmentedControl) {
        
        label.isHidden = false
        
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            label.text = "RED"
            label.textColor = .red
        case 1:
            label.text = "BLUE"
            label.textColor = .blue
        case 2:
            label.text = "GREEN"
            label.textColor = .green
        default:
            print("Something wrong")
        }
    }
    
    @IBAction func sliderAction(_ sender: UISlider) {
        label.text = String(sender.value)
        
        let backgroundColor = self.view.backgroundColor
        self.view.backgroundColor = backgroundColor?.withAlphaComponent(CGFloat(sender.value))
    }
    
    @IBAction func donePressed(_ sender: UIButton) {
        label.text = textField.text
        
        guard textField.text?.isEmpty == false else {return}
        
        if let _ = Double(textField.text!) {
            label.text = ""
            let alert = UIAlertController(title: "Неверный формат", message: "Пожалуйста введите имя", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "ОК", style: .default, handler: nil)
            alert.addAction(okAction)
            present(alert, animated: true, completion: nil)
            print("Только буквы")
        } else {
            label.text = textField.text
            textField.text = nil
        }
    }
    @IBAction func changeDate(_ sender: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .full
        let dateValue = dateFormatter.string(from: sender.date)
        label.text = dateValue
    }
    
    @IBAction func switchAction(_ sender: UISwitch) {
         
        segmentedControl.isHidden = !segmentedControl.isHidden //!segmentedControl.isHidden - ! ставит значение на противоположенное
        label.isHidden = !label.isHidden
        slider.isHidden = !slider.isHidden
        textField.isHidden = !textField.isHidden
        doneButton.isHidden = !doneButton.isHidden
        datePicker.isHidden = !datePicker.isHidden
    
        
        if sender.isOn {
            switchLabel.text = "Отобразить все элементы"
        } else {
            switchLabel.text = "Скрыть все элементы"
        }
    }
}

extension ViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1 //возвращает колличество барабанов которое мы будем использовать
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return uiElements.count //возвращает колличество элементов доступных в PickerView в данном случае мы ограничиваем колличеством элементов массива
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return uiElements[row] //данный метод позволяет отображать в каждой строке PickerView определенное значение в данном случае мы берем значение из uiElements подставляя элемент row мы убираем тот или иной элемент из массива
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        selectedElement = uiElements[row] //позволяет работать с выбранным элементом
        textField.text = selectedElement
        
        switch row {
        case 0:
            hideAllElements()
            segmentedControl.isHidden = false
        case 1:
            hideAllElements()
            label.isHidden = false
        case 2:
            hideAllElements()
            slider.isHidden = false
        case 3:
            hideAllElements()
        case 4:
            hideAllElements()
            doneButton.isHidden = false
        case 5:
            hideAllElements()
            datePicker.isHidden = false
        default:
            hideAllElements()
        }
    }
    
    func pickerView(_ pickerView: UIPickerView,
                    viewForRow row: Int,
                    forComponent component: Int,
                    reusing view: UIView?) -> UIView {
       
        var pickerViewLabel = UILabel()
        
        if let currentLabel = view as? UILabel {
            pickerViewLabel = currentLabel
        } else {
            pickerViewLabel = UILabel()
        }
        
        pickerViewLabel.textColor = .white
        pickerViewLabel.textAlignment = .center
        pickerViewLabel.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 23)
        pickerViewLabel.text = uiElements[row]
        
        return pickerViewLabel
    }
    
}

