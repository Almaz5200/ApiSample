//
//  SavedChecksViewController.swift
//  ApiSample
//
//  Created by Artem Trubacheev on 09/03/2019.
//  Copyright © 2019 atrubacheev. All rights reserved.
//

import UIKit
import RxSwift
import RxDataSources
import RealmSwift
import SVPullToRefresh

class SavedChecksViewController: BaseViewController {

    var output: SavedChecksViewOutput!

    @IBOutlet weak var tableView: UITableView!
    
    var displayedChecks: Variable<[Check]>? {
        didSet {
            updateTable()
        }
    }
    
    typealias ChecksSection = AnimatableSectionModel<Int, Check>
    
    // MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        output.viewInited()
        tableView.addInfiniteScrolling {
            self.output.tableViewEndReached()
        }
        tableView.rx.modelDeleted(Check.self).subscribe { (event) in
            guard let check = event.element, let row = self.displayedChecks?.value.firstIndex(of: check) else { return }
            self.output.deleteActionFor(check: check)
        }
        .disposed(by: disposeBag)
        
        let dataSrc = RxTableViewSectionedAnimatedDataSource<ChecksSection>(
            animationConfiguration: AnimationConfiguration(insertAnimation: .top,
                                                           reloadAnimation: .fade,
                                                           deleteAnimation: .left),
            configureCell: { (dataSource, table, indexPath, item) in
                let cell = table.dequeueReusableCell(withIdentifier: "SavedCheckCell", for: indexPath) as! SavedCheckCell
                cell.setup(check: item)
                return cell
        },
            titleForHeaderInSection: { (ds, section) -> String? in
                return nil
        },
            canEditRowAtIndexPath: { _, _ in
                return true
        },
            canMoveRowAtIndexPath: { _, _ in
                return true
        })
        
        displayedChecks?.asObservable()
            .map({ [ChecksSection(model: 0, items: $0)] })
        .bind(to: tableView.rx.items(dataSource: dataSrc))
        tableView.tableFooterView = nil
        updateTable()
    }
    
    func updateTable() {
        if displayedChecks?.value.count == 0 || displayedChecks == nil {
            tableView.isHidden = true
            return
        } else {
            tableView.isHidden = false
        }
    }
}

extension SavedChecksViewController: SavedChecksViewInput {
    func showChecks(checks: [Check]) {
        guard displayedChecks != nil else {
            displayedChecks = Variable(checks)
            return
        }
        displayedChecks?.value += checks
        tableView.infiniteScrollingView.stopAnimating()
    }
    
    func disableInfiniteScrolling() {
        tableView.showsInfiniteScrolling = false
    }
    
    func checkDeleted(check: Check) {
        guard let row = self.displayedChecks?.value.firstIndex(of: check) else { return }
        self.displayedChecks?.value.remove(at: row)
        //tableView.deleteRows(at: [IndexPath(row: row, section: 0)], with: .fade)
        self.updateTable()
    }
}
