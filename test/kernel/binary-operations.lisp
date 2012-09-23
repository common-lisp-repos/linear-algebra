#|

 Linear Algebra in Common Lisp Unit Tests

 Copyright (c) 2011-2012, Odonata Research LLC
 All rights reserved.

 Redistribution and  use  in  source  and  binary  forms, with or without
 modification, are permitted  provided  that the following conditions are
 met:

   o  Redistributions of  source  code  must  retain  the above copyright
      notice, this list of conditions and the following disclaimer.
   o  Redistributions in binary  form  must reproduce the above copyright
      notice, this list of  conditions  and  the  following disclaimer in
      the  documentation  and/or   other   materials  provided  with  the
      distribution.
   o  The names of the contributors may not be used to endorse or promote
      products derived from this software without  specific prior written
      permission.

 THIS SOFTWARE IS  PROVIDED  BY  THE  COPYRIGHT  HOLDERS AND CONTRIBUTORS
 "AS IS"  AND  ANY  EXPRESS  OR  IMPLIED  WARRANTIES, INCLUDING,  BUT NOT
 LIMITED TO, THE IMPLIED WARRANTIES  OF MERCHANTABILITY AND FITNESS FOR A
 PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER
 OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
 EXEMPLARY, OR  CONSEQUENTIAL  DAMAGES  (INCLUDING,  BUT  NOT LIMITED TO,
 PROCUREMENT OF  SUBSTITUTE  GOODS  OR  SERVICES;  LOSS  OF USE, DATA, OR
 PROFITS; OR BUSINESS INTERRUPTION)  HOWEVER  CAUSED AND ON ANY THEORY OF
 LIABILITY, WHETHER  IN  CONTRACT,  STRICT  LIABILITY, OR TORT (INCLUDING
 NEGLIGENCE OR  OTHERWISE)  ARISING  IN  ANY  WAY  OUT OF THE USE OF THIS
 SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

|#

(in-package :linear-algebra-test)

;;; Scaled binary operations

