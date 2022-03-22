//
//  SettingItemCell.swift
//  DropdownTextField
//
//  Created by Duy Tran N. VN.Danang on 12/27/21.
//

import UIKit.UITableViewCell

class SettingItemCell: UITableViewCell, DropDownTextFieldCell {

    @IBOutlet private weak var textField: UITextField!
    @IBOutlet private weak var arrowImageView: UIImageView!

    struct Config {
        static let leftSpacing: CGFloat = 100
        static let rightSpacing: CGFloat = 20.0
        static let topSpacing: CGFloat = 20.0
        static let textFieldHeight: CGFloat = 40.0
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        textField.isUserInteractionEnabled = false
//        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) { [weak self] in
//            guard let self = self else { return }
//            self.textField.frame = CGRect(x: Config.leftSpacing,
//                                          y: Config.topSpacing,
//                                          width: self.bounds.width - (Config.leftSpacing + Config.rightSpacing),
//                                          height: Config.textFieldHeight)
//            self.textField.backgroundColor = .white
//            self.addSubview(self.textField)
//        }
    }

    func updateView(with viewModel: SettingItemCellViewModel) {
        textLabel?.text = viewModel.title
        arrowImageView.image = UIImage(systemName: viewModel.isDroppedDown ? "arrow.down" : "arrow.up")
    }

    func getTextFieldFrames() -> (globalFrame: CGRect?, originalFrame: CGRect) {
        return (textField.globalFrame, textField.frame)
    }
}

struct SettingItemCellViewModel {
    var title: String
    var isDroppedDown: Bool = false
}

protocol DropDownTextFieldCell {
    /// Get the coordinate of text field
    /// - Returns: Global frame & Original frame
    func getTextFieldFrames() -> (globalFrame: CGRect?, originalFrame: CGRect)
}
