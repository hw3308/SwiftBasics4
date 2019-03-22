//
//  RefreshTableView.swift
//  SwiftBasics4
//
//  Created by houwei on 2019/3/21.
//  Copyright © 2019年 侯伟. All rights reserved.
//

import Foundation
import MJRefresh

protocol RefreshTableViewDelegate: class {
    func tableView(tableView: RefreshTableView, refreshDataWithType refreshType: RefreshTableView.RefreshType)
}

open class RefreshTableView: UITableView {
    
    enum RefreshType {
        case Refresh
        case LoadMore
    }
    
    weak var refreshDelegate: RefreshTableViewDelegate?
    
    var pageSize = 10
    
    var reloadIndexSet: IndexSet?
    
    var isShowEmptyView = true

    var emptyViewTitle = "很抱歉，未找到相关的内容"

    var emptyViewImageYOffset:CGFloat = 16.0

    private var emptyNoticeView: NoDataView?
    
    func configRefreshable(refreshEnabled: Bool = false, loadMoreEnabled: Bool = false) {
        if refreshEnabled {
            let header = MJRefreshNormalHeader(refreshingBlock: {
                self.refreshDelegate?.tableView(tableView: self, refreshDataWithType: .Refresh)
            })
            self.mj_header = header
        }
        if loadMoreEnabled {
            let footer = MJRefreshAutoNormalFooter(refreshingBlock: {
                self.refreshDelegate?.tableView(tableView: self, refreshDataWithType: .LoadMore)
            })
            self.mj_footer = footer
        }
    }
    
    func endRefreshing(newNum: Int = 0, total:Int = 0) {
        if let header = self.mj_header {
            header.endRefreshing()
        }
        if let footer = self.mj_footer {
            footer.endRefreshing()
        }
        
        if let reloadIndexSet = self.reloadIndexSet {
            if let _ = self.mj_footer {
                self.reloadData()
            } else {
                self.reloadSections(reloadIndexSet, with: .none)
            }
        } else {
            self.reloadData()
        }
        
        if isShowEmptyView && total == 0 {
            self.showNoDataNoticeView()
        }else{
            self.hideNoDataNoticeView()
        }
    }
    
    func refreshData(refreshType: RefreshType = .Refresh) {
        switch refreshType {
        case .Refresh:
            if let header = self.mj_header {
                header.beginRefreshing()
            }
        case .LoadMore:
            if let footer = self.mj_footer {
                footer.beginRefreshing()
            }
        }
    }
    
    func updateData<T>( data: inout [T], newData: [T], refreshType: RefreshType, endRefreshing: Bool = true) {
        switch refreshType {
        case .Refresh:   data = newData
        case .LoadMore:   data += newData
        }
        if endRefreshing {
            self.endRefreshing(newNum: newData.count, total: data.count)
        }
    }
    
    func pageOffset<T>(refreshType: RefreshType, data: [T]) -> Int {
        switch refreshType {
        case .Refresh:    return 0
        case .LoadMore:   return data.count
        }
    }
    
    func showNoDataNoticeView() {
        
        if emptyNoticeView == nil{
            emptyNoticeView = NoDataView(frame: self.bounds)
            emptyNoticeView?.backgroundColor = UIColor.groupTableViewBackground
        }
        guard let noDataView = emptyNoticeView else { return }
        
        noDataView.refreshBlock = { () in
            self.refreshData(refreshType: .Refresh)
        }
        self.addSubview(noDataView)
    }
    
    func hideNoDataNoticeView() {
        if let view = emptyNoticeView?.superview {
            view.removeFromSuperview()
        }
        emptyNoticeView = nil
    }
}
