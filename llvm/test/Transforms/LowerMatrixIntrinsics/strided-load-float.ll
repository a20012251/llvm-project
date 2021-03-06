; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt -lower-matrix-intrinsics -S < %s | FileCheck %s
; RUN: opt -passes='lower-matrix-intrinsics' -S < %s | FileCheck %s

define <9 x float> @strided_load_3x3(<9 x float>* %in, i32 %stride) {
; CHECK-LABEL: @strided_load_3x3(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[TMP0:%.*]] = bitcast <9 x float>* [[IN:%.*]] to float*
; CHECK-NEXT:    [[TMP1:%.*]] = mul i32 0, [[STRIDE:%.*]]
; CHECK-NEXT:    [[TMP2:%.*]] = getelementptr float, float* [[TMP0]], i32 [[TMP1]]
; CHECK-NEXT:    [[TMP3:%.*]] = bitcast float* [[TMP2]] to <3 x float>*
; CHECK-NEXT:    [[TMP4:%.*]] = load <3 x float>, <3 x float>* [[TMP3]], align 4
; CHECK-NEXT:    [[TMP5:%.*]] = mul i32 1, [[STRIDE]]
; CHECK-NEXT:    [[TMP6:%.*]] = getelementptr float, float* [[TMP0]], i32 [[TMP5]]
; CHECK-NEXT:    [[TMP7:%.*]] = bitcast float* [[TMP6]] to <3 x float>*
; CHECK-NEXT:    [[TMP8:%.*]] = load <3 x float>, <3 x float>* [[TMP7]], align 4
; CHECK-NEXT:    [[TMP9:%.*]] = mul i32 2, [[STRIDE]]
; CHECK-NEXT:    [[TMP10:%.*]] = getelementptr float, float* [[TMP0]], i32 [[TMP9]]
; CHECK-NEXT:    [[TMP11:%.*]] = bitcast float* [[TMP10]] to <3 x float>*
; CHECK-NEXT:    [[TMP12:%.*]] = load <3 x float>, <3 x float>* [[TMP11]], align 4
; CHECK-NEXT:    [[TMP13:%.*]] = shufflevector <3 x float> [[TMP4]], <3 x float> [[TMP8]], <6 x i32> <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5>
; CHECK-NEXT:    [[TMP14:%.*]] = shufflevector <3 x float> [[TMP12]], <3 x float> undef, <6 x i32> <i32 0, i32 1, i32 2, i32 undef, i32 undef, i32 undef>
; CHECK-NEXT:    [[TMP15:%.*]] = shufflevector <6 x float> [[TMP13]], <6 x float> [[TMP14]], <9 x i32> <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7, i32 8>
; CHECK-NEXT:    ret <9 x float> [[TMP15]]
;
entry:
  %load = call <9 x float> @llvm.matrix.columnwise.load(<9 x float>* %in, i32 %stride, i32 3, i32 3)
  ret <9 x float> %load
}

declare <9 x float> @llvm.matrix.columnwise.load(<9 x float>*, i32, i32, i32)

define <9 x float> @strided_load_9x1(<9 x float>* %in, i32 %stride) {
; CHECK-LABEL: @strided_load_9x1(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[TMP0:%.*]] = bitcast <9 x float>* [[IN:%.*]] to float*
; CHECK-NEXT:    [[TMP1:%.*]] = mul i32 0, [[STRIDE:%.*]]
; CHECK-NEXT:    [[TMP2:%.*]] = getelementptr float, float* [[TMP0]], i32 [[TMP1]]
; CHECK-NEXT:    [[TMP3:%.*]] = bitcast float* [[TMP2]] to <9 x float>*
; CHECK-NEXT:    [[TMP4:%.*]] = load <9 x float>, <9 x float>* [[TMP3]], align 4
; CHECK-NEXT:    ret <9 x float> [[TMP4]]
;
entry:
  %load = call <9 x float> @llvm.matrix.columnwise.load(<9 x float>* %in, i32 %stride, i32 9, i32 1)
  ret <9 x float> %load
}

declare <8 x float> @llvm.matrix.columnwise.load.v8f32(<8 x float>*, i32, i32, i32)

define <8 x float> @strided_load_4x2(<8 x float>* %in, i32 %stride) {
; CHECK-LABEL: @strided_load_4x2(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[TMP0:%.*]] = bitcast <8 x float>* [[IN:%.*]] to float*
; CHECK-NEXT:    [[TMP1:%.*]] = mul i32 0, [[STRIDE:%.*]]
; CHECK-NEXT:    [[TMP2:%.*]] = getelementptr float, float* [[TMP0]], i32 [[TMP1]]
; CHECK-NEXT:    [[TMP3:%.*]] = bitcast float* [[TMP2]] to <4 x float>*
; CHECK-NEXT:    [[TMP4:%.*]] = load <4 x float>, <4 x float>* [[TMP3]], align 4
; CHECK-NEXT:    [[TMP5:%.*]] = mul i32 1, [[STRIDE]]
; CHECK-NEXT:    [[TMP6:%.*]] = getelementptr float, float* [[TMP0]], i32 [[TMP5]]
; CHECK-NEXT:    [[TMP7:%.*]] = bitcast float* [[TMP6]] to <4 x float>*
; CHECK-NEXT:    [[TMP8:%.*]] = load <4 x float>, <4 x float>* [[TMP7]], align 4
; CHECK-NEXT:    [[TMP9:%.*]] = shufflevector <4 x float> [[TMP4]], <4 x float> [[TMP8]], <8 x i32> <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7>
; CHECK-NEXT:    ret <8 x float> [[TMP9]]
;
entry:
  %load = call <8 x float> @llvm.matrix.columnwise.load.v8f32(<8 x float>* %in, i32 %stride, i32 4, i32 2)
  ret <8 x float> %load
}
