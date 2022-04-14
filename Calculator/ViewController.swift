//
//  ViewController.swift
//  Calculator
//
//  Created by 조영진 on 2022/04/07.
//

import UIKit

enum Operation {
    case Add
    case Subtract
    case Divide
    case Multiply
    case unknown
}

class ViewController: UIViewController {

    @IBOutlet weak var numberOutputLabel: UILabel!

    var displayNumber = ""
    var firstOperand = ""
    var secondOperand = ""
    var result = ""
    var currentOperation: Operation = .unknown

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func tapNumberBUtton(_ sender: UIButton) {
        // sender.currentTitle 와 sender.titleLabel.text 차이
        // currentTitle은 읽기전용. 표시되는 텍스트 값만 필요할 때 사용.
        // sender.titleLabel.text는 상태에 따라 버튼의 텍스트를 구성할 때 사용.
        guard let numberValue = sender.currentTitle else { return }

        if self.displayNumber.count < 9 {
            self.displayNumber += numberValue
            self.numberOutputLabel.text = self.displayNumber
        }
    }

    @IBAction func tapDotButton(_ sender: UIButton) {
        if self.displayNumber.count < 8, !self.displayNumber.contains(".") {
            self.displayNumber += self.displayNumber.isEmpty ? "0." : "."
            self.numberOutputLabel.text = self.displayNumber
        }
    }

    @IBAction func tapClearButton(_ sender: UIButton) {

        numberOutputLabel.text = "0"

        self.displayNumber = ""
        self.firstOperand = ""
        self.secondOperand = ""
        self.result = ""
        self.currentOperation = .unknown
    }

    @IBAction func tapDivideButton(_ sender: UIButton) {
        self.operation(.Divide)
    }

    @IBAction func tapMultiplyButton(_ sender: UIButton) {
        self.operation(.Multiply)
    }

    @IBAction func tapSubtractButton(_ sender: UIButton) {
        self.operation(.Subtract)
    }

    @IBAction func tapAddButton(_ sender: UIButton) {
        self.operation(.Add)
    }

    @IBAction func tapEqualButton(_ sender: UIButton) {
        self.operation(self.currentOperation)
    }

    func operation(_ operation: Operation) {
        // 첫 실행시 unknown이 초기값이기 때문에 else 구문으로 넘어간다.
        if self.currentOperation != .unknown {
            if !self.displayNumber.isEmpty {
                self.secondOperand = displayNumber

                self.displayNumber = ""



                guard let firstOperand = Double(self.firstOperand) else { return }
                guard let secondOperand = Double(self.secondOperand) else { return }

                switch currentOperation {
                case .Add:
                    self.result = "\(firstOperand + secondOperand)"
                case .Subtract:
                    self.result = "\(firstOperand - secondOperand)"
                case .Divide:
                    self.result = "\(firstOperand / secondOperand)"
                case .Multiply:
                    self.result = "\(firstOperand * secondOperand)"
                default:
                    break
                }
                if let result = Double(self.result), result.truncatingRemainder(dividingBy: 1) == 0 {
                    self.result = "\(Int(result))"
                }
                self.firstOperand = self.result
                self.numberOutputLabel.text = self.result
            }
            self.currentOperation = operation

        } else {
            self.firstOperand = self.displayNumber
            self.currentOperation = operation // 더하기 실행시 .Add가 들어감
            self.displayNumber = "" // 숫자 초기화
        }
    }
}

