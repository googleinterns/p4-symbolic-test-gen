; 
(set-info :status unknown)
(declare-fun standard_metadata.ingress_port () (_ BitVec 9))
(declare-fun standard_metadata.egress_spec () (_ BitVec 9))
(declare-fun ipv4.dstAddr () (_ BitVec 32))
(declare-fun ipv4.$valid$ () Bool)
(assert
 (let (($x144 (= standard_metadata.ingress_port (_ bv1 9))))
 (or (or false (= standard_metadata.ingress_port (_ bv0 9))) $x144)))
(assert
 (let (($x53 (= ipv4.dstAddr (_ bv168427520 32))))
 (let (($x54 (and true $x53)))
 (let (($x69 (not $x54)))
 (let (($x73 (and $x69 (not (and true (= ((_ extract 31 16) ipv4.dstAddr) ((_ extract 31 16) (_ bv168427520 32))))))))
 (let (($x77 (and $x73 (not (and true (= ((_ extract 31 16) ipv4.dstAddr) ((_ extract 31 16) (_ bv336855040 32))))))))
 (let (($x81 (and $x77 (not (and true (= ((_ extract 31 24) ipv4.dstAddr) ((_ extract 31 24) (_ bv167772160 32))))))))
 (let (($x50 (and true ipv4.$valid$)))
 (let (($x82 (and $x50 $x81)))
 (let ((?x96 (concat (_ bv0 8) (_ bv1 1))))
 (let (($x67 (and true (= ((_ extract 31 24) ipv4.dstAddr) ((_ extract 31 24) (_ bv167772160 32))))))
 (let (($x79 (and (and $x50 $x77) $x67)))
 (let (($x62 (and true (= ((_ extract 31 16) ipv4.dstAddr) ((_ extract 31 16) (_ bv336855040 32))))))
 (let (($x75 (and (and $x50 $x73) $x62)))
 (let ((?x109 (ite $x75 ?x96 (ite $x79 ?x96 (ite $x82 (_ bv455 9) standard_metadata.egress_spec)))))
 (let (($x58 (and true (= ((_ extract 31 16) ipv4.dstAddr) ((_ extract 31 16) (_ bv168427520 32))))))
 (let (($x71 (and (and $x50 $x69) $x58)))
 (let (($x68 (and $x50 $x54)))
 (let ((?x131 (ite $x68 ?x96 (ite $x71 (concat (_ bv0 8) (_ bv0 1)) ?x109))))
 (or (or (= ?x131 (_ bv455 9)) (= ?x131 (_ bv0 9))) (= ?x131 (_ bv1 9))))))))))))))))))))))
(assert
 (let (($x67 (and true (= ((_ extract 31 24) ipv4.dstAddr) ((_ extract 31 24) (_ bv167772160 32))))))
 (let (($x50 (and true ipv4.$valid$)))
 (let ((?x107 (ite (and $x50 (and true (= ((_ extract 31 16) ipv4.dstAddr) ((_ extract 31 16) (_ bv336855040 32))))) 3 (ite (and $x50 $x67) 2 (- 1)))))
 (let ((?x119 (ite (and $x50 (and true (= ((_ extract 31 16) ipv4.dstAddr) ((_ extract 31 16) (_ bv168427520 32))))) 0 ?x107)))
 (let (($x53 (= ipv4.dstAddr (_ bv168427520 32))))
 (let (($x54 (and true $x53)))
 (let (($x68 (and $x50 $x54)))
 (let ((?x138 (ite ipv4.$valid$ (ite $x68 1 ?x119) (- 1))))
 (let (($x137 (ite ipv4.$valid$ $x50 false)))
 (let (($x69 (not $x54)))
 (let (($x73 (and $x69 (not (and true (= ((_ extract 31 16) ipv4.dstAddr) ((_ extract 31 16) (_ bv168427520 32))))))))
 (let (($x77 (and $x73 (not (and true (= ((_ extract 31 16) ipv4.dstAddr) ((_ extract 31 16) (_ bv336855040 32))))))))
 (let (($x82 (and $x50 (and $x77 (not $x67)))))
 (let ((?x96 (concat (_ bv0 8) (_ bv1 1))))
 (let (($x79 (and (and $x50 $x77) $x67)))
 (let (($x62 (and true (= ((_ extract 31 16) ipv4.dstAddr) ((_ extract 31 16) (_ bv336855040 32))))))
 (let (($x75 (and (and $x50 $x73) $x62)))
 (let ((?x109 (ite $x75 ?x96 (ite $x79 ?x96 (ite $x82 (_ bv455 9) standard_metadata.egress_spec)))))
 (let (($x58 (and true (= ((_ extract 31 16) ipv4.dstAddr) ((_ extract 31 16) (_ bv168427520 32))))))
 (let (($x71 (and (and $x50 $x69) $x58)))
 (let ((?x131 (ite $x68 ?x96 (ite $x71 (concat (_ bv0 8) (_ bv0 1)) ?x109))))
 (let (($x49 (= ?x131 (_ bv455 9))))
 (and (and (not $x49) $x137) (= ?x138 (- 1))))))))))))))))))))))))))
