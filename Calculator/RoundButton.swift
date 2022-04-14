//
//  RoundButton.swift
//  Calculator
//
//  Created by 조영진 on 2022/04/14.
//

import UIKit

@IBDesignable // 커스텀뷰 속성을 스토리보드에 실시간 적용
class RoundButton: UIButton {
    
    @IBInspectable // 커스텀뷰 속성을 스토리보드에 적용
    var isRound :Bool = false {
        didSet {
            if isRound {
                self.layer.cornerRadius = self.frame.height / 2
            }
        }
    }
    

}
