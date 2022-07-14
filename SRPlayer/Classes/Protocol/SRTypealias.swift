//
//  SRTypealias.swift
//  SRPlayer
//
//  Created by JunMing on 2022/7/13.
//

import UIKit
import SnapKit

public typealias SRLayout = (_ make: ConstraintMaker, _ view: UIView) -> Void
public typealias SRFinish = () -> Void
public typealias SRVisible = (_ visible: Bool) -> Void
public typealias SREdgeVisible = (_ visible: Bool, _ unit: EdgeAreaUnit) -> Void
public typealias SRUnit = (_ unit: EdgeAreaUnit) -> Void

