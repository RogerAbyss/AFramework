//
//  Block+Category.swift
//  ProjectName
//
//  Created by abyss on 2019/5/10.
//

import Foundation
import SwiftyJSON

public typealias EventCallback = () -> ()
public typealias EventJSONCallback = (_ json: JSON) -> ()
public typealias EventTagCallback = (_ tag: Int) -> ()
public typealias EventSuccessCallback = (_ success: Bool) -> ()
public typealias EventStringCallback = (_ str: String) -> ()
public typealias EventControllerCallback = (_ model: UIViewController) -> ()