(check-sat)

; 
(set-info :status unknown)
(declare-fun standard_metadata.ingress_port () (_ BitVec 9))
(declare-fun standard_metadata.egress_spec () (_ BitVec 9))
(declare-fun ipv4.dstAddr () (_ BitVec 32))
(declare-fun ipv4.$valid$ () Bool)
(assert
 (let (($x144 (= standard_metadata.ingress_port (_ bv1 9))))
 (or (or false (= standard_metadata.ingress_port (_ bv0 9))) $x144)))
(assert
 (let (($x53 (= ipv4.dstAddr (_ bv168427520 32))))
 (let (($x54 (and true $x53)))
 (let (($x69 (not $x54)))
 (let (($x73 (and $x69 (not (and true (= ((_ extract 31 16) ipv4.dstAddr) ((_ extract 31 16) (_ bv168427520 32))))))))
 (let (($x77 (and $x73 (not (and true (= ((_ extract 31 16) ipv4.dstAddr) ((_ extract 31 16) (_ bv336855040 32))))))))
 (let (($x81 (and $x77 (not (and true (= ((_ extract 31 24) ipv4.dstAddr) ((_ extract 31 24) (_ bv167772160 32))))))))
 (let (($x50 (and true ipv4.$valid$)))
 (let (($x82 (and $x50 $x81)))
 (let ((?x96 (concat (_ bv0 8) (_ bv1 1))))
 (let (($x67 (and true (= ((_ extract 31 24) ipv4.dstAddr) ((_ extract 31 24) (_ bv167772160 32))))))
 (let (($x79 (and (and $x50 $x77) $x67)))
 (let (($x62 (and true (= ((_ extract 31 16) ipv4.dstAddr) ((_ extract 31 16) (_ bv336855040 32))))))
 (let (($x75 (and (and $x50 $x73) $x62)))
 (let ((?x109 (ite $x75 ?x96 (ite $x79 ?x96 (ite $x82 (_ bv455 9) standard_metadata.egress_spec)))))
 (let (($x58 (and true (= ((_ extract 31 16) ipv4.dstAddr) ((_ extract 31 16) (_ bv168427520 32))))))
 (let (($x71 (and (and $x50 $x69) $x58)))
 (let (($x68 (and $x50 $x54)))
 (let ((?x131 (ite $x68 ?x96 (ite $x71 (concat (_ bv0 8) (_ bv0 1)) ?x109))))
 (or (or (= ?x131 (_ bv455 9)) (= ?x131 (_ bv0 9))) (= ?x131 (_ bv1 9))))))))))))))))))))))
