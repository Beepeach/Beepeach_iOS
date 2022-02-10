//
//  Why.swift
//  SideMenu
//
//  Created by JunHeeJo on 2/10/22.
//

import Foundation

// 이건 왜 에러가 날까..?
/*
    [weak self] in
    guard  let strongSelf = self,
           let vc = self?.settingsVC else {
        return
    }
    self?.addChild(vc)
    self?.homeNavC.view.addSubview(vc.view)
    vc.didMove(toParent: strongSelf)
*/
