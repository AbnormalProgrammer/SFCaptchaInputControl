//
//  LPInputCaptchaTextField.swift
//  LovelyPet
//
//  Created by Stroman on 2021/6/18.
//

import UIKit

class SFCaptchaInputTextField: UITextField {
    // MARK: - lifecycle
    override init(frame: CGRect) {
        super.init(frame:frame)
        self.customInitilizer()
        self.installUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    deinit {
        print("\(type(of: self))释放了")
    }
    
    override func becomeFirstResponder() -> Bool {
        let result:Bool = super.becomeFirstResponder()
        if result == true {
            self.addAnimation()
            self.textChangedAction()
        }
        return result
    }
    
    override func resignFirstResponder() -> Bool {
        let result:Bool = super.resignFirstResponder()
        if result == true {
            self.removeAnimation()
        }
        return result
    }
    
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        var result:UIView? = super.hitTest(point, with: event)
        if result != nil {
            result = self.focusButton
        }
        return result
    }
    // MARK: - custom methods
    private func customInitilizer() -> Void {
        self.backgroundColor = UIColor.clear
    }
    
    private func installUI() -> Void {
        self.addSubview(self.cursorLabel)
        self.addSubview(self.focusButton)
        
        self.cursorLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.centerX.equalToSuperview()
            make.width.equalTo(1.4)
            make.height.equalTo(24)
        }
        self.focusButton.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func addAnimation() -> Void {
        self.removeAnimation()
        let animation:CAKeyframeAnimation = CAKeyframeAnimation.init(keyPath: "opacity")
        animation.duration = 1
        animation.values = [1,1,0,0]
        animation.keyTimes = [0,0.5,0.5,1]
        animation.repeatCount = HUGE
        self.cursorLabel.layer.add(animation, forKey: "cursor")
    }
    
    private func removeAnimation() -> Void {
        self.cursorLabel.layer.removeAllAnimations()
        self.cursorLabel.layer.opacity = 0
    }
    
    private func textChangedAction() -> Void {
        let offset:CGFloat = 8
        if self.text != nil && self.text != "" {
            self.cursorLabel.snp.updateConstraints { make in
                make.centerX.equalToSuperview().offset(offset)
            }
        } else {
            self.cursorLabel.snp.updateConstraints { make in
                make.centerX.equalToSuperview()
            }
        }
    }
    // MARK: - public interfaces
    // MARK: - actions
    @objc private func focusButtonAction(_ sender:UIButton) -> Void {
        self.becomeFirstResponder()
    }
    // MARK: - accessors
    lazy private var focusButton:UIButton = {
        let result:UIButton = UIButton.init(type: .custom)
        result.addTarget(self, action: #selector(focusButtonAction(_:)), for: .touchUpInside)
        return result
    }()
    lazy private var cursorLabel:UILabel = {
        let result:UILabel = UILabel.init()
        result.backgroundColor = UIColor.colorFromHex(0x43D3ED)
        result.textAlignment = .center
        result.layer.opacity = 0
        result.sizeToFit()
        return result
    }()
    // MARK: - delegates
}