(assert
 (let (($x67 (and true (= ((_ extract 31 24) ipv4.dstAddr) ((_ extract 31 24) (_ bv167772160 32))))))
 (let (($x50 (and true ipv4.$valid$)))
 (let ((?x107 (ite (and $x50 (and true (= ((_ extract 31 16) ipv4.dstAddr) ((_ extract 31 16) (_ bv336855040 32))))) 3 (ite (and $x50 $x67) 2 (- 1)))))
 (let ((?x119 (ite (and $x50 (and true (= ((_ extract 31 16) ipv4.dstAddr) ((_ extract 31 16) (_ bv168427520 32))))) 0 ?x107)))
 (let (($x53 (= ipv4.dstAddr (_ bv168427520 32))))
 (let (($x54 (and true $x53)))
 (let (($x68 (and $x50 $x54)))
 (let ((?x138 (ite ipv4.$valid$ (ite $x68 1 ?x119) (- 1))))
 (let (($x137 (ite ipv4.$valid$ $x50 false)))
 (let (($x69 (not $x54)))
 (let (($x73 (and $x69 (not (and true (= ((_ extract 31 16) ipv4.dstAddr) ((_ extract 31 16) (_ bv168427520 32))))))))
 (let (($x77 (and $x73 (not (and true (= ((_ extract 31 16) ipv4.dstAddr) ((_ extract 31 16) (_ bv336855040 32))))))))
 (let (($x82 (and $x50 (and $x77 (not $x67)))))
 (let ((?x96 (concat (_ bv0 8) (_ bv1 1))))
 (let (($x79 (and (and $x50 $x77) $x67)))
 (let (($x62 (and true (= ((_ extract 31 16) ipv4.dstAddr) ((_ extract 31 16) (_ bv336855040 32))))))
 (let (($x75 (and (and $x50 $x73) $x62)))
 (let ((?x109 (ite $x75 ?x96 (ite $x79 ?x96 (ite $x82 (_ bv455 9) standard_metadata.egress_spec)))))
 (let (($x58 (and true (= ((_ extract 31 16) ipv4.dstAddr) ((_ extract 31 16) (_ bv168427520 32))))))
 (let (($x71 (and (and $x50 $x69) $x58)))
 (let ((?x131 (ite $x68 ?x96 (ite $x71 (concat (_ bv0 8) (_ bv0 1)) ?x109))))
 (let (($x49 (= ?x131 (_ bv455 9))))
 (let (($x252 (and (not $x49) $x137)))
 (and $x252 (= ?x138 0))))))))))))))))))))))))))
(check-sat)

; 
(set-info :status unknown)
(declare-fun standard_metadata.ingress_port () (_ BitVec 9))
(declare-fun standard_metadata.egress_spec () (_ BitVec 9))
(declare-fun ipv4.dstAddr () (_ BitVec 32))
(declare-fun ipv4.$valid$ () Bool)
(assert
 (let (($x144 (= standard_metadata.ingress_port (_ bv1 9))))
 (or (or false (= standard_metadata.ingress_port (_ bv0 9))) $x144)))
(assert
 (let (($x53 (= ipv4.dstAddr (_ bv168427520 32))))
 (let (($x54 (and true $x53)))
 (let (($x69 (not $x54)))
 (let (($x73 (and $x69 (not (and true (= ((_ extract 31 16) ipv4.dstAddr) ((_ extract 31 16) (_ bv168427520 32))))))))
 (let (($x77 (and $x73 (not (and true (= ((_ extract 31 16) ipv4.dstAddr) ((_ extract 31 16) (_ bv336855040 32))))))))
 (let (($x81 (and $x77 (not (and true (= ((_ extract 31 24) ipv4.dstAddr) ((_ extract 31 24) (_ bv167772160 32))))))))
 (let (($x50 (and true ipv4.$valid$)))
 (let (($x82 (and $x50 $x81)))
 (let ((?x96 (concat (_ bv0 8) (_ bv1 1))))
 (let (($x67 (and true (= ((_ extract 31 24) ipv4.dstAddr) ((_ extract 31 24) (_ bv167772160 32))))))
 (let (($x79 (and (and $x50 $x77) $x67)))
 (let (($x62 (and true (= ((_ extract 31 16) ipv4.dstAddr) ((_ extract 31 16) (_ bv336855040 32))))))
 (let (($x75 (and (and $x50 $x73) $x62)))
 (let ((?x109 (ite $x75 ?x96 (ite $x79 ?x96 (ite $x82 (_ bv455 9) standard_metadata.egress_spec)))))
 (let (($x58 (and true (= ((_ extract 31 16) ipv4.dstAddr) ((_ extract 31 16) (_ bv168427520 32))))))
 (let (($x71 (and (and $x50 $x69) $x58)))
 (let (($x68 (and $x50 $x54)))
 (let ((?x131 (ite $x68 ?x96 (ite $x71 (concat (_ bv0 8) (_ bv0 1)) ?x109))))
 (or (or (= ?x131 (_ bv455 9)) (= ?x131 (_ bv0 9))) (= ?x131 (_ bv1 9))))))))))))))))))))))