(define-test scaled-binary-op
  ;; No scalars
  (assert-float-equal
   2.2
   (funcall
    (linear-algebra-kernel:scaled-binary-op
     #'+ nil nil)
    1.1 1.1))
  (assert-float-equal
   1.1
   (funcall
    (linear-algebra-kernel:scaled-binary-op
     #'- nil nil)
    2.2 1.1))
  ;; Scalar 1
  (assert-float-equal
   3.3
   (funcall
    (linear-algebra-kernel:scaled-binary-op
     #'+ 2.0 nil)
    1.1 1.1))
  (assert-float-equal
   1.1
   (funcall
    (linear-algebra-kernel:scaled-binary-op
     #'- 2.0 nil)
    1.1 1.1))
  ;; Scalar 2
  (assert-float-equal
   3.3
   (funcall
    (linear-algebra-kernel:scaled-binary-op
     #'+ nil 2.0)
    1.1 1.1))
  (assert-float-equal
   1.1
   (funcall
    (linear-algebra-kernel:scaled-binary-op
     #'- nil 2.0)
    3.3 1.1))
  ;; Scalar 1 & 2
  (assert-float-equal
   5.5
   (funcall
    (linear-algebra-kernel:scaled-binary-op
     #'+ 2.0 3.0)
    1.1 1.1))
  (assert-float-equal
   1.1
   (funcall
    (linear-algebra-kernel:scaled-binary-op
     #'- 2.0 3.0)
    2.2 1.1)))

;;; Binary vector operations

(define-test %vector<-vector1-op-vector2
  ;; Real addition
  (let ((vector1 #(1.1 2.2 3.3 4.4))
        (vector2 #(1.1 2.2 3.3 4.4)))
    (assert-float-equal
     #(2.2 4.4 6.6 8.8)
     (linear-algebra-kernel::%vector<-vector1-op-vector2
      #'+ vector1 vector2))
    (assert-float-equal
     #(3.3 6.6 9.9 13.2)
     (linear-algebra-kernel::%vector<-vector1-op-vector2
      (lambda (n1 n2) (+ (* 2.0 n1) n2))
      vector1 vector2))
    (assert-float-equal
     #(3.3 6.6 9.9 13.2)
     (linear-algebra-kernel::%vector<-vector1-op-vector2
      (lambda (n1 n2) (+ n1 (* 2.0 n2)))
      vector1 vector2))
    (assert-float-equal
     #(4.4 8.8 13.2 17.6)
     (linear-algebra-kernel::%vector<-vector1-op-vector2
      (lambda (n1 n2) (+ (* 2.0 n1) (* 2.0 n2)))
      vector1 vector2)))
  ;; Complex addition
  (let ((vector1 #(#C(1.1 2.2) #C(3.3 4.4)))
        (vector2 #(#C(1.1 2.2) #C(3.3 4.4))))
    (assert-float-equal
     #(#C(2.2 4.4) #C(6.6 8.8))
     (linear-algebra-kernel::%vector<-vector1-op-vector2
      #'+ vector1 vector2))
    (assert-float-equal
     #(#C(3.3 6.6) #C(9.9 13.2))
     (linear-algebra-kernel::%vector<-vector1-op-vector2
      (lambda (n1 n2) (+ (* 2.0 n1) n2))
      vector1 vector2))
    (assert-float-equal
     #(#C(3.3 6.6) #C(9.9 13.2))
     (linear-algebra-kernel::%vector<-vector1-op-vector2
      (lambda (n1 n2) (+ n1 (* 2.0 n2)))
      vector1 vector2))
    (assert-float-equal
     #(#C(4.4 8.8) #C(13.2 17.6))
     (linear-algebra-kernel::%vector<-vector1-op-vector2
      (lambda (n1 n2) (+ (* 2.0 n1) (* 2.0 n2)))
      vector1 vector2)))
  ;; Real subtraction
  (let ((vector1 #(1.1 2.2 3.3 4.4))
        (vector2 #(1.1 2.2 3.3 4.4)))
    (assert-float-equal
     #(0.0 0.0 0.0 0.0)
     (linear-algebra-kernel::%vector<-vector1-op-vector2
      #'- vector1 vector2))
    (assert-float-equal
     #(1.1 2.2 3.3 4.4)
     (linear-algebra-kernel::%vector<-vector1-op-vector2
      (lambda (n1 n2) (- (* 2.0 n1) n2))
      vector1 vector2))
    (assert-float-equal
     #(-1.1 -2.2 -3.3 -4.4)
     (linear-algebra-kernel::%vector<-vector1-op-vector2
      (lambda (n1 n2) (- n1 (* 2.0 n2)))
      vector1 vector2))
    (assert-float-equal
     #(0.0 0.0 0.0 0.0)
     (linear-algebra-kernel::%vector<-vector1-op-vector2
      (lambda (n1 n2) (- (* 2.0 n1) (* 2.0 n2)))
      vector1 vector2)))
  ;; Complex subtraction
  (let ((vector1 #(#C(1.1 2.2) #C(3.3 4.4)))
        (vector2 #(#C(1.1 2.2) #C(3.3 4.4))))
    (assert-float-equal
     #(#C(0.0 0.0) #C(0.0 0.0))
     (linear-algebra-kernel::%vector<-vector1-op-vector2
      #'- vector1 vector2))
    (assert-float-equal
     #(#C(1.1 2.2) #C(3.3 4.4))
     (linear-algebra-kernel::%vector<-vector1-op-vector2
      (lambda (n1 n2) (- (* 2.0 n1) n2))
      vector1 vector2))
    (assert-float-equal
     #(#C(-1.1 -2.2) #C(-3.3 -4.4))
     (linear-algebra-kernel::%vector<-vector1-op-vector2
      (lambda (n1 n2) (- n1 (* 2.0 n2)))
      vector1 vector2))
    (assert-float-equal
     #(#C(0.0 0.0) #C(0.0 0.0))
     (linear-algebra-kernel::%vector<-vector1-op-vector2
      (lambda (n1 n2) (- (* 2.0 n1) (* 2.0 n2)))
      vector1 vector2))))

(define-test %vector1<-vector1-op-vector2
  ;; Real addition
  (let ((vector1 (vector 1.1 2.2 3.3 4.4))
        (vector2 (vector 1.1 2.2 3.3 4.4)))
    (assert-eq
     vector1
     (linear-algebra-kernel::%vector1<-vector1-op-vector2
      #'+ vector1 vector2))
    (assert-float-equal #(2.2 4.4 6.6 8.8) vector1)
    (assert-float-equal
     #(4.4 8.8 13.2 17.6)
     (linear-algebra-kernel::%vector1<-vector1-op-vector2
      (lambda (n1 n2) (+ n1 (* 2.0 n2)))
      vector1 vector2))
    (assert-float-equal
     #(9.9 19.8 29.7 39.6)
     (linear-algebra-kernel::%vector1<-vector1-op-vector2
      (lambda (n1 n2) (+ (* 2.0 n1) n2))
      vector1 vector2))
    (assert-float-equal
     #(22.0 44.0 66.0 88.0)
     (linear-algebra-kernel::%vector1<-vector1-op-vector2
      (lambda (n1 n2) (+ (* 2.0 n1) (* 2.0 n2)))
      vector1 vector2)))
  ;; Complex addition
  (let ((vector1 (vector #C(1.1 2.2) #C(3.3 4.4)))
        (vector2 (vector #C(1.1 2.2) #C(3.3 4.4))))
    (assert-eq
     vector1
     (linear-algebra-kernel::%vector1<-vector1-op-vector2
      #'+ vector1 vector2))
    (assert-float-equal #(#C(2.2 4.4) #C(6.6 8.8)) vector1)
    (assert-float-equal
     #(#C(4.4 8.8) #C(13.2 17.6))
     (linear-algebra-kernel::%vector1<-vector1-op-vector2
      (lambda (n1 n2) (+ n1 (* 2.0 n2)))
      vector1 vector2))
    (assert-float-equal
     #(#C(9.9 19.8) #C(29.7 39.6))
     (linear-algebra-kernel::%vector1<-vector1-op-vector2
      (lambda (n1 n2) (+ (* 2.0 n1) n2))
      vector1 vector2))
    (assert-float-equal
     #(#C(22.0 44.0) #C(66.0 88.0))
     (linear-algebra-kernel::%vector1<-vector1-op-vector2
      (lambda (n1 n2) (+ (* 2.0 n1) (* 2.0 n2)))
      vector1 vector2)))
  ;; Real subtraction
  (let ((vector1 (vector 1.1 2.2 3.3 4.4))
        (vector2 (vector 1.1 2.2 3.3 4.4)))
    (assert-eq
     vector1
     (linear-algebra-kernel::%vector1<-vector1-op-vector2
      #'- vector1 vector2))
    (assert-float-equal #(0.0 0.0 0.0 0.0) vector1)
    (assert-float-equal
     #(-2.2 -4.4 -6.6 -8.8)
     (linear-algebra-kernel::%vector1<-vector1-op-vector2
      (lambda (n1 n2) (- n1 (* 2.0 n2)))
      vector1 vector2))
    (assert-float-equal
     #(-5.5 -11.0 -16.5 -22.0)
     (linear-algebra-kernel::%vector1<-vector1-op-vector2
      (lambda (n1 n2) (- (* 2.0 n1) n2))
      vector1 vector2))
    (assert-float-equal
     #(-13.2 -26.4 -39.6 -52.8)
     (linear-algebra-kernel::%vector1<-vector1-op-vector2
      (lambda (n1 n2) (- (* 2.0 n1) (* 2.0 n2)))
      vector1 vector2)))
  ;; Complex subtraction
  (let ((vector1 (vector #C(1.1 2.2) #C(3.3 4.4)))
        (vector2 (vector #C(1.1 2.2) #C(3.3 4.4))))
    (assert-eq
     vector1
     (linear-algebra-kernel::%vector1<-vector1-op-vector2
      #'- vector1 vector2))
    (assert-float-equal
     #(#C(0.0 0.0) #C(0.0 0.0)) vector1)
    (assert-float-equal
     #(#C(-2.2 -4.4) #C(-6.6 -8.8))
     (linear-algebra-kernel::%vector1<-vector1-op-vector2
      (lambda (n1 n2) (- n1 (* 2.0 n2)))
      vector1 vector2))
    (assert-float-equal
     #(#C(-5.5 -11.0) #C(-16.5 -22.0))
     (linear-algebra-kernel::%vector1<-vector1-op-vector2
      (lambda (n1 n2) (- (* 2.0 n1) n2))
      vector1 vector2))
    (assert-float-equal
     #(#C(-13.2 -26.4) #C(-39.6 -52.8))
     (linear-algebra-kernel::%vector1<-vector1-op-vector2
      (lambda (n1 n2) (- (* 2.0 n1) (* 2.0 n2)))
      vector1 vector2))))

;;; Vector binary operations unit tests

(define-test binop-add-vector
  ;; Real
  (let ((vector1 #(1.1 2.2 3.3 4.4))
        (vector2 #(1.1 2.2 3.3 4.4)))
    (assert-float-equal
     #(2.2 4.4 6.6 8.8)
     (linear-algebra-kernel:add-vector
      vector1 vector2 nil nil))
    (assert-float-equal
     #(3.3 6.6 9.9 13.2)
     (linear-algebra-kernel:add-vector
      vector1 vector2 2.0 nil))
    (assert-float-equal
     #(3.3 6.6 9.9 13.2)
     (linear-algebra-kernel:add-vector
      vector1 vector2 nil 2.0))
    (assert-float-equal
     #(4.4 8.8 13.2 17.6)
     (linear-algebra-kernel:add-vector
      vector1 vector2 2.0 2.0)))
  ;; Complex
  (let ((vector1 #(#C(1.1 2.2) #C(3.3 4.4)))
        (vector2 #(#C(1.1 2.2) #C(3.3 4.4))))
    (assert-float-equal
     #(#C(2.2 4.4) #C(6.6 8.8))
     (linear-algebra-kernel:add-vector
      vector1 vector2 nil nil))
    (assert-float-equal
     #(#C(3.3 6.6) #C(9.9 13.2))
     (linear-algebra-kernel:add-vector
      vector1 vector2 2.0 nil))
    (assert-float-equal
     #(#C(3.3 6.6) #C(9.9 13.2))
     (linear-algebra-kernel:add-vector
      vector1 vector2 nil 2.0))
    (assert-float-equal
     #(#C(4.4 8.8) #C(13.2 17.6))
     (linear-algebra-kernel:add-vector
      vector1 vector2 2.0 2.0))))

;;; Destructive vector addition

(define-test binop-nadd-vector
  ;; Real
  (let ((vector1 (vector 1.1 2.2 3.3 4.4))
        (vector2 (vector 1.1 2.2 3.3 4.4)))
    (assert-eq
     vector1
     (linear-algebra-kernel:nadd-vector
      vector1 vector2 nil nil))
    (assert-float-equal #(2.2 4.4 6.6 8.8) vector1)
    (assert-float-equal
     #(4.4 8.8 13.2 17.6)
     (linear-algebra-kernel:nadd-vector
      vector1 vector2 nil 2.0))
    (assert-float-equal
     #(9.9 19.8 29.7 39.6)
     (linear-algebra-kernel:nadd-vector
      vector1 vector2 2.0 nil))
    (assert-float-equal
     #(22.0 44.0 66.0 88.0)
     (linear-algebra-kernel:nadd-vector
      vector1 vector2 2.0 2.0)))
  ;; Complex
  (let ((vector1 (vector #C(1.1 2.2) #C(3.3 4.4)))
        (vector2 (vector #C(1.1 2.2) #C(3.3 4.4))))
    (assert-eq
     vector1
     (linear-algebra-kernel:nadd-vector
      vector1 vector2 nil nil))
    (assert-float-equal #(#C(2.2 4.4) #C(6.6 8.8)) vector1)
    (assert-float-equal
     #(#C(4.4 8.8) #C(13.2 17.6))
     (linear-algebra-kernel:nadd-vector
      vector1 vector2 nil 2.0))
    (assert-float-equal
     #(#C(9.9 19.8) #C(29.7 39.6))
     (linear-algebra-kernel:nadd-vector
      vector1 vector2 2.0 nil))
    (assert-float-equal
     #(#C(22.0 44.0) #C(66.0 88.0))
     (linear-algebra-kernel:nadd-vector
      vector1 vector2 2.0 2.0))))

;;; Vector subtraction

(define-test binop-subtract-vector
  ;; Real
  (let ((vector1 #(1.1 2.2 3.3 4.4))
        (vector2 #(1.1 2.2 3.3 4.4)))
    (assert-float-equal
     #(0.0 0.0 0.0 0.0)
     (linear-algebra-kernel:subtract-vector
      vector1 vector2 nil nil))
    (assert-float-equal
     #(1.1 2.2 3.3 4.4)
     (linear-algebra-kernel:subtract-vector
      vector1 vector2 2.0 nil))
    (assert-float-equal
     #(-1.1 -2.2 -3.3 -4.4)
     (linear-algebra-kernel:subtract-vector
      vector1 vector2 nil 2.0))
    (assert-float-equal
     #(0.0 0.0 0.0 0.0)
     (linear-algebra-kernel:subtract-vector
      vector1 vector2 2.0 2.0)))
  ;; Complex
  (let ((vector1 #(#C(1.1 2.2) #C(3.3 4.4)))
        (vector2 #(#C(1.1 2.2) #C(3.3 4.4))))
    (assert-float-equal
     #(#C(0.0 0.0) #C(0.0 0.0))
     (linear-algebra-kernel:subtract-vector
      vector1 vector2 nil nil))
    (assert-float-equal
     #(#C(1.1 2.2) #C(3.3 4.4))
     (linear-algebra-kernel:subtract-vector
      vector1 vector2 2.0 nil))
    (assert-float-equal
     #(#C(-1.1 -2.2) #C(-3.3 -4.4))
     (linear-algebra-kernel:subtract-vector
      vector1 vector2 nil 2.0))
    (assert-float-equal
     #(#C(0.0 0.0) #C(0.0 0.0))
     (linear-algebra-kernel:subtract-vector
      vector1 vector2 2.0 2.0))))

;;; Destructive vector subtraction

(define-test binop-nsubtract-vector
  ;; Real
  (let ((vector1 (vector 1.1 2.2 3.3 4.4))
        (vector2 (vector 1.1 2.2 3.3 4.4)))
    (assert-eq
     vector1
     (linear-algebra-kernel:nsubtract-vector
      vector1 vector2 nil nil))
    (assert-float-equal #(0.0 0.0 0.0 0.0) vector1)
    (assert-float-equal
     #(-2.2 -4.4 -6.6 -8.8)
     (linear-algebra-kernel:nsubtract-vector
      vector1 vector2 nil 2.0))
    (assert-float-equal
     #(-5.5 -11.0 -16.5 -22.0)
     (linear-algebra-kernel:nsubtract-vector
      vector1 vector2 2.0 nil))
    (assert-float-equal
     #(-13.2 -26.4 -39.6 -52.8)
     (linear-algebra-kernel:nsubtract-vector
      vector1 vector2 2.0 2.0)))
  ;; Complex
  (let ((vector1 (vector #C(1.1 2.2) #C(3.3 4.4)))
        (vector2 (vector #C(1.1 2.2) #C(3.3 4.4))))
    (assert-eq
     vector1
     (linear-algebra-kernel:nsubtract-vector
      vector1 vector2 nil nil))
    (assert-float-equal
     #(#C(0.0 0.0) #C(0.0 0.0)) vector1)
    (assert-float-equal
     #(#C(-2.2 -4.4) #C(-6.6 -8.8))
     (linear-algebra-kernel:nsubtract-vector
      vector1 vector2 nil 2.0))
    (assert-float-equal
     #(#C(-5.5 -11.0) #C(-16.5 -22.0))
     (linear-algebra-kernel:nsubtract-vector
      vector1 vector2 2.0 nil))
    (assert-float-equal
     #(#C(-13.2 -26.4) #C(-39.6 -52.8))
     (linear-algebra-kernel:nsubtract-vector
      vector1 vector2 2.0 2.0))))

;;; Vector inner product

(define-test binop-inner-product-vector
  ;; Real vectors
  (assert-rational-equal
   55
   (linear-algebra-kernel:inner-product-vector
    #(1 2 3 4 5) #(1 2 3 4 5) nil nil))
  (assert-float-equal
   55F0
   (linear-algebra-kernel:inner-product-vector
    #(1.0 2.0 3.0 4.0 5.0)
    #(1.0 2.0 3.0 4.0 5.0)
    nil nil))
  (assert-float-equal
   55D0
   (linear-algebra-kernel:inner-product-vector
    #(1D0 2D0 3D0 4D0 5D0)
    #(1D0 2D0 3D0 4D0 5D0)
    nil nil))
  ;; Real vectors with conjugate keyword
  (assert-rational-equal
   55
   (linear-algebra-kernel:inner-product-vector
    #(1 2 3 4 5) #(1 2 3 4 5) nil t))
  ;; Complex vectors
  (assert-rational-equal
   #C(8 18)
   (linear-algebra-kernel:inner-product-vector
    #(#C(1 1) #C(2 1) #C(3 1))
    #(#C(1 2) #C(2 2) #C(3 2))
    nil nil))
  (assert-float-equal
   #C(8.0 18.0)
   (linear-algebra-kernel:inner-product-vector
    #(#C(1.0 1.0) #C(2.0 1.0) #C(3.0 1.0))
    #(#C(1.0 2.0) #C(2.0 2.0) #C(3.0 2.0))
    nil nil))
  (assert-float-equal
   #C(8D0 18D0)
   (linear-algebra-kernel:inner-product-vector
    #(#C(1D0 1D0) #C(2D0 1D0) #C(3D0 1D0))
    #(#C(1D0 2D0) #C(2D0 2D0) #C(3D0 2D0))
    nil nil))
  ;; Complex conjugate
  (assert-rational-equal
   #C(20 6)
   (linear-algebra-kernel:inner-product-vector
    #(#C(1 1) #C(2 1) #C(3 1))
    #(#C(1 2) #C(2 2) #C(3 2))
    nil t))
  (assert-float-equal
   #C(20.0 6.0)
   (linear-algebra-kernel:inner-product-vector
    #(#C(1.0 1.0) #C(2.0 1.0) #C(3.0 1.0))
    #(#C(1.0 2.0) #C(2.0 2.0) #C(3.0 2.0))
    nil t))
  (assert-float-equal
   #C(20D0 6D0)
   (linear-algebra-kernel:inner-product-vector
    #(#C(1D0 1D0) #C(2D0 1D0) #C(3D0 1D0))
    #(#C(1D0 2D0) #C(2D0 2D0) #C(3D0 2D0))
    nil t)))

;;; Binary array/vector operations

(define-test %product-vector-array
  ;; Vector - array
  (assert-float-equal
   #(15.0 30.0 45.0)
   (linear-algebra-kernel::%right-product-vector
    #(1.0 2.0 3.0 4.0 5.0)
    #2A((1.0 2.0 3.0)
        (1.0 2.0 3.0)
        (1.0 2.0 3.0)
        (1.0 2.0 3.0)
        (1.0 2.0 3.0)))))

(define-test %scaled-product-vector-array
  ;; Vector - array
  (assert-float-equal
   #(31.5 63.0 94.5)
   (linear-algebra-kernel::%scaled-right-product-vector
    #(1.0 2.0 3.0 4.0 5.0)
    #2A((1.0 2.0 3.0)
        (1.0 2.0 3.0)
        (1.0 2.0 3.0)
        (1.0 2.0 3.0)
        (1.0 2.0 3.0))
    2.1)))

(define-test right-product-vector
  (assert-float-equal
   #(15.0 30.0 45.0)
   (linear-algebra-kernel:right-product-vector
    #(1.0 2.0 3.0 4.0 5.0)
    #2A((1.0 2.0 3.0)
        (1.0 2.0 3.0)
        (1.0 2.0 3.0)
        (1.0 2.0 3.0)
        (1.0 2.0 3.0))
    nil))
  (assert-float-equal
   #(31.5 63.0 94.5)
   (linear-algebra-kernel:right-product-vector
    #(1.0 2.0 3.0 4.0 5.0)
    #2A((1.0 2.0 3.0)
        (1.0 2.0 3.0)
        (1.0 2.0 3.0)
        (1.0 2.0 3.0)
        (1.0 2.0 3.0))
    2.1)))

(define-test %left-product-array
  ;; Array - vector
  (assert-float-equal
   #(15.0 30.0 45.0)
   (linear-algebra-kernel::%left-product-vector
    #2A((1.0 1.0 1.0 1.0 1.0)
        (2.0 2.0 2.0 2.0 2.0)
        (3.0 3.0 3.0 3.0 3.0))
    #(1.0 2.0 3.0 4.0 5.0))))

(define-test %scaled-left-product-array
  ;; Array - vector
  (assert-float-equal
   #(31.5 63.0 94.5)
   (linear-algebra-kernel::%scaled-left-product-vector
    #2A((1.0 1.0 1.0 1.0 1.0)
        (2.0 2.0 2.0 2.0 2.0)
        (3.0 3.0 3.0 3.0 3.0))
    #(1.0 2.0 3.0 4.0 5.0)
    2.1)))

(define-test left-product-array
  ;; Array - vector
  (assert-float-equal
   #(15.0 30.0 45.0)
   (linear-algebra-kernel:left-product-vector
    #2A((1.0 1.0 1.0 1.0 1.0)
        (2.0 2.0 2.0 2.0 2.0)
        (3.0 3.0 3.0 3.0 3.0))
    #(1.0 2.0 3.0 4.0 5.0)
    nil))
  (assert-float-equal
   #(31.5 63.0 94.5)
   (linear-algebra-kernel:left-product-vector
    #2A((1.0 1.0 1.0 1.0 1.0)
        (2.0 2.0 2.0 2.0 2.0)
        (3.0 3.0 3.0 3.0 3.0))
    #(1.0 2.0 3.0 4.0 5.0)
    2.1)))

;;; Array addition

(define-test %array<-array1-op-array2
  (let ((array
         #2A((1.1 1.2 1.3 1.4)
             (2.1 2.2 2.3 2.4)
             (3.1 3.2 3.3 3.4)
             (4.1 4.2 4.3 4.4)
             (5.1 5.2 5.3 5.4))))
    ;; Addition
    (assert-float-equal
     #2A(( 2.2  2.4  2.6  2.8)
         ( 4.2  4.4  4.6  4.8)
         ( 6.2  6.4  6.6  6.8)
         ( 8.2  8.4  8.6  8.8)
         (10.2 10.4 10.6 10.8))
     (linear-algebra-kernel::%array<-array1-op-array2
      #'+ array array))
    ;; Scalar1 addition
    (assert-float-equal
     #2A(( 3.3  3.6  3.9  4.2)
         ( 6.3  6.6  6.9  7.2)
         ( 9.3  9.6  9.9 10.2)
         (12.3 12.6 12.9 13.2)
         (15.3 15.6 15.9 16.2))
     (linear-algebra-kernel::%array<-array1-op-array2
      (lambda (n1 n2) (+ (* 2.0 n1) n2))
      array array))
    ;; Scalar2 addition
    (assert-float-equal
     #2A(( 3.3  3.6  3.9  4.2)
         ( 6.3  6.6  6.9  7.2)
         ( 9.3  9.6  9.9 10.2)
         (12.3 12.6 12.9 13.2)
         (15.3 15.6 15.9 16.2))
     (linear-algebra-kernel::%array<-array1-op-array2
      (lambda (n1 n2) (+ n1 (* 2.0 n2)))
      array array))
    ;; Scalar1 & Scalar2 addition
    (assert-float-equal
     #2A(( 5.5  6.0  6.5  7.0)
         (10.5 11.0 11.5 12.0)
         (15.5 16.0 16.5 17.0)
         (20.5 21.0 21.5 22.0)
         (25.5 26.0 26.5 27.0))
     (linear-algebra-kernel::%array<-array1-op-array2
      (lambda (n1 n2) (+ (* 2.0 n1) (* 3.0 n2)))
      array array)))
  ;; Subtraction
  (let ((*epsilon* (* 3F0 single-float-epsilon))
        (array1
         #2A(( 2.2  2.4  2.6  2.8)
             ( 4.2  4.4  4.6  4.8)
             ( 6.2  6.4  6.6  6.8)
             ( 8.2  8.4  8.6  8.8)
             (10.2 10.4 10.6 10.8)))
        (array2
         #2A((1.1 1.2 1.3 1.4)
             (2.1 2.2 2.3 2.4)
             (3.1 3.2 3.3 3.4)
             (4.1 4.2 4.3 4.4)
             (5.1 5.2 5.3 5.4))))
    ;; No scalar
    (assert-float-equal
     #2A((1.1 1.2 1.3 1.4)
         (2.1 2.2 2.3 2.4)
         (3.1 3.2 3.3 3.4)
         (4.1 4.2 4.3 4.4)
         (5.1 5.2 5.3 5.4))
     (linear-algebra-kernel::%array<-array1-op-array2
      #'- array1 array2))
    ;; Scalar1
    (assert-float-equal
     #2A(( 3.3  3.6  3.9  4.2)
         ( 6.3  6.6  6.9  7.2)
         ( 9.3  9.6  9.9 10.2)
         (12.3 12.6 12.9 13.2)
         (15.3 15.6 15.9 16.2))
     (linear-algebra-kernel::%array<-array1-op-array2
      (lambda (n1 n2) (- (* 2.0 n1) n2))
      array1 array2))
    ;; Scalar2
    (assert-float-equal
     #2A((0.0 0.0 0.0 0.0)
         (0.0 0.0 0.0 0.0)
         (0.0 0.0 0.0 0.0)
         (0.0 0.0 0.0 0.0)
         (0.0 0.0 0.0 0.0))
     (linear-algebra-kernel::%array<-array1-op-array2
      (lambda (n1 n2) (- n1 (* 2.0 n2)))
      array1 array2))
    ;; Scalar1 & Scalar2
    (assert-float-equal
     #2A((1.1 1.2 1.3 1.4)
         (2.1 2.2 2.3 2.4)
         (3.1 3.2 3.3 3.4)
         (4.1 4.2 4.3 4.4)
         (5.1 5.2 5.3 5.4))
     (linear-algebra-kernel::%array<-array1-op-array2
      (lambda (n1 n2) (- (* 2.0 n1) (* 3.0 n2)))
      array1 array2))))

(define-test %array1<-array1-op-array2
  ;; No scalar
  (let ((array1
         (make-array
          '(5 4) :initial-contents
          '((1.1 1.2 1.3 1.4)
            (2.1 2.2 2.3 2.4)
            (3.1 3.2 3.3 3.4)
            (4.1 4.2 4.3 4.4)
            (5.1 5.2 5.3 5.4))))
        (array2
         #2A((1.1 1.2 1.3 1.4)
             (2.1 2.2 2.3 2.4)
             (3.1 3.2 3.3 3.4)
             (4.1 4.2 4.3 4.4)
             (5.1 5.2 5.3 5.4))))
    (assert-eq
     array1
     (linear-algebra-kernel::%array1<-array1-op-array2
      #'+ array1 array2))
    (assert-float-equal
     #2A(( 2.2  2.4  2.6  2.8)
         ( 4.2  4.4  4.6  4.8)
         ( 6.2  6.4  6.6  6.8)
         ( 8.2  8.4  8.6  8.8)
         (10.2 10.4 10.6 10.8))
     array1))
  ;; Scalar1
  (let ((array1
         (make-array
          '(5 4) :initial-contents
          '((1.1 1.2 1.3 1.4)
            (2.1 2.2 2.3 2.4)
            (3.1 3.2 3.3 3.4)
            (4.1 4.2 4.3 4.4)
            (5.1 5.2 5.3 5.4))))
        (array2
         #2A((1.1 1.2 1.3 1.4)
             (2.1 2.2 2.3 2.4)
             (3.1 3.2 3.3 3.4)
             (4.1 4.2 4.3 4.4)
             (5.1 5.2 5.3 5.4))))
    (assert-eq
     array1
     (linear-algebra-kernel::%array1<-array1-op-array2
      (lambda (n1 n2) (+ (* 2.0 n1) n2))
      array1 array2))
    (assert-float-equal
     #2A(( 3.3  3.6  3.9  4.2)
         ( 6.3  6.6  6.9  7.2)
         ( 9.3  9.6  9.9 10.2)
         (12.3 12.6 12.9 13.2)
         (15.3 15.6 15.9 16.2))
     array1))
  ;; Scalar2
  (let ((array1
         (make-array
          '(5 4) :initial-contents
          '((1.1 1.2 1.3 1.4)
            (2.1 2.2 2.3 2.4)
            (3.1 3.2 3.3 3.4)
            (4.1 4.2 4.3 4.4)
            (5.1 5.2 5.3 5.4))))
        (array2
         #2A((1.1 1.2 1.3 1.4)
             (2.1 2.2 2.3 2.4)
             (3.1 3.2 3.3 3.4)
             (4.1 4.2 4.3 4.4)
             (5.1 5.2 5.3 5.4))))
    (assert-eq
     array1
     (linear-algebra-kernel::%array1<-array1-op-array2
      (lambda (n1 n2) (+ n1 (* 2.0 n2)))
      array1 array2))
    (assert-float-equal
     #2A(( 3.3  3.6  3.9  4.2)
         ( 6.3  6.6  6.9  7.2)
         ( 9.3  9.6  9.9 10.2)
         (12.3 12.6 12.9 13.2)
         (15.3 15.6 15.9 16.2))
     array1))
  ;; Scalar1 & Scalar2
  (let ((array1
         (make-array
          '(5 4) :initial-contents
          '((1.1 1.2 1.3 1.4)
            (2.1 2.2 2.3 2.4)
            (3.1 3.2 3.3 3.4)
            (4.1 4.2 4.3 4.4)
            (5.1 5.2 5.3 5.4))))
        (array2
         #2A((1.1 1.2 1.3 1.4)
             (2.1 2.2 2.3 2.4)
             (3.1 3.2 3.3 3.4)
             (4.1 4.2 4.3 4.4)
             (5.1 5.2 5.3 5.4))))
    (assert-eq
     array1
     (linear-algebra-kernel::%array1<-array1-op-array2
      (lambda (n1 n2) (+ (* 2.0 n1) (* 3.0 n2)))
      array1 array2))
    (assert-float-equal
     #2A(( 5.5  6.0  6.5  7.0)
         (10.5 11.0 11.5 12.0)
         (15.5 16.0 16.5 17.0)
         (20.5 21.0 21.5 22.0)
         (25.5 26.0 26.5 27.0))
     array1))
  ;; Subtraction
  (let ((array1
         (make-array
          '(5 4) :initial-contents
          '(( 2.2  2.4  2.6  2.8)
            ( 4.2  4.4  4.6  4.8)
            ( 6.2  6.4  6.6  6.8)
            ( 8.2  8.4  8.6  8.8)
            (10.2 10.4 10.6 10.8))))
        (array2
         #2A((1.1 1.2 1.3 1.4)
             (2.1 2.2 2.3 2.4)
             (3.1 3.2 3.3 3.4)
             (4.1 4.2 4.3 4.4)
             (5.1 5.2 5.3 5.4))))
    (assert-eq
     array1
     (linear-algebra-kernel::%array1<-array1-op-array2
      #'- array1 array2))
    (assert-float-equal
     #2A((1.1 1.2 1.3 1.4)
         (2.1 2.2 2.3 2.4)
         (3.1 3.2 3.3 3.4)
         (4.1 4.2 4.3 4.4)
         (5.1 5.2 5.3 5.4))
     array1))
  ;; Scalar1
  (let ((array1
         (make-array
          '(5 4) :initial-contents
          '((1.1 1.2 1.3 1.4)
            (2.1 2.2 2.3 2.4)
            (3.1 3.2 3.3 3.4)
            (4.1 4.2 4.3 4.4)
            (5.1 5.2 5.3 5.4))))
        (array2
         #2A((1.1 1.2 1.3 1.4)
             (2.1 2.2 2.3 2.4)
             (3.1 3.2 3.3 3.4)
             (4.1 4.2 4.3 4.4)
             (5.1 5.2 5.3 5.4))))
    (assert-eq
     array1
     (linear-algebra-kernel::%array1<-array1-op-array2
      (lambda (n1 n2) (- (* 2.0 n1) n2))
      array1 array2))
    (assert-float-equal
     #2A((1.1 1.2 1.3 1.4)
         (2.1 2.2 2.3 2.4)
         (3.1 3.2 3.3 3.4)
         (4.1 4.2 4.3 4.4)
         (5.1 5.2 5.3 5.4))
     array1))
  ;; Scalar2
  (let ((*epsilon* (* 4F0 single-float-epsilon))
        (array1
         (make-array
          '(5 4) :initial-contents
          '(( 3.3  3.6  3.9  4.2)
            ( 6.3  6.6  6.9  7.2)
            ( 9.3  9.6  9.9 10.2)
            (12.3 12.6 12.9 13.2)
            (15.3 15.6 15.9 16.2))))
        (array2
         #2A((1.1 1.2 1.3 1.4)
             (2.1 2.2 2.3 2.4)
             (3.1 3.2 3.3 3.4)
             (4.1 4.2 4.3 4.4)
             (5.1 5.2 5.3 5.4))))
    (assert-eq
     array1
     (linear-algebra-kernel::%array1<-array1-op-array2
      (lambda (n1 n2) (- n1 (* 2.0 n2)))
      array1 array2))
    (assert-float-equal
     #2A((1.1 1.2 1.3 1.4)
         (2.1 2.2 2.3 2.4)
         (3.1 3.2 3.3 3.4)
         (4.1 4.2 4.3 4.4)
         (5.1 5.2 5.3 5.4))
     array1))
  ;; Scalar1 & Scalar2
  (let ((*epsilon* (* 3F0 single-float-epsilon))
        (array1
         (make-array
          '(5 4) :initial-contents
          '(( 2.2  2.4  2.6  2.8)
            ( 4.2  4.4  4.6  4.8)
            ( 6.2  6.4  6.6  6.8)
            ( 8.2  8.4  8.6  8.8)
            (10.2 10.4 10.6 10.8))))
        (array2
         #2A((1.1 1.2 1.3 1.4)
             (2.1 2.2 2.3 2.4)
             (3.1 3.2 3.3 3.4)
             (4.1 4.2 4.3 4.4)
             (5.1 5.2 5.3 5.4))))
    (assert-eq
     array1
     (linear-algebra-kernel::%array1<-array1-op-array2
      (lambda (n1 n2) (- (* 2.0 n1) (* 3.0 n2)))
      array1 array2))
    (assert-float-equal
     #2A((1.1 1.2 1.3 1.4)
         (2.1 2.2 2.3 2.4)
         (3.1 3.2 3.3 3.4)
         (4.1 4.2 4.3 4.4)
         (5.1 5.2 5.3 5.4))
     array1)))

(define-test binop-add-array
  (let ((array
         #2A((1.1 1.2 1.3 1.4)
             (2.1 2.2 2.3 2.4)
             (3.1 3.2 3.3 3.4)
             (4.1 4.2 4.3 4.4)
             (5.1 5.2 5.3 5.4))))
    ;; No scalar
    (assert-float-equal
     #2A(( 2.2  2.4  2.6  2.8)
         ( 4.2  4.4  4.6  4.8)
         ( 6.2  6.4  6.6  6.8)
         ( 8.2  8.4  8.6  8.8)
         (10.2 10.4 10.6 10.8))
     (linear-algebra-kernel:add-array
      array array nil nil))
    ;; Scalar1
    (assert-float-equal
     #2A(( 3.3  3.6  3.9  4.2)
         ( 6.3  6.6  6.9  7.2)
         ( 9.3  9.6  9.9 10.2)
         (12.3 12.6 12.9 13.2)
         (15.3 15.6 15.9 16.2))
     (linear-algebra-kernel:add-array
      array array 2.0 nil))
    ;; Scalar2
    (assert-float-equal
     #2A(( 3.3  3.6  3.9  4.2)
         ( 6.3  6.6  6.9  7.2)
         ( 9.3  9.6  9.9 10.2)
         (12.3 12.6 12.9 13.2)
         (15.3 15.6 15.9 16.2))
     (linear-algebra-kernel:add-array
      array array nil 2.0))
    ;; Scalar1 & Scalar2
    (assert-float-equal
     #2A(( 5.5  6.0  6.5  7.0)
         (10.5 11.0 11.5 12.0)
         (15.5 16.0 16.5 17.0)
         (20.5 21.0 21.5 22.0)
         (25.5 26.0 26.5 27.0))
     (linear-algebra-kernel:add-array
      array array 2.0 3.0))))

(define-test binop-nadd-array
  ;; No scalar
  (let ((array1
         (make-array
          '(5 4) :initial-contents
          '((1.1 1.2 1.3 1.4)
            (2.1 2.2 2.3 2.4)
            (3.1 3.2 3.3 3.4)
            (4.1 4.2 4.3 4.4)
            (5.1 5.2 5.3 5.4))))
        (array2
         #2A((1.1 1.2 1.3 1.4)
             (2.1 2.2 2.3 2.4)
             (3.1 3.2 3.3 3.4)
             (4.1 4.2 4.3 4.4)
             (5.1 5.2 5.3 5.4))))
    (assert-eq
     array1
     (linear-algebra-kernel:nadd-array
      array1 array2 nil nil))
    (assert-float-equal
     #2A(( 2.2  2.4  2.6  2.8)
         ( 4.2  4.4  4.6  4.8)
         ( 6.2  6.4  6.6  6.8)
         ( 8.2  8.4  8.6  8.8)
         (10.2 10.4 10.6 10.8))
     array1))
  ;; Scalar1
  (let ((array1
         (make-array
          '(5 4) :initial-contents
          '((1.1 1.2 1.3 1.4)
            (2.1 2.2 2.3 2.4)
            (3.1 3.2 3.3 3.4)
            (4.1 4.2 4.3 4.4)
            (5.1 5.2 5.3 5.4))))
        (array2
         #2A((1.1 1.2 1.3 1.4)
             (2.1 2.2 2.3 2.4)
             (3.1 3.2 3.3 3.4)
             (4.1 4.2 4.3 4.4)
             (5.1 5.2 5.3 5.4))))
    (assert-eq
     array1
     (linear-algebra-kernel:nadd-array
      array1 array2 2.0 nil))
    (assert-float-equal
     #2A(( 3.3  3.6  3.9  4.2)
         ( 6.3  6.6  6.9  7.2)
         ( 9.3  9.6  9.9 10.2)
         (12.3 12.6 12.9 13.2)
         (15.3 15.6 15.9 16.2))
     array1))
  ;; Scalar2
  (let ((array1
         (make-array
          '(5 4) :initial-contents
          '((1.1 1.2 1.3 1.4)
            (2.1 2.2 2.3 2.4)
            (3.1 3.2 3.3 3.4)
            (4.1 4.2 4.3 4.4)
            (5.1 5.2 5.3 5.4))))
        (array2
         #2A((1.1 1.2 1.3 1.4)
             (2.1 2.2 2.3 2.4)
             (3.1 3.2 3.3 3.4)
             (4.1 4.2 4.3 4.4)
             (5.1 5.2 5.3 5.4))))
    (assert-eq
     array1
     (linear-algebra-kernel:nadd-array
      array1 array2 nil 2.0))
    (assert-float-equal
     #2A(( 3.3  3.6  3.9  4.2)
         ( 6.3  6.6  6.9  7.2)
         ( 9.3  9.6  9.9 10.2)
         (12.3 12.6 12.9 13.2)
         (15.3 15.6 15.9 16.2))
     array1))
  ;; Scalar1 & Scalar2
  (let ((array1
         (make-array
          '(5 4) :initial-contents
          '((1.1 1.2 1.3 1.4)
            (2.1 2.2 2.3 2.4)
            (3.1 3.2 3.3 3.4)
            (4.1 4.2 4.3 4.4)
            (5.1 5.2 5.3 5.4))))
        (array2
         #2A((1.1 1.2 1.3 1.4)
             (2.1 2.2 2.3 2.4)
             (3.1 3.2 3.3 3.4)
             (4.1 4.2 4.3 4.4)
             (5.1 5.2 5.3 5.4))))
    (assert-eq
     array1
     (linear-algebra-kernel:nadd-array
      array1 array2 2.0 3.0))
    (assert-float-equal
     #2A(( 5.5  6.0  6.5  7.0)
         (10.5 11.0 11.5 12.0)
         (15.5 16.0 16.5 17.0)
         (20.5 21.0 21.5 22.0)
         (25.5 26.0 26.5 27.0))
     array1)))

(define-test binop-subtract-array
  (let ((*epsilon* (* 3F0 single-float-epsilon))
        (array1
         #2A(( 2.2  2.4  2.6  2.8)
             ( 4.2  4.4  4.6  4.8)
             ( 6.2  6.4  6.6  6.8)
             ( 8.2  8.4  8.6  8.8)
             (10.2 10.4 10.6 10.8)))
        (array2
         #2A((1.1 1.2 1.3 1.4)
             (2.1 2.2 2.3 2.4)
             (3.1 3.2 3.3 3.4)
             (4.1 4.2 4.3 4.4)
             (5.1 5.2 5.3 5.4))))
    ;; No scalar
    (assert-float-equal
     #2A((1.1 1.2 1.3 1.4)
         (2.1 2.2 2.3 2.4)
         (3.1 3.2 3.3 3.4)
         (4.1 4.2 4.3 4.4)
         (5.1 5.2 5.3 5.4))
     (linear-algebra-kernel:subtract-array
      array1 array2 nil nil))
    ;; Scalar1
    (assert-float-equal
     #2A(( 3.3  3.6  3.9  4.2)
         ( 6.3  6.6  6.9  7.2)
         ( 9.3  9.6  9.9 10.2)
         (12.3 12.6 12.9 13.2)
         (15.3 15.6 15.9 16.2))
     (linear-algebra-kernel:subtract-array
      array1 array2 2.0 nil))
    ;; Scalar2
    (assert-float-equal
     #2A((0.0 0.0 0.0 0.0)
         (0.0 0.0 0.0 0.0)
         (0.0 0.0 0.0 0.0)
         (0.0 0.0 0.0 0.0)
         (0.0 0.0 0.0 0.0))
     (linear-algebra-kernel:subtract-array
      array1 array2 nil 2.0))
    ;; Scalar1 & Scalar2
    (assert-float-equal
     #2A((1.1 1.2 1.3 1.4)
         (2.1 2.2 2.3 2.4)
         (3.1 3.2 3.3 3.4)
         (4.1 4.2 4.3 4.4)
         (5.1 5.2 5.3 5.4))
     (linear-algebra-kernel:subtract-array
      array1 array2 2.0 3.0))))

(define-test binop-nsubtract-array
  ;; No scalar
  (let ((array1
         (make-array
          '(5 4) :initial-contents
          '(( 2.2  2.4  2.6  2.8)
            ( 4.2  4.4  4.6  4.8)
            ( 6.2  6.4  6.6  6.8)
            ( 8.2  8.4  8.6  8.8)
            (10.2 10.4 10.6 10.8))))
        (array2
         #2A((1.1 1.2 1.3 1.4)
             (2.1 2.2 2.3 2.4)
             (3.1 3.2 3.3 3.4)
             (4.1 4.2 4.3 4.4)
             (5.1 5.2 5.3 5.4))))
    (assert-eq
     array1
     (linear-algebra-kernel:nsubtract-array
      array1 array2 nil nil))
    (assert-float-equal
     #2A((1.1 1.2 1.3 1.4)
         (2.1 2.2 2.3 2.4)
         (3.1 3.2 3.3 3.4)
         (4.1 4.2 4.3 4.4)
         (5.1 5.2 5.3 5.4))
     array1))
  ;; Scalar1
  (let ((array1
         (make-array
          '(5 4) :initial-contents
          '((1.1 1.2 1.3 1.4)
            (2.1 2.2 2.3 2.4)
            (3.1 3.2 3.3 3.4)
            (4.1 4.2 4.3 4.4)
            (5.1 5.2 5.3 5.4))))
        (array2
         #2A((1.1 1.2 1.3 1.4)
             (2.1 2.2 2.3 2.4)
             (3.1 3.2 3.3 3.4)
             (4.1 4.2 4.3 4.4)
             (5.1 5.2 5.3 5.4))))
    (assert-eq
     array1
     (linear-algebra-kernel:nsubtract-array
      array1 array2 2.0 nil))
    (assert-float-equal
     #2A((1.1 1.2 1.3 1.4)
         (2.1 2.2 2.3 2.4)
         (3.1 3.2 3.3 3.4)
         (4.1 4.2 4.3 4.4)
         (5.1 5.2 5.3 5.4))
     array1))
  ;; Scalar2
  (let ((*epsilon* (* 4F0 single-float-epsilon))
        (array1
         (make-array
          '(5 4) :initial-contents
          '(( 3.3  3.6  3.9  4.2)
            ( 6.3  6.6  6.9  7.2)
            ( 9.3  9.6  9.9 10.2)
            (12.3 12.6 12.9 13.2)
            (15.3 15.6 15.9 16.2))))
        (array2
         #2A((1.1 1.2 1.3 1.4)
             (2.1 2.2 2.3 2.4)
             (3.1 3.2 3.3 3.4)
             (4.1 4.2 4.3 4.4)
             (5.1 5.2 5.3 5.4))))
    (assert-eq
     array1
     (linear-algebra-kernel:nsubtract-array
      array1 array2 nil 2.0))
    (assert-float-equal
     #2A((1.1 1.2 1.3 1.4)
         (2.1 2.2 2.3 2.4)
         (3.1 3.2 3.3 3.4)
         (4.1 4.2 4.3 4.4)
         (5.1 5.2 5.3 5.4))
     array1))
  ;; Scalar1 & Scalar2
  (let ((*epsilon* (* 3F0 single-float-epsilon))
        (array1
         (make-array
          '(5 4) :initial-contents
          '(( 2.2  2.4  2.6  2.8)
            ( 4.2  4.4  4.6  4.8)
            ( 6.2  6.4  6.6  6.8)
            ( 8.2  8.4  8.6  8.8)
            (10.2 10.4 10.6 10.8))))
        (array2
         #2A((1.1 1.2 1.3 1.4)
             (2.1 2.2 2.3 2.4)
             (3.1 3.2 3.3 3.4)
             (4.1 4.2 4.3 4.4)
             (5.1 5.2 5.3 5.4))))
    (assert-eq
     array1
     (linear-algebra-kernel:nsubtract-array
      array1 array2 2.0 3.0))
    (assert-float-equal
     #2A((1.1 1.2 1.3 1.4)
         (2.1 2.2 2.3 2.4)
         (3.1 3.2 3.3 3.4)
         (4.1 4.2 4.3 4.4)
         (5.1 5.2 5.3 5.4))
     array1)))
