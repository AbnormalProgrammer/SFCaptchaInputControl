//
//  LPInputCaptchaSettingModel.swift
//  LovelyPet
//
//  Created by Stroman on 2021/6/18.
//

import UIKit

class SFCaptchaInputSettingModel: NSObject {
    // MARK: - lifecycle
    deinit {
        print("\(type(of: self))释放了")
    }
    
    override init() {
        super.init()
        self.customInitilizer()
    }
    // MARK: - custom methods
    private func customInitilizer() -> Void {
    }
    // MARK: - public interfaces
    // MARK: - actions
    // MARK: - accessors
    internal var charNumber:Int = 4/*这个验证码输入框接收几个字符*/
    internal var inputBoxWidth:CGFloat = 284/*输入框的宽度*/
    internal var inputBoxHeight:CGFloat = 50/*输入框的高度*/
    internal var neighourGap:CGFloat = 28/*相邻输入框的间隔距离*/
    // MARK: - delegates
}