(assert
 (let (($x67 (and true (= ((_ extract 31 24) ipv4.dstAddr) ((_ extract 31 24) (_ bv167772160 32))))))
 (let (($x50 (and true ipv4.$valid$)))
 (let ((?x107 (ite (and $x50 (and true (= ((_ extract 31 16) ipv4.dstAddr) ((_ extract 31 16) (_ bv336855040 32))))) 3 (ite (and $x50 $x67) 2 (- 1)))))
 (let ((?x119 (ite (and $x50 (and true (= ((_ extract 31 16) ipv4.dstAddr) ((_ extract 31 16) (_ bv168427520 32))))) 0 ?x107)))
 (let (($x53 (= ipv4.dstAddr (_ bv168427520 32))))
 (let (($x54 (and true $x53)))
 (let (($x68 (and $x50 $x54)))
 (let ((?x138 (ite ipv4.$valid$ (ite $x68 1 ?x119) (- 1))))
 (let (($x137 (ite ipv4.$valid$ $x50 false)))
 (let (($x69 (not $x54)))
 (let (($x73 (and $x69 (not (and true (= ((_ extract 31 16) ipv4.dstAddr) ((_ extract 31 16) (_ bv168427520 32))))))))
 (let (($x77 (and $x73 (not (and true (= ((_ extract 31 16) ipv4.dstAddr) ((_ extract 31 16) (_ bv336855040 32))))))))
 (let (($x82 (and $x50 (and $x77 (not $x67)))))
 (let ((?x96 (concat (_ bv0 8) (_ bv1 1))))
 (let (($x79 (and (and $x50 $x77) $x67)))
 (let (($x62 (and true (= ((_ extract 31 16) ipv4.dstAddr) ((_ extract 31 16) (_ bv336855040 32))))))
 (let (($x75 (and (and $x50 $x73) $x62)))
 (let ((?x109 (ite $x75 ?x96 (ite $x79 ?x96 (ite $x82 (_ bv455 9) standard_metadata.egress_spec)))))
 (let (($x58 (and true (= ((_ extract 31 16) ipv4.dstAddr) ((_ extract 31 16) (_ bv168427520 32))))))
 (let (($x71 (and (and $x50 $x69) $x58)))
 (let ((?x131 (ite $x68 ?x96 (ite $x71 (concat (_ bv0 8) (_ bv0 1)) ?x109))))
 (let (($x49 (= ?x131 (_ bv455 9))))
 (and (and (not $x49) $x137) (= ?x138 1)))))))))))))))))))))))))
(check-sat)

; 
(set-info :status unknown)
(declare-fun standard_metadata.ingress_port () (_ BitVec 9))
(declare-fun standard_metadata.egress_spec () (_ BitVec 9))
(declare-fun ipv4.dstAddr () (_ BitVec 32))
(declare-fun ipv4.$valid$ () Bool)
(assert
 (let (($x144 (= standard_metadata.ingress_port (_ bv1 9))))
 (or (or false (= standard_metadata.ingress_port (_ bv0 9))) $x144)))
(assert
 (let (($x53 (= ipv4.dstAddr (_ bv168427520 32))))
 (let (($x54 (and true $x53)))
 (let (($x69 (not $x54)))
 (let (($x73 (and $x69 (not (and true (= ((_ extract 31 16) ipv4.dstAddr) ((_ extract 31 16) (_ bv168427520 32))))))))
 (let (($x77 (and $x73 (not (and true (= ((_ extract 31 16) ipv4.dstAddr) ((_ extract 31 16) (_ bv336855040 32))))))))
 (let (($x81 (and $x77 (not (and true (= ((_ extract 31 24) ipv4.dstAddr) ((_ extract 31 24) (_ bv167772160 32))))))))
 (let (($x50 (and true ipv4.$valid$)))
 (let (($x82 (and $x50 $x81)))
 (let ((?x96 (concat (_ bv0 8) (_ bv1 1))))
 (let (($x67 (and true (= ((_ extract 31 24) ipv4.dstAddr) ((_ extract 31 24) (_ bv167772160 32))))))
 (let (($x79 (and (and $x50 $x77) $x67)))
 (let (($x62 (and true (= ((_ extract 31 16) ipv4.dstAddr) ((_ extract 31 16) (_ bv336855040 32))))))
 (let (($x75 (and (and $x50 $x73) $x62)))
 (let ((?x109 (ite $x75 ?x96 (ite $x79 ?x96 (ite $x82 (_ bv455 9) standard_metadata.egress_spec)))))
 (let (($x58 (and true (= ((_ extract 31 16) ipv4.dstAddr) ((_ extract 31 16) (_ bv168427520 32))))))
 (let (($x71 (and (and $x50 $x69) $x58)))
 (let (($x68 (and $x50 $x54)))
 (let ((?x131 (ite $x68 ?x96 (ite $x71 (concat (_ bv0 8) (_ bv0 1)) ?x109))))
 (or (or (= ?x131 (_ bv455 9)) (= ?x131 (_ bv0 9))) (= ?x131 (_ bv1 9))))))))))))))))))))))
