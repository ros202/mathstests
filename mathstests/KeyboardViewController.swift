//
//  KeyboardViewController.swift
//  mathstests
//
//  Created by Ross Harrison on 01/10/18.
//  Copyright © 2018 Ross Harrison. All rights reserved.
//

import UIKit

protocol KeyboardDelegate: class {
    func keyWasTapped(character: String)
}

class KeyboardView: UIView {
    
    weak var delegate: KeyboardDelegate?
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initializeSubviews()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initializeSubviews()
    }
    
    func initializeSubviews() {
        let xibFileName = "Keyboard2"
        let view = Bundle.main.loadNibNamed(xibFileName, owner: self, options: nil)![0] as! UIView
        self.addSubview(view)
        view.frame = self.bounds
    }
    
    @IBAction func keyTapped(sender: UIButton) {
        delegate?.keyWasTapped(character: sender.titleLabel!.text!)
        
    }
    
    // add new actions linked to return key and delete key to send something else other than the label!

}

class ReturnButton: UIButton {
    var defaultBackgroundColor: UIColor =  _ColorLiteralType(red: 0.07450980392, green: 0.4980392157, blue: 0.9843137255, alpha: 1)
    var highlightBackgroundColor: UIColor = .lightGray
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        backgroundColor = isHighlighted ? highlightBackgroundColor : defaultBackgroundColor
        titleLabel?.textColor = UIColor.white
    }
}

class KeyboardButton: UIButton {
    var defaultBackgroundColor: UIColor = .white
    var highlightBackgroundColor: UIColor = .lightGray
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        backgroundColor = isHighlighted ? highlightBackgroundColor : defaultBackgroundColor
        titleLabel?.textColor = UIColor.black
    }
}

private extension ReturnButton {
    func commonInit() {
        layer.cornerRadius = 5.0
        layer.masksToBounds = false
        layer.shadowOffset = CGSize(width: 0, height: 1.0)
        layer.shadowRadius = 0.0
        layer.shadowOpacity = 0.35
    }
}

private extension KeyboardButton {
    func commonInit() {
        layer.cornerRadius = 5.0
        layer.masksToBounds = false
        layer.shadowOffset = CGSize(width: 0, height: 1.0)
        layer.shadowRadius = 0.0
        layer.shadowOpacity = 0.35
    }
}

class DeleteKeyButton: KeyboardButton {
    override func layoutSubviews() {
        super.layoutSubviews()
        backgroundColor = isHighlighted ? UIColor.white : UIColor.lightGray
        
    }
}
