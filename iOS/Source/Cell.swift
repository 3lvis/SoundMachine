import UIKit

class Cell: UICollectionViewCell {
    static var reuseIdentifier = String(describing: Cell.self)

    fileprivate lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.text = "👋"
        titleLabel.font = UIFont.systemFont(ofSize: 30)

        return titleLabel
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)

        self.contentView.addSubview(self.titleLabel)
        let inset = CGFloat(20)
        self.titleLabel.fillSuperview(with: UIEdgeInsets(top: inset, left: inset, bottom: inset, right: inset))

        self.backgroundView = UIImageView(image: UIImage(named: "button")!)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    var title: String? {
        didSet {
            self.titleLabel.text = self.title
        }
    }
}