(assert
 (let (($x67 (and true (= ((_ extract 31 24) ipv4.dstAddr) ((_ extract 31 24) (_ bv167772160 32))))))
 (let (($x50 (and true ipv4.$valid$)))
 (let ((?x107 (ite (and $x50 (and true (= ((_ extract 31 16) ipv4.dstAddr) ((_ extract 31 16) (_ bv336855040 32))))) 3 (ite (and $x50 $x67) 2 (- 1)))))
 (let ((?x119 (ite (and $x50 (and true (= ((_ extract 31 16) ipv4.dstAddr) ((_ extract 31 16) (_ bv168427520 32))))) 0 ?x107)))
 (let (($x53 (= ipv4.dstAddr (_ bv168427520 32))))
 (let (($x54 (and true $x53)))
 (let (($x68 (and $x50 $x54)))
 (let ((?x138 (ite ipv4.$valid$ (ite $x68 1 ?x119) (- 1))))
 (let (($x137 (ite ipv4.$valid$ $x50 false)))
 (let (($x69 (not $x54)))
 (let (($x73 (and $x69 (not (and true (= ((_ extract 31 16) ipv4.dstAddr) ((_ extract 31 16) (_ bv168427520 32))))))))
 (let (($x77 (and $x73 (not (and true (= ((_ extract 31 16) ipv4.dstAddr) ((_ extract 31 16) (_ bv336855040 32))))))))
 (let (($x82 (and $x50 (and $x77 (not $x67)))))
 (let ((?x96 (concat (_ bv0 8) (_ bv1 1))))
 (let (($x79 (and (and $x50 $x77) $x67)))
 (let (($x62 (and true (= ((_ extract 31 16) ipv4.dstAddr) ((_ extract 31 16) (_ bv336855040 32))))))
 (let (($x75 (and (and $x50 $x73) $x62)))
 (let ((?x109 (ite $x75 ?x96 (ite $x79 ?x96 (ite $x82 (_ bv455 9) standard_metadata.egress_spec)))))
 (let (($x58 (and true (= ((_ extract 31 16) ipv4.dstAddr) ((_ extract 31 16) (_ bv168427520 32))))))
 (let (($x71 (and (and $x50 $x69) $x58)))
 (let ((?x131 (ite $x68 ?x96 (ite $x71 (concat (_ bv0 8) (_ bv0 1)) ?x109))))
 (let (($x49 (= ?x131 (_ bv455 9))))
 (and (and (not $x49) $x137) (= ?x138 2)))))))))))))))))))))))))
(check-sat)

; 
(set-info :status unknown)
(declare-fun standard_metadata.ingress_port () (_ BitVec 9))
(declare-fun standard_metadata.egress_spec () (_ BitVec 9))
(declare-fun ipv4.dstAddr () (_ BitVec 32))
(declare-fun ipv4.$valid$ () Bool)
(assert
 (let (($x144 (= standard_metadata.ingress_port (_ bv1 9))))
 (or (or false (= standard_metadata.ingress_port (_ bv0 9))) $x144)))
