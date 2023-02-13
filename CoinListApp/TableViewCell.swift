
import UIKit

class TableViewCell: UITableViewCell {

    static let identifier = "cell"
    var coinPrice = "20.000"
    
    let priceLabel: UILabel = {
        let priceLabel = UILabel()
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        return priceLabel
    }()

    let priceChangeLabel: UILabel = {
        let priceChangeLabel = UILabel()
        priceChangeLabel.translatesAutoresizingMaskIntoConstraints = false
        priceChangeLabel.textColor = .white
        priceChangeLabel.textAlignment = .center
        priceChangeLabel.layer.cornerRadius = 20
        priceChangeLabel.layer.masksToBounds = true
        return priceChangeLabel
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configurePriceLabel() {
        contentView.addSubview(priceLabel)
        NSLayoutConstraint.activate([
            priceLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            priceLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5),
            priceLabel.trailingAnchor.constraint(equalTo: priceChangeLabel.leadingAnchor, constant: -20)
        ])
    }
    
    private func configurePriceChangeLabel() {
        contentView.addSubview(priceChangeLabel)
        NSLayoutConstraint.activate([
            priceChangeLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            priceChangeLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            priceChangeLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            priceChangeLabel.widthAnchor.constraint(equalToConstant: 80),
            priceChangeLabel.heightAnchor.constraint(equalToConstant: 10)
        ])
    }
    
    private func setupUI() {
        configurePriceChangeLabel()
        configurePriceLabel()
    }
}
