//
//  DropDownView.swift
//  DropdownTextField
//
//  Created by Duy Tran N. VN.Danang on 12/25/21.
//

import UIKit

protocol DropDownViewDelegate: class {
    func didSelect(indexPath: IndexPath)
}

final class DropDownView: UIView {

    struct Config {
        static let rowHeight: CGFloat = 40

        /// Maximum visible items display in screen (extra items will be scrollable)
        static let visibleItemCount: Int = 4
    }

    // MARK: - IBOutlets
    @IBOutlet private weak var tableView: UITableView!

    // MARK: - Properties
    private var viewModel = DropDownViewModel()
    weak var delegate: DropDownViewDelegate?

    // MARK: - Life cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "DropDownCell")
    }

    // MARK: - Public functions
    func updateView(with viewModel: DropDownViewModel) {
        self.viewModel = viewModel
        tableView.setContentOffset(.zero, animated: false)
        tableView.reloadData()
    }
}

// MARK: - Extension UITableViewDataSource
extension DropDownView: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "DropDownCell") else { return UITableViewCell() }
        cell.textLabel?.text = viewModel.titleForRow(at: indexPath)
        cell.backgroundColor = .systemOrange
        return cell
    }
}

// MARK: - Extension UITableViewDelegate
extension DropDownView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Config.rowHeight
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.didSelect(indexPath: indexPath)
    }
}

// MARK: DropDownViewModel
struct DropDownViewModel {

    private var items: [String]

    init(items: [String] = []) {
        self.items = items
    }

    func numberOfRows() -> Int {
        return items.count
    }

    func titleForRow(at indexPath: IndexPath) -> String {
        return items[indexPath.row]
    }
}