(assert
 (let (($x53 (= ipv4.dstAddr (_ bv168427520 32))))
 (let (($x54 (and true $x53)))
 (let (($x69 (not $x54)))
 (let (($x73 (and $x69 (not (and true (= ((_ extract 31 16) ipv4.dstAddr) ((_ extract 31 16) (_ bv168427520 32))))))))
 (let (($x77 (and $x73 (not (and true (= ((_ extract 31 16) ipv4.dstAddr) ((_ extract 31 16) (_ bv336855040 32))))))))
 (let (($x81 (and $x77 (not (and true (= ((_ extract 31 24) ipv4.dstAddr) ((_ extract 31 24) (_ bv167772160 32))))))))
 (let (($x50 (and true ipv4.$valid$)))
 (let (($x82 (and $x50 $x81)))
 (let ((?x96 (concat (_ bv0 8) (_ bv1 1))))
 (let (($x67 (and true (= ((_ extract 31 24) ipv4.dstAddr) ((_ extract 31 24) (_ bv167772160 32))))))
 (let (($x79 (and (and $x50 $x77) $x67)))
 (let (($x62 (and true (= ((_ extract 31 16) ipv4.dstAddr) ((_ extract 31 16) (_ bv336855040 32))))))
 (let (($x75 (and (and $x50 $x73) $x62)))
 (let ((?x109 (ite $x75 ?x96 (ite $x79 ?x96 (ite $x82 (_ bv455 9) standard_metadata.egress_spec)))))
 (let (($x58 (and true (= ((_ extract 31 16) ipv4.dstAddr) ((_ extract 31 16) (_ bv168427520 32))))))
 (let (($x71 (and (and $x50 $x69) $x58)))
 (let (($x68 (and $x50 $x54)))
 (let ((?x131 (ite $x68 ?x96 (ite $x71 (concat (_ bv0 8) (_ bv0 1)) ?x109))))
 (or (or (= ?x131 (_ bv455 9)) (= ?x131 (_ bv0 9))) (= ?x131 (_ bv1 9))))))))))))))))))))))
(assert
 (let (($x67 (and true (= ((_ extract 31 24) ipv4.dstAddr) ((_ extract 31 24) (_ bv167772160 32))))))
 (let (($x50 (and true ipv4.$valid$)))
 (let ((?x107 (ite (and $x50 (and true (= ((_ extract 31 16) ipv4.dstAddr) ((_ extract 31 16) (_ bv336855040 32))))) 3 (ite (and $x50 $x67) 2 (- 1)))))
 (let ((?x119 (ite (and $x50 (and true (= ((_ extract 31 16) ipv4.dstAddr) ((_ extract 31 16) (_ bv168427520 32))))) 0 ?x107)))
 (let (($x53 (= ipv4.dstAddr (_ bv168427520 32))))
 (let (($x54 (and true $x53)))
 (let (($x68 (and $x50 $x54)))
 (let ((?x138 (ite ipv4.$valid$ (ite $x68 1 ?x119) (- 1))))
 (let (($x137 (ite ipv4.$valid$ $x50 false)))
 (let (($x69 (not $x54)))
 (let (($x73 (and $x69 (not (and true (= ((_ extract 31 16) ipv4.dstAddr) ((_ extract 31 16) (_ bv168427520 32))))))))
 (let (($x77 (and $x73 (not (and true (= ((_ extract 31 16) ipv4.dstAddr) ((_ extract 31 16) (_ bv336855040 32))))))))
 (let (($x82 (and $x50 (and $x77 (not $x67)))))
 (let ((?x96 (concat (_ bv0 8) (_ bv1 1))))
 (let (($x79 (and (and $x50 $x77) $x67)))
 (let (($x62 (and true (= ((_ extract 31 16) ipv4.dstAddr) ((_ extract 31 16) (_ bv336855040 32))))))
 (let (($x75 (and (and $x50 $x73) $x62)))
 (let ((?x109 (ite $x75 ?x96 (ite $x79 ?x96 (ite $x82 (_ bv455 9) standard_metadata.egress_spec)))))
 (let (($x58 (and true (= ((_ extract 31 16) ipv4.dstAddr) ((_ extract 31 16) (_ bv168427520 32))))))
 (let (($x71 (and (and $x50 $x69) $x58)))
 (let ((?x131 (ite $x68 ?x96 (ite $x71 (concat (_ bv0 8) (_ bv0 1)) ?x109))))
 (let (($x49 (= ?x131 (_ bv455 9))))
 (and (and (not $x49) $x137) (= ?x138 3)))))))))))))))))))))))))
(check-sat)

