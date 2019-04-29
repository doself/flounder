; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -mtriple=x86_64-apple-macosx10.14.0 -mattr=avx2 | FileCheck %s

define void @foo(double %arg) {
; CHECK-LABEL: foo:
; CHECK:       ## %bb.0: ## %bb
; CHECK-NEXT:    vmovq %xmm0, %rax
; CHECK-NEXT:    vmovd %eax, %xmm0
; CHECK-NEXT:    vxorps %xmm1, %xmm1, %xmm1
; CHECK-NEXT:    vmovq %xmm0, %rax
; CHECK-NEXT:    movl %eax, (%rax)
; CHECK-NEXT:    vmovlps %xmm1, (%rax)
; CHECK-NEXT:    retq
bb:
  %tmp = bitcast double %arg to i64
  %tmp1 = trunc i64 %tmp to i32
  %tmp2 = bitcast i32 %tmp1 to float
  %tmp3 = insertelement <4 x float> zeroinitializer, float %tmp2, i32 2
  %tmp4 = bitcast <4 x float> %tmp3 to <2 x double>
  %tmp5 = extractelement <2 x double> %tmp4, i32 0
  %tmp6 = extractelement <2 x double> %tmp4, i32 1
  %tmp7 = bitcast double %tmp6 to i64
  %tmp8 = trunc i64 %tmp7 to i32
  store i32 %tmp8, i32* undef, align 4
  store double %tmp5, double* undef, align 16
  ret void
}