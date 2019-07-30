//
//  Refresher+Empty.swift
//  AFramework
//
//  Created by abyss on 2019/5/6.
//

import EmptyDataSet_Swift

extension Refresher: EmptyDataSetSource, EmptyDataSetDelegate {
    func handleEmpty() {
        let empty =  (self.slave as! UIScrollView)
        
        empty.emptyDataSetSource = self
        empty.emptyDataSetDelegate = self
    }
    
    public func customView(forEmptyDataSet scrollView: UIScrollView) -> UIView? {

        if let callback = self.emptyCustomCallback {
            return callback(self)
        }

        return nil
    }
    
    public func image(forEmptyDataSet scrollView: UIScrollView) -> UIImage? {
        return self.emptyCallback(self).2
    }
    
    public func backgroundColor(forEmptyDataSet scrollView: UIScrollView) -> UIColor? {
        if let background = self.emptyCallback(self).3 {
            return background
        }
        
        return .app_background
    }
    
    public func verticalOffset(forEmptyDataSet scrollView: UIScrollView) -> CGFloat {
        return -UIScreen.height/5.0
    }
    
    public func title(forEmptyDataSet scrollView: UIScrollView) -> NSAttributedString? {
        if let title = self.emptyCallback(self).0 {
            return NSAttributedString(string: title)
        }
        
        return nil
    }
    
    public func description(forEmptyDataSet scrollView: UIScrollView) -> NSAttributedString? {
        if let description = self.emptyCallback(self).1 {
            return NSAttributedString(string: description)
        }
        
        return nil
    }
    
    public func emptyDataSetShouldDisplay(_ scrollView: UIScrollView) -> Bool {
        return self.evidence.list.count == 0 && self.evidence.used
    }
    
    public func emptyDataSet(_ scrollView: UIScrollView, didTapView view: UIView) {
        self.refresh()
    }
    
    public func emptyDataSetShouldAllowTouch(_ scrollView: UIScrollView) -> Bool {
        return true
    }
}
