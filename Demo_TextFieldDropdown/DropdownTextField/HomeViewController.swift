//
//  HomeViewController.swift
//  DropdownTextField
//
//  Created by Duy Tran N. VN.Danang on 12/24/21.
//

import UIKit

// MARK: HomeViewController
final class HomeViewController: UIViewController, DropDownViewController {

    // MARK: - Configuration
    struct Config {
        static let rowHeight: CGFloat = 80.0
    }

    // MARK: - IBOutlets
    @IBOutlet private weak var tableView: UITableView!

    // MARK: - Properties
    private let viewModel = HomeViewModel()
    lazy var dropDownView: DropDownView = {
        let view: DropDownView = UIView.fromNib()
        view.backgroundColor = UIColor.systemOrange
        tableView.addSubview(view)
        tableView.delegate = self
        return view
    }()

    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "SettingItemCell", bundle: nil), forCellReuseIdentifier: "SettingItemCell")
    }
}

// MARK: - Extension UITableViewDataSource
extension HomeViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SettingItemCell", for: indexPath) as? SettingItemCell ?? SettingItemCell()
        if indexPath.row % 2 == 0 {
            cell.backgroundColor = .systemGray
        } else {
            cell.backgroundColor = .lightGray
        }
        cell.updateView(with: viewModel.viewModelForSettingItemCell(at: indexPath))
        return cell
    }
}

// MARK: - Extension UITableViewDelegate
extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Config.rowHeight
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Get previous index path
        let oldIndexPath = viewModel.currentSelectedIndexPath

        // Update value for current selected
        viewModel.didSelected(indexPath: indexPath)

        // Handle reload old & new rows
        var needReloadIndexPaths: [IndexPath] = [indexPath]
        if let old = oldIndexPath {
            needReloadIndexPaths.append(old)
        }
        tableView.reloadRows(at: needReloadIndexPaths, with: .none)

        guard let cell = tableView.cellForRow(at: indexPath) as? SettingItemCell else { return }

        updateDropDownViewFrame(from: cell, indexPath: indexPath)
    }

    func updateDropDownViewFrame(from cell: DropDownTextFieldCell, indexPath: IndexPath) {
        let tfFrames = cell.getTextFieldFrames()
        let originalFrame = tfFrames.originalFrame
        if let globalFrame = tfFrames.globalFrame {
            let rectOfCell = tableView.rectForRow(at: indexPath)
            let originY = rectOfCell.origin.y + originalFrame.origin.y + originalFrame.size.height
            dropDownView.frame = CGRect(x: globalFrame.origin.x,
                                          y: originY,
                                          width: globalFrame.size.width,
                                          height: viewModel.heightOfDropDownView())
            dropDownView.isHidden = false
            dropDownView.updateView(with: viewModel.viewModelForDropDownView())
        }
    }
}

// MARK: - Extension
extension HomeViewController: DropDownViewDelegate {
    func didSelect(indexPath: IndexPath) {
        print("🍀 \(#function)", indexPath)
    }
}

// MARK: - Drop Down related functions
extension HomeViewController {

}

final class HomeViewModel {

    // MARK: - Properties
    private var items: [String] = Array(0...10).map({ String(describing: "Item \($0)")})
    private var dropDownItems: [String] = Array(0...10).map({ String(describing: "Option \($0)")})
    var currentSelectedIndexPath: IndexPath?

    // MARK: - Public functions
    func numberOfRows() -> Int {
        return items.count
    }

    func viewModelForSettingItemCell(at indexPath: IndexPath) -> SettingItemCellViewModel {
        return SettingItemCellViewModel(title: items[indexPath.row], isDroppedDown: indexPath == currentSelectedIndexPath)
    }

    func viewModelForDropDownView() -> DropDownViewModel {
        return DropDownViewModel(items: dropDownItems)
    }

    func didSelected(indexPath: IndexPath) {
        if currentSelectedIndexPath == indexPath {
            currentSelectedIndexPath = nil
        } else {
            currentSelectedIndexPath = indexPath
        }
    }

    func heightOfDropDownView() -> CGFloat {
        /// Calculate
        let visibleItems = min(4, dropDownItems.count)
        let visibleHeight = CGFloat(visibleItems) * DropDownView.Config.rowHeight
        return visibleHeight
    }
}

protocol DropDownViewController {
    var dropDownView: DropDownView { get set }
    func updateDropDownViewFrame(from cell: DropDownTextFieldCell, indexPath: IndexPath)
}
