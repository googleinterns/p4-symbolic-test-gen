; 
(set-info :status unknown)
(declare-fun standard_metadata.ingress_port () (_ BitVec 9))
(assert
 (let (($x46 (= standard_metadata.ingress_port (_ bv1 9))))
 (or (or false (= standard_metadata.ingress_port (_ bv0 9))) $x46)))
(assert
 (let (($x71 (and true (= standard_metadata.ingress_port (concat (_ bv0 8) (_ bv1 1))))))
 (let (($x78 (and true (= standard_metadata.ingress_port (concat (_ bv0 8) (_ bv0 1))))))
 (let ((?x81 (ite $x78 0 (ite $x71 1 (- 1)))))
 (let (($x79 (or (or false $x71) $x78)))
 (and (and (not (or false (not $x79))) $x79) (= ?x81 0)))))))
(check-sat)

; 
(set-info :status unknown)
(declare-fun standard_metadata.ingress_port () (_ BitVec 9))
(assert
 (let (($x46 (= standard_metadata.ingress_port (_ bv1 9))))
 (or (or false (= standard_metadata.ingress_port (_ bv0 9))) $x46)))
(assert
 (let (($x71 (and true (= standard_metadata.ingress_port (concat (_ bv0 8) (_ bv1 1))))))
 (let (($x78 (and true (= standard_metadata.ingress_port (concat (_ bv0 8) (_ bv0 1))))))
 (let ((?x81 (ite $x78 0 (ite $x71 1 (- 1)))))
 (let (($x79 (or (or false $x71) $x78)))
 (and (and (not (or false (not $x79))) $x79) (= ?x81 1)))))))
(check-sat)

