//
//  TableViewSpy.swift
//  ExampleTests
//
//  Created by Vitor on 04-04-21.
//

import UIKit

class TableViewSpy: UITableView {

    // MARK: - Expectations
    var expectedNumberOfRows = 0

    // MARK: - Called properties
    private(set) var reloadDataCalled = false
    private(set) var reloadSectionsCalled = false
    private(set) var deselectRowCalled = false

    // MARK: - Methods
    override func reloadData() {
        reloadDataCalled = true
    }

    override func reloadSections(_ sections: IndexSet, with animation: UITableView.RowAnimation) {
        reloadSectionsCalled = true
    }
    override func deselectRow(at indexPath: IndexPath, animated: Bool) {
        deselectRowCalled = true
    }
    override func numberOfRows(inSection section: Int) -> Int {
        expectedNumberOfRows
    }
}
