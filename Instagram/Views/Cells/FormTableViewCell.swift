//
//  FormTableViewCell.swift
//  Instagram
//
//  Created by Amr Hossam on 22/07/2021.
//

import UIKit


protocol FormTableViewCellDelegate: AnyObject {
    func didFinishEditing(with model: EditProfileFormModel)
}

class FormTableViewCell: UITableViewCell, UITextFieldDelegate {
    
    // initializing our model as an optional to be filled later
    private var model: EditProfileFormModel?
    // we use identifier to register the cell with the table view
    static let identifier = "FormTableViewCell"
    // this is the delegate that will start the connection between the view and the controller
    public weak var delegate: FormTableViewCellDelegate?
    // initializing a label with the annonymous disclosure method
    private let formLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.numberOfLines = 1
        return label
    }()
    // initializing a field with annonymous disclosure method
    private let field: UITextField = {
        let field = UITextField()
        field.returnKeyType = .done
        return field
    }()
    // the initializer for the cell. this works as the viewDidLoad method
    // this is used basically as a starting point
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        clipsToBounds = true
        contentView.addSubview(formLabel)
        contentView.addSubview(field)
        field.delegate = self
    }
    // mandatory method for implementation
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // the way back for the controller to talk to the view
    public func configure(with model: EditProfileFormModel) {

        self.model = model
        formLabel.text = model.label
        field.placeholder = model.placeHolder
        model.value?.split(separator: " ").forEach{
            word in
            if field.text!.count > 0 {
                field.text?.append(" "+String(word).capitalizingFirstLetter())
            } else {
                field.text?.append(String(word).capitalizingFirstLetter())
            }


        }
    }
    // setting frames
    override func layoutSubviews() {
        super.layoutSubviews()
        formLabel.frame = CGRect(x: 15,
                                 y: 0,
                                 width: contentView.width / 3,
                                 height: contentView.height)
        
        field.frame = CGRect(x: formLabel.right + 5,
                             y: 0,
                             width: contentView.width - 10 - formLabel.width,
                             height: contentView.height)
        
    }
    
    // life cycle method that gets called after dequeuing a cell
    override func prepareForReuse() {
        super.prepareForReuse()
        formLabel.text = nil
        field.placeholder = nil
        field.text = nil
    }
    
    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        model?.value = textField.text
        guard let model = model else { return}
        delegate?.didFinishEditing(with: model)
    }
}
