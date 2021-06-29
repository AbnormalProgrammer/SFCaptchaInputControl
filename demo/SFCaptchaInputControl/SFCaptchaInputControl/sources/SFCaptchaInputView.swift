//
//  LPInputCaptchaView.swift
//  LovelyPet
//
//  Created by Stroman on 2021/6/18.
//

import UIKit
/*
 专门用于输入验证码的输入框
 控件。
 */
class SFCaptchaInputView: UIView {
    // MARK: - lifecycle
    override init(frame: CGRect) {
        super.init(frame:frame)
        self.customInitilizer()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    deinit {
        print("\(type(of: self))释放了")
    }
    
    convenience init(_ settings:@escaping((SFCaptchaInputSettingModel) -> Void)) {
        self.init()
        settings(self.settingModel)
        self.installUI()
    }
    // MARK: - custom methods
    private func customInitilizer() -> Void {
    }
    
    private func installUI() -> Void {
        self.snp.makeConstraints { make in
            make.width.equalTo(self.settingModel.inputBoxWidth)
            make.height.equalTo(self.settingModel.inputBoxHeight)
        }
        self.addSubview(self.horizontalStackView)
        self.horizontalStackView.spacing = self.settingModel.neighourGap
        for iterator in self.captchaTextFields {
            self.horizontalStackView.addArrangedSubview(iterator)
        }
        self.snp.makeConstraints { make in
            make.width.equalTo(self.settingModel.inputBoxWidth)
            make.height.equalTo(self.settingModel.inputBoxHeight)
        }
        self.horizontalStackView.snp.makeConstraints { make in
            make.edges.equalTo(self)
        }
        self.captchaTextFields.first!.becomeFirstResponder()
    }
    // MARK: - public interfaces
    // MARK: - actions
    /// 在这里监听输入到某个textfield的文字变化
    /// 查看该输入文字有多少个字符
    /// 顺次把这些字符填入到当前及后面对应个数的
    /// textfield中去。
    /// - Parameter sender: 当前正在输入字符
    /// - Returns: 空
    @objc private func textChangedAction(_ sender:SFCaptchaInputTextField) -> Void {
        let currentText:String? = sender.text
        guard currentText != nil && currentText != "" else {
            sender.becomeFirstResponder()
            return
        }
        let currentIndex:Int = self.captchaTextFields.firstIndex(of: sender)!
        for index in 0..<min(self.captchaTextFields.count - currentIndex,currentText!.count) {
            self.captchaTextFields[index + currentIndex].text = String.init(currentText!.characterOf(index)!)
        }
        if currentIndex + currentText!.count >= self.captchaTextFields.count {
            for iterator in self.captchaTextFields {
                iterator.resignFirstResponder()
            }
        } else {
            self.captchaTextFields[currentIndex + currentText!.count].becomeFirstResponder()
        }
    }
    // MARK: - accessors
    internal let settingModel:SFCaptchaInputSettingModel = SFCaptchaInputSettingModel.init()
    lazy private var horizontalStackView:UIStackView = {
        let result:UIStackView = UIStackView.init()
        result.axis = .horizontal
        result.distribution = .equalSpacing
        result.alignment = .center
        result.isUserInteractionEnabled = true
        return result
    }()
    lazy private var captchaTextFields:[SFCaptchaInputTextField] = {
        var result:[SFCaptchaInputTextField] = [SFCaptchaInputTextField].init()
        for index in 0..<self.settingModel.charNumber {
            let currentOne:SFCaptchaInputTextField = SFCaptchaInputTextField.init()
            currentOne.addTarget(self, action: #selector(textChangedAction(_:)), for: .editingChanged)
            currentOne.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.init(item: currentOne, attribute: .width, relatedBy: .equal, toItem: currentOne, attribute: .height, multiplier: 1, constant: 0).isActive = true
            NSLayoutConstraint.init(item: currentOne, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 0, constant: 50).isActive = true
            currentOne.layer.cornerRadius = 12
            currentOne.textAlignment = .center
            currentOne.layer.masksToBounds = true
            currentOne.font = UIFont.systemFont(ofSize: 16)
            currentOne.textColor = .black
            currentOne.backgroundColor = UIColor.white
            currentOne.tintColor = .clear
            result.append(currentOne)
        }
        return result
    }()
    // MARK: - delegates
}
