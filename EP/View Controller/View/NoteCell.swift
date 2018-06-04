//  NoteCell.swift

import UIKit

class NoteCell: UITableViewCell {
    var step: String?

    var noteLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleToFill
        view.numberOfLines = 0
        view.lineBreakMode = .byWordWrapping
        view.font = UIFont.preferredFont(forTextStyle: .subheadline)
        view.textAlignment = .justified
        return view
    }()
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        let marginGuide = contentView.layoutMarginsGuide
        contentView.addSubview(noteLabel)
        noteLabel.leadingAnchor.constraint(equalTo: marginGuide.leadingAnchor).isActive = true
        noteLabel.trailingAnchor.constraint(equalTo: marginGuide.trailingAnchor).isActive = true
        noteLabel.topAnchor.constraint(equalTo: marginGuide.topAnchor).isActive = true
        noteLabel.bottomAnchor.constraint(equalTo: marginGuide.bottomAnchor).isActive = true
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        if let step = step {
            noteLabel.text = step
        }
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
