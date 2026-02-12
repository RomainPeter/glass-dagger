; ModuleID = 'pendulum_opt.ll'
source_filename = "../c/pendulum_opt.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct.Params = type { double, double, double, double, double }
%struct.State = type { double, double, double, double }

@params = internal constant %struct.Params { double 1.000000e+00, double 1.000000e+00, double 1.000000e+00, double 1.000000e+00, double 9.810000e+00 }, align 8
@.str.1 = private unnamed_addr constant [45 x i8] c"Target: bob 2 at (%.2f, %.2f) after T=%.1fs\0A\00", align 1
@.str.2 = private unnamed_addr constant [47 x i8] c"Initial: omega1=%.4f, omega2=%.4f, loss=%.6f\0A\0A\00", align 1
@.str.3 = private unnamed_addr constant [44 x i8] c"[%03d] omega1=%.4f, omega2=%.4f, loss=%.6f\0A\00", align 1
@.str.5 = private unnamed_addr constant [28 x i8] c"  omega1=%.6f, omega2=%.6f\0A\00", align 1
@.str.6 = private unnamed_addr constant [32 x i8] c"  Bob 2 position: (%.6f, %.6f)\0A\00", align 1
@.str.7 = private unnamed_addr constant [32 x i8] c"  Target:         (%.6f, %.6f)\0A\00", align 1
@.str.8 = private unnamed_addr constant [17 x i8] c"  Error: %.6f m\0A\00", align 1
@str = private unnamed_addr constant [54 x i8] c"=== Glass Dagger M2: Double Pendulum Optimization ===\00", align 1
@str.11 = private unnamed_addr constant [15 x i8] c"\0AFinal Result:\00", align 1
@str.12 = private unnamed_addr constant [34 x i8] c"\E2\9D\8C M2 FAILURE: Did not converge.\00", align 1
@str.13 = private unnamed_addr constant [37 x i8] c"\E2\9C\85 M2 SUCCESS: Converged to target!\00", align 1

; Function Attrs: nofree norecurse nosync nounwind memory(none) uwtable
define dso_local nofpclass(nan inf) double @loss_omega1(double noundef nofpclass(nan inf) %omega1_0, double noundef nofpclass(nan inf) %omega2_0) #0 {
entry:
  br label %for.body

for.cond.cleanup:                                 ; preds = %for.body
  %0 = tail call fast double @llvm.sin.f64(double %add29)
  %1 = tail call fast double @llvm.sin.f64(double %add43)
  %add53 = fadd fast double %0, %1
  %2 = tail call fast double @llvm.cos.f64(double %add29)
  %3 = tail call fast double @llvm.cos.f64(double %add43)
  %4 = fadd fast double %3, %2
  %sub57 = fsub fast double 1.800000e+00, %4
  %mul58 = fmul fast double %add53, %add53
  %mul59 = fmul fast double %sub57, %sub57
  %mul61 = fmul fast double %omega1_0, %omega1_0
  %mul62 = fmul fast double %omega2_0, %omega2_0
  %add63 = fadd fast double %mul62, %mul61
  %mul64 = fmul fast double %add63, 1.000000e-03
  %add60 = fadd fast double %mul59, %mul64
  %add65 = fadd fast double %add60, %mul58
  ret double %add65

for.body:                                         ; preds = %for.body, %entry
  %theta1.0187 = phi double [ 0x3FE921FB54442D18, %entry ], [ %add29, %for.body ]
  %omega1.0186 = phi double [ %omega1_0, %entry ], [ %add36, %for.body ]
  %theta2.0185 = phi double [ 0x3FE0C152382D7365, %entry ], [ %add43, %for.body ]
  %omega2.0184 = phi double [ %omega2_0, %entry ], [ %add50, %for.body ]
  %i.0183 = phi i32 [ 0, %entry ], [ %inc, %for.body ]
  %sub.i = fsub fast double %theta1.0187, %theta2.0185
  %5 = tail call fast double @llvm.cos.f64(double %sub.i)
  %6 = tail call fast double @llvm.sin.f64(double %sub.i)
  %mul1.i = fmul fast double %sub.i, 2.000000e+00
  %7 = tail call fast double @llvm.cos.f64(double %mul1.i)
  %sub3.i = fsub fast double 3.000000e+00, %7
  %8 = tail call fast double @llvm.sin.f64(double %theta1.0187)
  %mul7.i = fmul fast double %8, -2.943000e+01
  %mul9.i = fmul fast double %theta2.0185, 2.000000e+00
  %sub10.i = fsub fast double %theta1.0187, %mul9.i
  %9 = tail call fast double @llvm.sin.f64(double %sub10.i)
  %mul13.i = fmul fast double %6, 2.000000e+00
  %mul15.i = fmul fast double %omega2.0184, %omega2.0184
  %mul17.i = fmul fast double %omega1.0186, %omega1.0186
  %mul19.i = fmul fast double %5, %mul17.i
  %add20.i = fadd fast double %mul19.i, %mul15.i
  %mul11.neg.i = fmul fast double %9, -9.810000e+00
  %.neg.i = fadd fast double %mul11.neg.i, %mul7.i
  %10 = fmul fast double %add20.i, %mul13.i
  %sub22.i = fsub fast double %.neg.i, %10
  %div.i = fdiv fast double %sub22.i, %sub3.i
  %mul28.i = fmul fast double %mul17.i, 2.000000e+00
  %11 = tail call fast double @llvm.cos.f64(double %theta1.0187)
  %mul31.i = fmul fast double %11, 1.962000e+01
  %add32.i = fadd fast double %mul31.i, %mul28.i
  %mul36.i = fmul fast double %5, %mul15.i
  %add37.i = fadd fast double %add32.i, %mul36.i
  %mul38.i = fmul fast double %add37.i, %mul13.i
  %div40.i = fdiv fast double %mul38.i, %sub3.i
  %mul = fmul fast double %omega1.0186, 5.000000e-04
  %add = fadd fast double %theta1.0187, %mul
  %mul1 = fmul fast double %div.i, 5.000000e-04
  %add2 = fadd fast double %mul1, %omega1.0186
  %mul3 = fmul fast double %omega2.0184, 5.000000e-04
  %add4 = fadd fast double %theta2.0185, %mul3
  %mul5 = fmul fast double %div40.i, 5.000000e-04
  %add6 = fadd fast double %mul5, %omega2.0184
  %sub.i93 = fsub fast double %add, %add4
  %12 = tail call fast double @llvm.cos.f64(double %sub.i93)
  %13 = tail call fast double @llvm.sin.f64(double %sub.i93)
  %mul1.i94 = fmul fast double %sub.i93, 2.000000e+00
  %14 = tail call fast double @llvm.cos.f64(double %mul1.i94)
  %sub3.i95 = fsub fast double 3.000000e+00, %14
  %15 = tail call fast double @llvm.sin.f64(double %add)
  %mul7.i96 = fmul fast double %15, -2.943000e+01
  %mul9.i97 = fmul fast double %add4, 2.000000e+00
  %sub10.i98 = fsub fast double %add, %mul9.i97
  %16 = tail call fast double @llvm.sin.f64(double %sub10.i98)
  %mul13.i99 = fmul fast double %13, 2.000000e+00
  %mul15.i100 = fmul fast double %add6, %add6
  %mul17.i101 = fmul fast double %add2, %add2
  %mul19.i102 = fmul fast double %mul17.i101, %12
  %add20.i103 = fadd fast double %mul19.i102, %mul15.i100
  %mul11.neg.i104 = fmul fast double %16, -9.810000e+00
  %.neg.i105 = fadd fast double %mul11.neg.i104, %mul7.i96
  %17 = fmul fast double %add20.i103, %mul13.i99
  %sub22.i106 = fsub fast double %.neg.i105, %17
  %div.i107 = fdiv fast double %sub22.i106, %sub3.i95
  %mul28.i108 = fmul fast double %mul17.i101, 2.000000e+00
  %18 = tail call fast double @llvm.cos.f64(double %add)
  %mul31.i109 = fmul fast double %18, 1.962000e+01
  %mul36.i111 = fmul fast double %mul15.i100, %12
  %add32.i110 = fadd fast double %mul36.i111, %mul31.i109
  %add37.i112 = fadd fast double %add32.i110, %mul28.i108
  %mul38.i113 = fmul fast double %add37.i112, %mul13.i99
  %div40.i114 = fdiv fast double %mul38.i113, %sub3.i95
  %mul7 = fmul fast double %add2, 5.000000e-04
  %add8 = fadd fast double %mul7, %theta1.0187
  %mul9 = fmul fast double %div.i107, 5.000000e-04
  %add10 = fadd fast double %mul9, %omega1.0186
  %mul11 = fmul fast double %add6, 5.000000e-04
  %add12 = fadd fast double %mul11, %theta2.0185
  %mul13 = fmul fast double %div40.i114, 5.000000e-04
  %add14 = fadd fast double %mul13, %omega2.0184
  %sub.i115 = fsub fast double %add8, %add12
  %19 = tail call fast double @llvm.cos.f64(double %sub.i115)
  %20 = tail call fast double @llvm.sin.f64(double %sub.i115)
  %mul1.i116 = fmul fast double %sub.i115, 2.000000e+00
  %21 = tail call fast double @llvm.cos.f64(double %mul1.i116)
  %sub3.i117 = fsub fast double 3.000000e+00, %21
  %22 = tail call fast double @llvm.sin.f64(double %add8)
  %mul7.i118 = fmul fast double %22, -2.943000e+01
  %mul9.i119 = fmul fast double %add12, 2.000000e+00
  %sub10.i120 = fsub fast double %add8, %mul9.i119
  %23 = tail call fast double @llvm.sin.f64(double %sub10.i120)
  %mul13.i121 = fmul fast double %20, 2.000000e+00
  %mul15.i122 = fmul fast double %add14, %add14
  %mul17.i123 = fmul fast double %add10, %add10
  %mul19.i124 = fmul fast double %mul17.i123, %19
  %add20.i125 = fadd fast double %mul19.i124, %mul15.i122
  %mul11.neg.i126 = fmul fast double %23, -9.810000e+00
  %.neg.i127 = fadd fast double %mul11.neg.i126, %mul7.i118
  %24 = fmul fast double %add20.i125, %mul13.i121
  %sub22.i128 = fsub fast double %.neg.i127, %24
  %div.i129 = fdiv fast double %sub22.i128, %sub3.i117
  %mul28.i130 = fmul fast double %mul17.i123, 2.000000e+00
  %25 = tail call fast double @llvm.cos.f64(double %add8)
  %mul31.i131 = fmul fast double %25, 1.962000e+01
  %add32.i132 = fadd fast double %mul28.i130, %mul31.i131
  %mul36.i133 = fmul fast double %mul15.i122, %19
  %add37.i134 = fadd fast double %add32.i132, %mul36.i133
  %mul38.i135 = fmul fast double %add37.i134, %mul13.i121
  %div40.i136 = fdiv fast double %mul38.i135, %sub3.i117
  %mul15 = fmul fast double %add10, 1.000000e-03
  %add16 = fadd fast double %mul15, %theta1.0187
  %mul17 = fmul fast double %div.i129, 1.000000e-03
  %add18 = fadd fast double %mul17, %omega1.0186
  %mul19 = fmul fast double %add14, 1.000000e-03
  %add20 = fadd fast double %mul19, %theta2.0185
  %mul21 = fmul fast double %div40.i136, 1.000000e-03
  %add22 = fadd fast double %mul21, %omega2.0184
  %sub.i137 = fsub fast double %add16, %add20
  %26 = tail call fast double @llvm.cos.f64(double %sub.i137)
  %27 = tail call fast double @llvm.sin.f64(double %sub.i137)
  %mul1.i138 = fmul fast double %sub.i137, 2.000000e+00
  %28 = tail call fast double @llvm.cos.f64(double %mul1.i138)
  %sub3.i139 = fsub fast double 3.000000e+00, %28
  %29 = tail call fast double @llvm.sin.f64(double %add16)
  %mul7.i140 = fmul fast double %29, -2.943000e+01
  %mul9.i141 = fmul fast double %add20, 2.000000e+00
  %sub10.i142 = fsub fast double %add16, %mul9.i141
  %30 = tail call fast double @llvm.sin.f64(double %sub10.i142)
  %mul13.i143 = fmul fast double %27, 2.000000e+00
  %mul15.i144 = fmul fast double %add22, %add22
  %mul17.i145 = fmul fast double %add18, %add18
  %mul19.i146 = fmul fast double %mul17.i145, %26
  %add20.i147 = fadd fast double %mul19.i146, %mul15.i144
  %mul11.neg.i148 = fmul fast double %30, -9.810000e+00
  %.neg.i149 = fadd fast double %mul11.neg.i148, %mul7.i140
  %31 = fmul fast double %add20.i147, %mul13.i143
  %sub22.i150 = fsub fast double %.neg.i149, %31
  %div.i151 = fdiv fast double %sub22.i150, %sub3.i139
  %mul28.i152 = fmul fast double %mul17.i145, 2.000000e+00
  %32 = tail call fast double @llvm.cos.f64(double %add16)
  %mul31.i153 = fmul fast double %32, 1.962000e+01
  %add32.i154 = fadd fast double %mul28.i152, %mul31.i153
  %mul36.i155 = fmul fast double %mul15.i144, %26
  %add37.i156 = fadd fast double %add32.i154, %mul36.i155
  %mul38.i157 = fmul fast double %add37.i156, %mul13.i143
  %div40.i158 = fdiv fast double %mul38.i157, %sub3.i139
  %reass.add = fadd fast double %add10, %add2
  %reass.mul = fmul fast double %reass.add, 2.000000e+00
  %add26 = fadd fast double %reass.mul, %omega1.0186
  %add27 = fadd fast double %add26, %add18
  %mul28 = fmul fast double %add27, 0x3F25D867C3ECE2A5
  %add29 = fadd fast double %mul28, %theta1.0187
  %reass.add177 = fadd fast double %div.i129, %div.i107
  %reass.mul178 = fmul fast double %reass.add177, 2.000000e+00
  %add33 = fadd fast double %reass.mul178, %div.i
  %add34 = fadd fast double %add33, %div.i151
  %mul35 = fmul fast double %add34, 0x3F25D867C3ECE2A5
  %add36 = fadd fast double %mul35, %omega1.0186
  %reass.add179 = fadd fast double %add14, %add6
  %reass.mul180 = fmul fast double %reass.add179, 2.000000e+00
  %add40 = fadd fast double %reass.mul180, %omega2.0184
  %add41 = fadd fast double %add40, %add22
  %mul42 = fmul fast double %add41, 0x3F25D867C3ECE2A5
  %add43 = fadd fast double %mul42, %theta2.0185
  %reass.add181 = fadd fast double %div40.i136, %div40.i114
  %reass.mul182 = fmul fast double %reass.add181, 2.000000e+00
  %add47 = fadd fast double %reass.mul182, %div40.i
  %add48 = fadd fast double %add47, %div40.i158
  %mul49 = fmul fast double %add48, 0x3F25D867C3ECE2A5
  %add50 = fadd fast double %mul49, %omega2.0184
  %inc = add nuw nsw i32 %i.0183, 1
  %exitcond.not = icmp eq i32 %inc, 1000
  br i1 %exitcond.not, label %for.cond.cleanup, label %for.body, !llvm.loop !5
}

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(argmem: readwrite)
declare void @llvm.lifetime.start.p0(i64 immarg, ptr nocapture) #1

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(argmem: readwrite)
declare void @llvm.lifetime.end.p0(i64 immarg, ptr nocapture) #1

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare double @llvm.sin.f64(double) #2

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare double @llvm.cos.f64(double) #2

; Function Attrs: nofree norecurse nosync nounwind memory(none) uwtable
define dso_local nofpclass(nan inf) double @loss_omega2(double noundef nofpclass(nan inf) %omega2_0, double noundef nofpclass(nan inf) %omega1_0) #0 {
entry:
  %call = tail call fast nofpclass(nan inf) double @loss_omega1(double noundef nofpclass(nan inf) %omega1_0, double noundef nofpclass(nan inf) %omega2_0)
  ret double %call
}

; Function Attrs: nounwind uwtable
define dso_local nofpclass(nan inf) double @dloss_domega1(double noundef nofpclass(nan inf) %omega1_0, double noundef nofpclass(nan inf) %omega2_0) local_unnamed_addr #3 {
entry:
  %0 = call { double, double } @diffeloss_omega1(double %omega1_0, double %omega2_0, double 1.000000e+00)
  %1 = extractvalue { double, double } %0, 0
  ret double %1
}

declare nofpclass(nan inf) double @__enzyme_autodiff(ptr noundef, double noundef nofpclass(nan inf), double noundef nofpclass(nan inf)) local_unnamed_addr #4

; Function Attrs: nounwind uwtable
define dso_local nofpclass(nan inf) double @dloss_domega2(double noundef nofpclass(nan inf) %omega1_0, double noundef nofpclass(nan inf) %omega2_0) local_unnamed_addr #3 {
entry:
  %0 = call { double, double } @diffeloss_omega2(double %omega2_0, double %omega1_0, double 1.000000e+00)
  %1 = extractvalue { double, double } %0, 0
  ret double %1
}

; Function Attrs: nounwind uwtable
define dso_local i32 @main() local_unnamed_addr #3 {
if.end.peel:
  %y0 = alloca %struct.State, align 8
  %yT = alloca %struct.State, align 8
  %x2 = alloca double, align 8
  %y2 = alloca double, align 8
  %puts = tail call i32 @puts(ptr nonnull dereferenceable(1) @str)
  %call1 = tail call i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @.str.1, double noundef nofpclass(nan inf) 0.000000e+00, double noundef nofpclass(nan inf) -1.800000e+00, double noundef nofpclass(nan inf) 1.000000e+00)
  %call2 = tail call fast nofpclass(nan inf) double @loss_omega1(double noundef nofpclass(nan inf) 0.000000e+00, double noundef nofpclass(nan inf) 0.000000e+00)
  %call3 = tail call i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @.str.2, double noundef nofpclass(nan inf) 0.000000e+00, double noundef nofpclass(nan inf) 0.000000e+00, double noundef nofpclass(nan inf) %call2)
  %0 = call { double, double } @diffeloss_omega1(double 0.000000e+00, double 0.000000e+00, double 1.000000e+00)
  %1 = extractvalue { double, double } %0, 0
  %2 = call { double, double } @diffeloss_omega2(double 0.000000e+00, double 0.000000e+00, double 1.000000e+00)
  %3 = extractvalue { double, double } %2, 0
  %sub.peel = fmul fast double %1, -2.000000e-02
  %sub7.peel = fmul fast double %3, -2.000000e-02
  %call8.peel = tail call fast nofpclass(nan inf) double @loss_omega1(double noundef nofpclass(nan inf) %sub.peel, double noundef nofpclass(nan inf) %sub7.peel)
  %call12.peel = tail call i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @.str.3, i32 noundef 1, double noundef nofpclass(nan inf) %sub.peel, double noundef nofpclass(nan inf) %sub7.peel, double noundef nofpclass(nan inf) %call8.peel)
  %cmp13.peel = fcmp fast uge double %call8.peel, 0x3EB0C6F7A0B5ED8D
  br i1 %cmp13.peel, label %for.cond, label %cleanup18

for.cond:                                         ; preds = %if.end, %if.end.peel
  %i.0 = phi i32 [ %add, %if.end ], [ 1, %if.end.peel ]
  %omega2.0 = phi double [ %sub7, %if.end ], [ %sub7.peel, %if.end.peel ]
  %omega1.0 = phi double [ %sub, %if.end ], [ %sub.peel, %if.end.peel ]
  %exitcond.not = icmp eq i32 %i.0, 200
  br i1 %exitcond.not, label %cleanup18, label %for.body

for.body:                                         ; preds = %for.cond
  %4 = call { double, double } @diffeloss_omega1(double %omega1.0, double %omega2.0, double 1.000000e+00)
  %5 = extractvalue { double, double } %4, 0
  %6 = call { double, double } @diffeloss_omega2(double %omega2.0, double %omega1.0, double 1.000000e+00)
  %7 = extractvalue { double, double } %6, 0
  %mul = fmul fast double %5, 2.000000e-02
  %sub = fsub fast double %omega1.0, %mul
  %mul6 = fmul fast double %7, 2.000000e-02
  %sub7 = fsub fast double %omega2.0, %mul6
  %call8 = tail call fast nofpclass(nan inf) double @loss_omega1(double noundef nofpclass(nan inf) %sub, double noundef nofpclass(nan inf) %sub7)
  %add = add nuw nsw i32 %i.0, 1
  %rem.lhs.trunc = trunc i32 %add to i8
  %rem78 = urem i8 %rem.lhs.trunc, 10
  %cmp9 = icmp eq i8 %rem78, 0
  br i1 %cmp9, label %if.then, label %if.end

if.then:                                          ; preds = %for.body
  %call12 = tail call i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @.str.3, i32 noundef %add, double noundef nofpclass(nan inf) %sub, double noundef nofpclass(nan inf) %sub7, double noundef nofpclass(nan inf) %call8)
  br label %if.end

if.end:                                           ; preds = %if.then, %for.body
  %cmp13 = fcmp fast uge double %call8, 0x3EB0C6F7A0B5ED8D
  br i1 %cmp13, label %for.cond, label %cleanup18, !llvm.loop !7

cleanup18:                                        ; preds = %if.end, %for.cond, %if.end.peel
  %omega2.1 = phi double [ %sub7.peel, %if.end.peel ], [ %sub7, %if.end ], [ %omega2.0, %for.cond ]
  %omega1.1 = phi double [ %sub.peel, %if.end.peel ], [ %sub, %if.end ], [ %omega1.0, %for.cond ]
  call void @llvm.lifetime.start.p0(i64 32, ptr nonnull %y0) #9
  store double 0x3FE921FB54442D18, ptr %y0, align 8, !tbaa !9
  %omega119 = getelementptr inbounds %struct.State, ptr %y0, i64 0, i32 1
  store double %omega1.1, ptr %omega119, align 8, !tbaa !14
  %theta2 = getelementptr inbounds %struct.State, ptr %y0, i64 0, i32 2
  store double 0x3FE0C152382D7365, ptr %theta2, align 8, !tbaa !15
  %omega220 = getelementptr inbounds %struct.State, ptr %y0, i64 0, i32 3
  store double %omega2.1, ptr %omega220, align 8, !tbaa !16
  call void @llvm.lifetime.start.p0(i64 32, ptr nonnull %yT) #9
  call void @simulate(ptr dead_on_unwind nonnull writable sret(%struct.State) align 8 %yT, ptr noundef nonnull byval(%struct.State) align 8 %y0, i32 noundef 1000, double noundef nofpclass(nan inf) 1.000000e-03, ptr noundef nonnull @params) #9
  call void @llvm.lifetime.start.p0(i64 8, ptr nonnull %x2) #9
  call void @llvm.lifetime.start.p0(i64 8, ptr nonnull %y2) #9
  call void @get_bob2_position(ptr noundef nonnull %yT, ptr noundef nonnull @params, ptr noundef nonnull %x2, ptr noundef nonnull %y2) #9
  %puts74 = call i32 @puts(ptr nonnull dereferenceable(1) @str.11)
  %call22 = call i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @.str.5, double noundef nofpclass(nan inf) %omega1.1, double noundef nofpclass(nan inf) %omega2.1)
  %8 = load double, ptr %x2, align 8, !tbaa !17
  %9 = load double, ptr %y2, align 8, !tbaa !17
  %call23 = call i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @.str.6, double noundef nofpclass(nan inf) %8, double noundef nofpclass(nan inf) %9)
  %call24 = call i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @.str.7, double noundef nofpclass(nan inf) 0.000000e+00, double noundef nofpclass(nan inf) -1.800000e+00)
  %10 = load double, ptr %x2, align 8, !tbaa !17
  %mul27 = fmul fast double %10, %10
  %11 = load double, ptr %y2, align 8, !tbaa !17
  %sub28 = fadd fast double %11, 1.800000e+00
  %mul30 = fmul fast double %sub28, %sub28
  %add31 = fadd fast double %mul30, %mul27
  %12 = call fast double @llvm.sqrt.f64(double %add31)
  %call32 = call i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @.str.8, double noundef nofpclass(nan inf) %12)
  %13 = load double, ptr %x2, align 8, !tbaa !17
  %mul35 = fmul fast double %13, %13
  %14 = load double, ptr %y2, align 8, !tbaa !17
  %sub36 = fadd fast double %14, 1.800000e+00
  %mul38 = fmul fast double %sub36, %sub36
  %add39 = fadd fast double %mul38, %mul35
  %15 = call fast double @llvm.sqrt.f64(double %add39)
  %cmp40 = fcmp fast uge double %15, 3.000000e-01
  %str.13.str.12 = select i1 %cmp40, ptr @str.12, ptr @str.13
  %. = zext i1 %cmp40 to i32
  %puts75 = call i32 @puts(ptr nonnull dereferenceable(1) %str.13.str.12)
  call void @llvm.lifetime.end.p0(i64 8, ptr nonnull %y2) #9
  call void @llvm.lifetime.end.p0(i64 8, ptr nonnull %x2) #9
  call void @llvm.lifetime.end.p0(i64 32, ptr nonnull %yT) #9
  call void @llvm.lifetime.end.p0(i64 32, ptr nonnull %y0) #9
  ret i32 %.
}

; Function Attrs: nofree nounwind
declare noundef i32 @printf(ptr nocapture noundef readonly, ...) local_unnamed_addr #5

declare void @simulate(ptr dead_on_unwind writable sret(%struct.State) align 8, ptr noundef byval(%struct.State) align 8, i32 noundef, double noundef nofpclass(nan inf), ptr noundef) local_unnamed_addr #4

declare void @get_bob2_position(ptr noundef, ptr noundef, ptr noundef, ptr noundef) local_unnamed_addr #4

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare double @llvm.sqrt.f64(double) #2

; Function Attrs: nofree nounwind
declare noundef i32 @puts(ptr nocapture noundef readonly) local_unnamed_addr #6

; Function Attrs: mustprogress nofree norecurse nosync nounwind uwtable
define internal { double, double } @diffeloss_omega1(double noundef nofpclass(nan inf) %omega1_0, double noundef nofpclass(nan inf) %omega2_0, double %differeturn) #7 {
entry:
  %"iv'ac" = alloca i64, align 8
  %"add65'de" = alloca double, align 8
  store double 0.000000e+00, ptr %"add65'de", align 8
  %"omega1_0'de" = alloca double, align 8
  store double 0.000000e+00, ptr %"omega1_0'de", align 8
  %"omega2_0'de" = alloca double, align 8
  store double 0.000000e+00, ptr %"omega2_0'de", align 8
  %"add60'de" = alloca double, align 8
  store double 0.000000e+00, ptr %"add60'de", align 8
  %"mul58'de" = alloca double, align 8
  store double 0.000000e+00, ptr %"mul58'de", align 8
  %"mul59'de" = alloca double, align 8
  store double 0.000000e+00, ptr %"mul59'de", align 8
  %"mul64'de" = alloca double, align 8
  store double 0.000000e+00, ptr %"mul64'de", align 8
  %"add63'de" = alloca double, align 8
  store double 0.000000e+00, ptr %"add63'de", align 8
  %"mul62'de" = alloca double, align 8
  store double 0.000000e+00, ptr %"mul62'de", align 8
  %"mul61'de" = alloca double, align 8
  store double 0.000000e+00, ptr %"mul61'de", align 8
  %"sub57'de" = alloca double, align 8
  store double 0.000000e+00, ptr %"sub57'de", align 8
  %"add53'de" = alloca double, align 8
  store double 0.000000e+00, ptr %"add53'de", align 8
  %"'de" = alloca double, align 8
  store double 0.000000e+00, ptr %"'de", align 8
  %"'de1" = alloca double, align 8
  store double 0.000000e+00, ptr %"'de1", align 8
  %"'de2" = alloca double, align 8
  store double 0.000000e+00, ptr %"'de2", align 8
  %"add43'de" = alloca double, align 8
  store double 0.000000e+00, ptr %"add43'de", align 8
  %"add29'de" = alloca double, align 8
  store double 0.000000e+00, ptr %"add29'de", align 8
  %"'de3" = alloca double, align 8
  store double 0.000000e+00, ptr %"'de3", align 8
  %"'de4" = alloca double, align 8
  store double 0.000000e+00, ptr %"'de4", align 8
  %"add50'de" = alloca double, align 8
  store double 0.000000e+00, ptr %"add50'de", align 8
  %"mul49'de" = alloca double, align 8
  store double 0.000000e+00, ptr %"mul49'de", align 8
  %"omega2.0184'de" = alloca double, align 8
  store double 0.000000e+00, ptr %"omega2.0184'de", align 8
  %"add48'de" = alloca double, align 8
  store double 0.000000e+00, ptr %"add48'de", align 8
  %"add47'de" = alloca double, align 8
  store double 0.000000e+00, ptr %"add47'de", align 8
  %"div40.i158'de" = alloca double, align 8
  store double 0.000000e+00, ptr %"div40.i158'de", align 8
  %"reass.mul182'de" = alloca double, align 8
  store double 0.000000e+00, ptr %"reass.mul182'de", align 8
  %"div40.i'de" = alloca double, align 8
  store double 0.000000e+00, ptr %"div40.i'de", align 8
  %"reass.add181'de" = alloca double, align 8
  store double 0.000000e+00, ptr %"reass.add181'de", align 8
  %"div40.i136'de" = alloca double, align 8
  store double 0.000000e+00, ptr %"div40.i136'de", align 8
  %"div40.i114'de" = alloca double, align 8
  store double 0.000000e+00, ptr %"div40.i114'de", align 8
  %"mul42'de" = alloca double, align 8
  store double 0.000000e+00, ptr %"mul42'de", align 8
  %"theta2.0185'de" = alloca double, align 8
  store double 0.000000e+00, ptr %"theta2.0185'de", align 8
  %"add41'de" = alloca double, align 8
  store double 0.000000e+00, ptr %"add41'de", align 8
  %"add40'de" = alloca double, align 8
  store double 0.000000e+00, ptr %"add40'de", align 8
  %"add22'de" = alloca double, align 8
  store double 0.000000e+00, ptr %"add22'de", align 8
  %"reass.mul180'de" = alloca double, align 8
  store double 0.000000e+00, ptr %"reass.mul180'de", align 8
  %"reass.add179'de" = alloca double, align 8
  store double 0.000000e+00, ptr %"reass.add179'de", align 8
  %"add14'de" = alloca double, align 8
  store double 0.000000e+00, ptr %"add14'de", align 8
  %"add6'de" = alloca double, align 8
  store double 0.000000e+00, ptr %"add6'de", align 8
  %"add36'de" = alloca double, align 8
  store double 0.000000e+00, ptr %"add36'de", align 8
  %"mul35'de" = alloca double, align 8
  store double 0.000000e+00, ptr %"mul35'de", align 8
  %"omega1.0186'de" = alloca double, align 8
  store double 0.000000e+00, ptr %"omega1.0186'de", align 8
  %"add34'de" = alloca double, align 8
  store double 0.000000e+00, ptr %"add34'de", align 8
  %"add33'de" = alloca double, align 8
  store double 0.000000e+00, ptr %"add33'de", align 8
  %"div.i151'de" = alloca double, align 8
  store double 0.000000e+00, ptr %"div.i151'de", align 8
  %"reass.mul178'de" = alloca double, align 8
  store double 0.000000e+00, ptr %"reass.mul178'de", align 8
  %"div.i'de" = alloca double, align 8
  store double 0.000000e+00, ptr %"div.i'de", align 8
  %"reass.add177'de" = alloca double, align 8
  store double 0.000000e+00, ptr %"reass.add177'de", align 8
  %"div.i129'de" = alloca double, align 8
  store double 0.000000e+00, ptr %"div.i129'de", align 8
  %"div.i107'de" = alloca double, align 8
  store double 0.000000e+00, ptr %"div.i107'de", align 8
  %"mul28'de" = alloca double, align 8
  store double 0.000000e+00, ptr %"mul28'de", align 8
  %"theta1.0187'de" = alloca double, align 8
  store double 0.000000e+00, ptr %"theta1.0187'de", align 8
  %"add27'de" = alloca double, align 8
  store double 0.000000e+00, ptr %"add27'de", align 8
  %"add26'de" = alloca double, align 8
  store double 0.000000e+00, ptr %"add26'de", align 8
  %"add18'de" = alloca double, align 8
  store double 0.000000e+00, ptr %"add18'de", align 8
  %"reass.mul'de" = alloca double, align 8
  store double 0.000000e+00, ptr %"reass.mul'de", align 8
  %"reass.add'de" = alloca double, align 8
  store double 0.000000e+00, ptr %"reass.add'de", align 8
  %"add10'de" = alloca double, align 8
  store double 0.000000e+00, ptr %"add10'de", align 8
  %"add2'de" = alloca double, align 8
  store double 0.000000e+00, ptr %"add2'de", align 8
  %theta1.0187_cache = alloca ptr, align 8
  %omega1.0186_cache = alloca ptr, align 8
  %theta2.0185_cache = alloca ptr, align 8
  %omega2.0184_cache = alloca ptr, align 8
  %"mul38.i157'de" = alloca double, align 8
  store double 0.000000e+00, ptr %"mul38.i157'de", align 8
  %"sub3.i139'de" = alloca double, align 8
  store double 0.000000e+00, ptr %"sub3.i139'de", align 8
  %"add37.i156'de" = alloca double, align 8
  store double 0.000000e+00, ptr %"add37.i156'de", align 8
  %"mul13.i143'de" = alloca double, align 8
  store double 0.000000e+00, ptr %"mul13.i143'de", align 8
  %"add32.i154'de" = alloca double, align 8
  store double 0.000000e+00, ptr %"add32.i154'de", align 8
  %"mul36.i155'de" = alloca double, align 8
  store double 0.000000e+00, ptr %"mul36.i155'de", align 8
  %"mul15.i144'de" = alloca double, align 8
  store double 0.000000e+00, ptr %"mul15.i144'de", align 8
  %"'de22" = alloca double, align 8
  store double 0.000000e+00, ptr %"'de22", align 8
  %"mul28.i152'de" = alloca double, align 8
  store double 0.000000e+00, ptr %"mul28.i152'de", align 8
  %"mul31.i153'de" = alloca double, align 8
  store double 0.000000e+00, ptr %"mul31.i153'de", align 8
  %"'de23" = alloca double, align 8
  store double 0.000000e+00, ptr %"'de23", align 8
  %"add16'de" = alloca double, align 8
  store double 0.000000e+00, ptr %"add16'de", align 8
  %"mul17.i145'de" = alloca double, align 8
  store double 0.000000e+00, ptr %"mul17.i145'de", align 8
  %"sub22.i150'de" = alloca double, align 8
  store double 0.000000e+00, ptr %"sub22.i150'de", align 8
  %".neg.i149'de" = alloca double, align 8
  store double 0.000000e+00, ptr %".neg.i149'de", align 8
  %"'de25" = alloca double, align 8
  store double 0.000000e+00, ptr %"'de25", align 8
  %"add20.i147'de" = alloca double, align 8
  store double 0.000000e+00, ptr %"add20.i147'de", align 8
  %"mul11.neg.i148'de" = alloca double, align 8
  store double 0.000000e+00, ptr %"mul11.neg.i148'de", align 8
  %"mul7.i140'de" = alloca double, align 8
  store double 0.000000e+00, ptr %"mul7.i140'de", align 8
  %"'de26" = alloca double, align 8
  store double 0.000000e+00, ptr %"'de26", align 8
  %"mul19.i146'de" = alloca double, align 8
  store double 0.000000e+00, ptr %"mul19.i146'de", align 8
  %"'de27" = alloca double, align 8
  store double 0.000000e+00, ptr %"'de27", align 8
  %"sub10.i142'de" = alloca double, align 8
  store double 0.000000e+00, ptr %"sub10.i142'de", align 8
  %"mul9.i141'de" = alloca double, align 8
  store double 0.000000e+00, ptr %"mul9.i141'de", align 8
  %"add20'de" = alloca double, align 8
  store double 0.000000e+00, ptr %"add20'de", align 8
  %"'de28" = alloca double, align 8
  store double 0.000000e+00, ptr %"'de28", align 8
  %"'de29" = alloca double, align 8
  store double 0.000000e+00, ptr %"'de29", align 8
  %"mul1.i138'de" = alloca double, align 8
  store double 0.000000e+00, ptr %"mul1.i138'de", align 8
  %"sub.i137'de" = alloca double, align 8
  store double 0.000000e+00, ptr %"sub.i137'de", align 8
  %"mul21'de" = alloca double, align 8
  store double 0.000000e+00, ptr %"mul21'de", align 8
  %"mul19'de" = alloca double, align 8
  store double 0.000000e+00, ptr %"mul19'de", align 8
  %"mul17'de" = alloca double, align 8
  store double 0.000000e+00, ptr %"mul17'de", align 8
  %"mul15'de" = alloca double, align 8
  store double 0.000000e+00, ptr %"mul15'de", align 8
  %"mul38.i135'de" = alloca double, align 8
  store double 0.000000e+00, ptr %"mul38.i135'de", align 8
  %"sub3.i117'de" = alloca double, align 8
  store double 0.000000e+00, ptr %"sub3.i117'de", align 8
  %"add37.i134'de" = alloca double, align 8
  store double 0.000000e+00, ptr %"add37.i134'de", align 8
  %"mul13.i121'de" = alloca double, align 8
  store double 0.000000e+00, ptr %"mul13.i121'de", align 8
  %"add32.i132'de" = alloca double, align 8
  store double 0.000000e+00, ptr %"add32.i132'de", align 8
  %"mul36.i133'de" = alloca double, align 8
  store double 0.000000e+00, ptr %"mul36.i133'de", align 8
  %"mul15.i122'de" = alloca double, align 8
  store double 0.000000e+00, ptr %"mul15.i122'de", align 8
  %"'de30" = alloca double, align 8
  store double 0.000000e+00, ptr %"'de30", align 8
  %"mul28.i130'de" = alloca double, align 8
  store double 0.000000e+00, ptr %"mul28.i130'de", align 8
  %"mul31.i131'de" = alloca double, align 8
  store double 0.000000e+00, ptr %"mul31.i131'de", align 8
  %"'de31" = alloca double, align 8
  store double 0.000000e+00, ptr %"'de31", align 8
  %"add8'de" = alloca double, align 8
  store double 0.000000e+00, ptr %"add8'de", align 8
  %"mul17.i123'de" = alloca double, align 8
  store double 0.000000e+00, ptr %"mul17.i123'de", align 8
  %"sub22.i128'de" = alloca double, align 8
  store double 0.000000e+00, ptr %"sub22.i128'de", align 8
  %".neg.i127'de" = alloca double, align 8
  store double 0.000000e+00, ptr %".neg.i127'de", align 8
  %"'de32" = alloca double, align 8
  store double 0.000000e+00, ptr %"'de32", align 8
  %"add20.i125'de" = alloca double, align 8
  store double 0.000000e+00, ptr %"add20.i125'de", align 8
  %"mul11.neg.i126'de" = alloca double, align 8
  store double 0.000000e+00, ptr %"mul11.neg.i126'de", align 8
  %"mul7.i118'de" = alloca double, align 8
  store double 0.000000e+00, ptr %"mul7.i118'de", align 8
  %"'de33" = alloca double, align 8
  store double 0.000000e+00, ptr %"'de33", align 8
  %"mul19.i124'de" = alloca double, align 8
  store double 0.000000e+00, ptr %"mul19.i124'de", align 8
  %"'de34" = alloca double, align 8
  store double 0.000000e+00, ptr %"'de34", align 8
  %"sub10.i120'de" = alloca double, align 8
  store double 0.000000e+00, ptr %"sub10.i120'de", align 8
  %"mul9.i119'de" = alloca double, align 8
  store double 0.000000e+00, ptr %"mul9.i119'de", align 8
  %"add12'de" = alloca double, align 8
  store double 0.000000e+00, ptr %"add12'de", align 8
  %"'de35" = alloca double, align 8
  store double 0.000000e+00, ptr %"'de35", align 8
  %"'de36" = alloca double, align 8
  store double 0.000000e+00, ptr %"'de36", align 8
  %"mul1.i116'de" = alloca double, align 8
  store double 0.000000e+00, ptr %"mul1.i116'de", align 8
  %"sub.i115'de" = alloca double, align 8
  store double 0.000000e+00, ptr %"sub.i115'de", align 8
  %"mul13'de" = alloca double, align 8
  store double 0.000000e+00, ptr %"mul13'de", align 8
  %"mul11'de" = alloca double, align 8
  store double 0.000000e+00, ptr %"mul11'de", align 8
  %"mul9'de" = alloca double, align 8
  store double 0.000000e+00, ptr %"mul9'de", align 8
  %"mul7'de" = alloca double, align 8
  store double 0.000000e+00, ptr %"mul7'de", align 8
  %"mul38.i113'de" = alloca double, align 8
  store double 0.000000e+00, ptr %"mul38.i113'de", align 8
  %"sub3.i95'de" = alloca double, align 8
  store double 0.000000e+00, ptr %"sub3.i95'de", align 8
  %"add37.i112'de" = alloca double, align 8
  store double 0.000000e+00, ptr %"add37.i112'de", align 8
  %"mul13.i99'de" = alloca double, align 8
  store double 0.000000e+00, ptr %"mul13.i99'de", align 8
  %"add32.i110'de" = alloca double, align 8
  store double 0.000000e+00, ptr %"add32.i110'de", align 8
  %"mul28.i108'de" = alloca double, align 8
  store double 0.000000e+00, ptr %"mul28.i108'de", align 8
  %"mul36.i111'de" = alloca double, align 8
  store double 0.000000e+00, ptr %"mul36.i111'de", align 8
  %"mul31.i109'de" = alloca double, align 8
  store double 0.000000e+00, ptr %"mul31.i109'de", align 8
  %"mul15.i100'de" = alloca double, align 8
  store double 0.000000e+00, ptr %"mul15.i100'de", align 8
  %"'de37" = alloca double, align 8
  store double 0.000000e+00, ptr %"'de37", align 8
  %"'de38" = alloca double, align 8
  store double 0.000000e+00, ptr %"'de38", align 8
  %"add'de" = alloca double, align 8
  store double 0.000000e+00, ptr %"add'de", align 8
  %"mul17.i101'de" = alloca double, align 8
  store double 0.000000e+00, ptr %"mul17.i101'de", align 8
  %"sub22.i106'de" = alloca double, align 8
  store double 0.000000e+00, ptr %"sub22.i106'de", align 8
  %".neg.i105'de" = alloca double, align 8
  store double 0.000000e+00, ptr %".neg.i105'de", align 8
  %"'de39" = alloca double, align 8
  store double 0.000000e+00, ptr %"'de39", align 8
  %"add20.i103'de" = alloca double, align 8
  store double 0.000000e+00, ptr %"add20.i103'de", align 8
  %"mul11.neg.i104'de" = alloca double, align 8
  store double 0.000000e+00, ptr %"mul11.neg.i104'de", align 8
  %"mul7.i96'de" = alloca double, align 8
  store double 0.000000e+00, ptr %"mul7.i96'de", align 8
  %"'de40" = alloca double, align 8
  store double 0.000000e+00, ptr %"'de40", align 8
  %"mul19.i102'de" = alloca double, align 8
  store double 0.000000e+00, ptr %"mul19.i102'de", align 8
  %"'de41" = alloca double, align 8
  store double 0.000000e+00, ptr %"'de41", align 8
  %"sub10.i98'de" = alloca double, align 8
  store double 0.000000e+00, ptr %"sub10.i98'de", align 8
  %"mul9.i97'de" = alloca double, align 8
  store double 0.000000e+00, ptr %"mul9.i97'de", align 8
  %"add4'de" = alloca double, align 8
  store double 0.000000e+00, ptr %"add4'de", align 8
  %"'de42" = alloca double, align 8
  store double 0.000000e+00, ptr %"'de42", align 8
  %"'de43" = alloca double, align 8
  store double 0.000000e+00, ptr %"'de43", align 8
  %"mul1.i94'de" = alloca double, align 8
  store double 0.000000e+00, ptr %"mul1.i94'de", align 8
  %"sub.i93'de" = alloca double, align 8
  store double 0.000000e+00, ptr %"sub.i93'de", align 8
  %"mul5'de" = alloca double, align 8
  store double 0.000000e+00, ptr %"mul5'de", align 8
  %"mul3'de" = alloca double, align 8
  store double 0.000000e+00, ptr %"mul3'de", align 8
  %"mul1'de" = alloca double, align 8
  store double 0.000000e+00, ptr %"mul1'de", align 8
  %"mul'de" = alloca double, align 8
  store double 0.000000e+00, ptr %"mul'de", align 8
  %"mul38.i'de" = alloca double, align 8
  store double 0.000000e+00, ptr %"mul38.i'de", align 8
  %"sub3.i'de" = alloca double, align 8
  store double 0.000000e+00, ptr %"sub3.i'de", align 8
  %"add37.i'de" = alloca double, align 8
  store double 0.000000e+00, ptr %"add37.i'de", align 8
  %"mul13.i'de" = alloca double, align 8
  store double 0.000000e+00, ptr %"mul13.i'de", align 8
  %"add32.i'de" = alloca double, align 8
  store double 0.000000e+00, ptr %"add32.i'de", align 8
  %"mul36.i'de" = alloca double, align 8
  store double 0.000000e+00, ptr %"mul36.i'de", align 8
  %"'de44" = alloca double, align 8
  store double 0.000000e+00, ptr %"'de44", align 8
  %"mul15.i'de" = alloca double, align 8
  store double 0.000000e+00, ptr %"mul15.i'de", align 8
  %"mul31.i'de" = alloca double, align 8
  store double 0.000000e+00, ptr %"mul31.i'de", align 8
  %"mul28.i'de" = alloca double, align 8
  store double 0.000000e+00, ptr %"mul28.i'de", align 8
  %"'de45" = alloca double, align 8
  store double 0.000000e+00, ptr %"'de45", align 8
  %"mul17.i'de" = alloca double, align 8
  store double 0.000000e+00, ptr %"mul17.i'de", align 8
  %"sub22.i'de" = alloca double, align 8
  store double 0.000000e+00, ptr %"sub22.i'de", align 8
  %".neg.i'de" = alloca double, align 8
  store double 0.000000e+00, ptr %".neg.i'de", align 8
  %"'de46" = alloca double, align 8
  store double 0.000000e+00, ptr %"'de46", align 8
  %"add20.i'de" = alloca double, align 8
  store double 0.000000e+00, ptr %"add20.i'de", align 8
  %"mul11.neg.i'de" = alloca double, align 8
  store double 0.000000e+00, ptr %"mul11.neg.i'de", align 8
  %"mul7.i'de" = alloca double, align 8
  store double 0.000000e+00, ptr %"mul7.i'de", align 8
  %"'de47" = alloca double, align 8
  store double 0.000000e+00, ptr %"'de47", align 8
  %"mul19.i'de" = alloca double, align 8
  store double 0.000000e+00, ptr %"mul19.i'de", align 8
  %"'de48" = alloca double, align 8
  store double 0.000000e+00, ptr %"'de48", align 8
  %"sub10.i'de" = alloca double, align 8
  store double 0.000000e+00, ptr %"sub10.i'de", align 8
  %"mul9.i'de" = alloca double, align 8
  store double 0.000000e+00, ptr %"mul9.i'de", align 8
  %"'de49" = alloca double, align 8
  store double 0.000000e+00, ptr %"'de49", align 8
  %"'de50" = alloca double, align 8
  store double 0.000000e+00, ptr %"'de50", align 8
  %"mul1.i'de" = alloca double, align 8
  store double 0.000000e+00, ptr %"mul1.i'de", align 8
  %"sub.i'de" = alloca double, align 8
  store double 0.000000e+00, ptr %"sub.i'de", align 8
  %theta1.0187_malloccache = tail call noalias nonnull dereferenceable(8000) dereferenceable_or_null(8000) ptr @malloc(i64 8000), !enzyme_cache_alloc !18
  store ptr %theta1.0187_malloccache, ptr %theta1.0187_cache, align 8, !invariant.group !20
  %omega1.0186_malloccache = tail call noalias nonnull dereferenceable(8000) dereferenceable_or_null(8000) ptr @malloc(i64 8000), !enzyme_cache_alloc !21
  store ptr %omega1.0186_malloccache, ptr %omega1.0186_cache, align 8, !invariant.group !23
  %theta2.0185_malloccache = tail call noalias nonnull dereferenceable(8000) dereferenceable_or_null(8000) ptr @malloc(i64 8000), !enzyme_cache_alloc !24
  store ptr %theta2.0185_malloccache, ptr %theta2.0185_cache, align 8, !invariant.group !26
  %omega2.0184_malloccache = tail call noalias nonnull dereferenceable(8000) dereferenceable_or_null(8000) ptr @malloc(i64 8000), !enzyme_cache_alloc !27
  store ptr %omega2.0184_malloccache, ptr %omega2.0184_cache, align 8, !invariant.group !29
  br label %for.body

for.cond.cleanup:                                 ; preds = %for.body
  %0 = tail call fast double @llvm.sin.f64(double %add29) #10
  %1 = tail call fast double @llvm.sin.f64(double %add43) #10
  %add53 = fadd fast double %0, %1
  %2 = tail call fast double @llvm.cos.f64(double %add29) #10
  %3 = tail call fast double @llvm.cos.f64(double %add43) #10
  %4 = fadd fast double %3, %2
  %sub57 = fsub fast double 1.800000e+00, %4
  br label %invertfor.cond.cleanup

for.body:                                         ; preds = %for.body, %entry
  %iv = phi i64 [ %iv.next, %for.body ], [ 0, %entry ]
  %theta1.0187 = phi double [ 0x3FE921FB54442D18, %entry ], [ %add29, %for.body ]
  %omega1.0186 = phi double [ %omega1_0, %entry ], [ %add36, %for.body ]
  %theta2.0185 = phi double [ 0x3FE0C152382D7365, %entry ], [ %add43, %for.body ]
  %omega2.0184 = phi double [ %omega2_0, %entry ], [ %add50, %for.body ]
  %5 = load ptr, ptr %theta1.0187_cache, align 8, !dereferenceable !30, !invariant.group !20
  %6 = getelementptr inbounds double, ptr %5, i64 %iv
  store double %theta1.0187, ptr %6, align 8, !invariant.group !31
  %7 = load ptr, ptr %omega2.0184_cache, align 8, !dereferenceable !30, !invariant.group !29
  %8 = getelementptr inbounds double, ptr %7, i64 %iv
  store double %omega2.0184, ptr %8, align 8, !invariant.group !32
  %9 = load ptr, ptr %theta2.0185_cache, align 8, !dereferenceable !30, !invariant.group !26
  %10 = getelementptr inbounds double, ptr %9, i64 %iv
  store double %theta2.0185, ptr %10, align 8, !invariant.group !33
  %11 = load ptr, ptr %omega1.0186_cache, align 8, !dereferenceable !30, !invariant.group !23
  %12 = getelementptr inbounds double, ptr %11, i64 %iv
  store double %omega1.0186, ptr %12, align 8, !invariant.group !34
  %iv.next = add nuw i64 %iv, 1
  %13 = trunc i64 %iv to i32
  %sub.i = fsub fast double %theta1.0187, %theta2.0185
  %14 = tail call fast double @llvm.cos.f64(double %sub.i) #10
  %15 = tail call fast double @llvm.sin.f64(double %sub.i) #10
  %mul1.i = fmul fast double %sub.i, 2.000000e+00
  %16 = tail call fast double @llvm.cos.f64(double %mul1.i) #10
  %sub3.i = fsub fast double 3.000000e+00, %16
  %17 = tail call fast double @llvm.sin.f64(double %theta1.0187) #10
  %mul7.i = fmul fast double %17, -2.943000e+01
  %mul9.i = fmul fast double %theta2.0185, 2.000000e+00
  %sub10.i = fsub fast double %theta1.0187, %mul9.i
  %18 = tail call fast double @llvm.sin.f64(double %sub10.i) #10
  %mul13.i = fmul fast double %15, 2.000000e+00
  %mul15.i = fmul fast double %omega2.0184, %omega2.0184
  %mul17.i = fmul fast double %omega1.0186, %omega1.0186
  %mul19.i = fmul fast double %14, %mul17.i
  %add20.i = fadd fast double %mul19.i, %mul15.i
  %mul11.neg.i = fmul fast double %18, -9.810000e+00
  %.neg.i = fadd fast double %mul11.neg.i, %mul7.i
  %19 = fmul fast double %add20.i, %mul13.i
  %sub22.i = fsub fast double %.neg.i, %19
  %div.i = fdiv fast double %sub22.i, %sub3.i
  %mul28.i = fmul fast double %mul17.i, 2.000000e+00
  %20 = tail call fast double @llvm.cos.f64(double %theta1.0187) #10
  %mul31.i = fmul fast double %20, 1.962000e+01
  %add32.i = fadd fast double %mul31.i, %mul28.i
  %mul36.i = fmul fast double %14, %mul15.i
  %add37.i = fadd fast double %add32.i, %mul36.i
  %mul38.i = fmul fast double %add37.i, %mul13.i
  %div40.i = fdiv fast double %mul38.i, %sub3.i
  %mul = fmul fast double %omega1.0186, 5.000000e-04
  %add = fadd fast double %theta1.0187, %mul
  %mul1 = fmul fast double %div.i, 5.000000e-04
  %add2 = fadd fast double %mul1, %omega1.0186
  %mul3 = fmul fast double %omega2.0184, 5.000000e-04
  %add4 = fadd fast double %theta2.0185, %mul3
  %mul5 = fmul fast double %div40.i, 5.000000e-04
  %add6 = fadd fast double %mul5, %omega2.0184
  %sub.i93 = fsub fast double %add, %add4
  %21 = tail call fast double @llvm.cos.f64(double %sub.i93) #10
  %22 = tail call fast double @llvm.sin.f64(double %sub.i93) #10
  %mul1.i94 = fmul fast double %sub.i93, 2.000000e+00
  %23 = tail call fast double @llvm.cos.f64(double %mul1.i94) #10
  %sub3.i95 = fsub fast double 3.000000e+00, %23
  %24 = tail call fast double @llvm.sin.f64(double %add) #10
  %mul7.i96 = fmul fast double %24, -2.943000e+01
  %mul9.i97 = fmul fast double %add4, 2.000000e+00
  %sub10.i98 = fsub fast double %add, %mul9.i97
  %25 = tail call fast double @llvm.sin.f64(double %sub10.i98) #10
  %mul13.i99 = fmul fast double %22, 2.000000e+00
  %mul15.i100 = fmul fast double %add6, %add6
  %mul17.i101 = fmul fast double %add2, %add2
  %mul19.i102 = fmul fast double %mul17.i101, %21
  %add20.i103 = fadd fast double %mul19.i102, %mul15.i100
  %mul11.neg.i104 = fmul fast double %25, -9.810000e+00
  %.neg.i105 = fadd fast double %mul11.neg.i104, %mul7.i96
  %26 = fmul fast double %add20.i103, %mul13.i99
  %sub22.i106 = fsub fast double %.neg.i105, %26
  %div.i107 = fdiv fast double %sub22.i106, %sub3.i95
  %mul28.i108 = fmul fast double %mul17.i101, 2.000000e+00
  %27 = tail call fast double @llvm.cos.f64(double %add) #10
  %mul31.i109 = fmul fast double %27, 1.962000e+01
  %mul36.i111 = fmul fast double %mul15.i100, %21
  %add32.i110 = fadd fast double %mul36.i111, %mul31.i109
  %add37.i112 = fadd fast double %add32.i110, %mul28.i108
  %mul38.i113 = fmul fast double %add37.i112, %mul13.i99
  %div40.i114 = fdiv fast double %mul38.i113, %sub3.i95
  %mul7 = fmul fast double %add2, 5.000000e-04
  %add8 = fadd fast double %mul7, %theta1.0187
  %mul9 = fmul fast double %div.i107, 5.000000e-04
  %add10 = fadd fast double %mul9, %omega1.0186
  %mul11 = fmul fast double %add6, 5.000000e-04
  %add12 = fadd fast double %mul11, %theta2.0185
  %mul13 = fmul fast double %div40.i114, 5.000000e-04
  %add14 = fadd fast double %mul13, %omega2.0184
  %sub.i115 = fsub fast double %add8, %add12
  %28 = tail call fast double @llvm.cos.f64(double %sub.i115) #10
  %29 = tail call fast double @llvm.sin.f64(double %sub.i115) #10
  %mul1.i116 = fmul fast double %sub.i115, 2.000000e+00
  %30 = tail call fast double @llvm.cos.f64(double %mul1.i116) #10
  %sub3.i117 = fsub fast double 3.000000e+00, %30
  %31 = tail call fast double @llvm.sin.f64(double %add8) #10
  %mul7.i118 = fmul fast double %31, -2.943000e+01
  %mul9.i119 = fmul fast double %add12, 2.000000e+00
  %sub10.i120 = fsub fast double %add8, %mul9.i119
  %32 = tail call fast double @llvm.sin.f64(double %sub10.i120) #10
  %mul13.i121 = fmul fast double %29, 2.000000e+00
  %mul15.i122 = fmul fast double %add14, %add14
  %mul17.i123 = fmul fast double %add10, %add10
  %mul19.i124 = fmul fast double %mul17.i123, %28
  %add20.i125 = fadd fast double %mul19.i124, %mul15.i122
  %mul11.neg.i126 = fmul fast double %32, -9.810000e+00
  %.neg.i127 = fadd fast double %mul11.neg.i126, %mul7.i118
  %33 = fmul fast double %add20.i125, %mul13.i121
  %sub22.i128 = fsub fast double %.neg.i127, %33
  %div.i129 = fdiv fast double %sub22.i128, %sub3.i117
  %mul28.i130 = fmul fast double %mul17.i123, 2.000000e+00
  %34 = tail call fast double @llvm.cos.f64(double %add8) #10
  %mul31.i131 = fmul fast double %34, 1.962000e+01
  %add32.i132 = fadd fast double %mul28.i130, %mul31.i131
  %mul36.i133 = fmul fast double %mul15.i122, %28
  %add37.i134 = fadd fast double %add32.i132, %mul36.i133
  %mul38.i135 = fmul fast double %add37.i134, %mul13.i121
  %div40.i136 = fdiv fast double %mul38.i135, %sub3.i117
  %mul15 = fmul fast double %add10, 1.000000e-03
  %add16 = fadd fast double %mul15, %theta1.0187
  %mul17 = fmul fast double %div.i129, 1.000000e-03
  %add18 = fadd fast double %mul17, %omega1.0186
  %mul19 = fmul fast double %add14, 1.000000e-03
  %add20 = fadd fast double %mul19, %theta2.0185
  %mul21 = fmul fast double %div40.i136, 1.000000e-03
  %add22 = fadd fast double %mul21, %omega2.0184
  %sub.i137 = fsub fast double %add16, %add20
  %35 = tail call fast double @llvm.cos.f64(double %sub.i137) #10
  %36 = tail call fast double @llvm.sin.f64(double %sub.i137) #10
  %mul1.i138 = fmul fast double %sub.i137, 2.000000e+00
  %37 = tail call fast double @llvm.cos.f64(double %mul1.i138) #10
  %sub3.i139 = fsub fast double 3.000000e+00, %37
  %38 = tail call fast double @llvm.sin.f64(double %add16) #10
  %mul7.i140 = fmul fast double %38, -2.943000e+01
  %mul9.i141 = fmul fast double %add20, 2.000000e+00
  %sub10.i142 = fsub fast double %add16, %mul9.i141
  %39 = tail call fast double @llvm.sin.f64(double %sub10.i142) #10
  %mul13.i143 = fmul fast double %36, 2.000000e+00
  %mul15.i144 = fmul fast double %add22, %add22
  %mul17.i145 = fmul fast double %add18, %add18
  %mul19.i146 = fmul fast double %mul17.i145, %35
  %add20.i147 = fadd fast double %mul19.i146, %mul15.i144
  %mul11.neg.i148 = fmul fast double %39, -9.810000e+00
  %.neg.i149 = fadd fast double %mul11.neg.i148, %mul7.i140
  %40 = fmul fast double %add20.i147, %mul13.i143
  %sub22.i150 = fsub fast double %.neg.i149, %40
  %div.i151 = fdiv fast double %sub22.i150, %sub3.i139
  %mul28.i152 = fmul fast double %mul17.i145, 2.000000e+00
  %41 = tail call fast double @llvm.cos.f64(double %add16) #10
  %mul31.i153 = fmul fast double %41, 1.962000e+01
  %add32.i154 = fadd fast double %mul28.i152, %mul31.i153
  %mul36.i155 = fmul fast double %mul15.i144, %35
  %add37.i156 = fadd fast double %add32.i154, %mul36.i155
  %mul38.i157 = fmul fast double %add37.i156, %mul13.i143
  %div40.i158 = fdiv fast double %mul38.i157, %sub3.i139
  %reass.add = fadd fast double %add10, %add2
  %reass.mul = fmul fast double %reass.add, 2.000000e+00
  %add26 = fadd fast double %reass.mul, %omega1.0186
  %add27 = fadd fast double %add26, %add18
  %mul28 = fmul fast double %add27, 0x3F25D867C3ECE2A5
  %add29 = fadd fast double %mul28, %theta1.0187
  %reass.add177 = fadd fast double %div.i129, %div.i107
  %reass.mul178 = fmul fast double %reass.add177, 2.000000e+00
  %add33 = fadd fast double %reass.mul178, %div.i
  %add34 = fadd fast double %add33, %div.i151
  %mul35 = fmul fast double %add34, 0x3F25D867C3ECE2A5
  %add36 = fadd fast double %mul35, %omega1.0186
  %reass.add179 = fadd fast double %add14, %add6
  %reass.mul180 = fmul fast double %reass.add179, 2.000000e+00
  %add40 = fadd fast double %reass.mul180, %omega2.0184
  %add41 = fadd fast double %add40, %add22
  %mul42 = fmul fast double %add41, 0x3F25D867C3ECE2A5
  %add43 = fadd fast double %mul42, %theta2.0185
  %reass.add181 = fadd fast double %div40.i136, %div40.i114
  %reass.mul182 = fmul fast double %reass.add181, 2.000000e+00
  %add47 = fadd fast double %reass.mul182, %div40.i
  %add48 = fadd fast double %add47, %div40.i158
  %mul49 = fmul fast double %add48, 0x3F25D867C3ECE2A5
  %add50 = fadd fast double %mul49, %omega2.0184
  %inc = add nuw nsw i32 %13, 1
  %exitcond.not = icmp eq i32 %inc, 1000
  br i1 %exitcond.not, label %for.cond.cleanup, label %for.body, !llvm.loop !5

invertentry:                                      ; preds = %invertfor.body
  %42 = load double, ptr %"omega1_0'de", align 8
  %43 = load double, ptr %"omega2_0'de", align 8
  %44 = insertvalue { double, double } undef, double %42, 0
  %45 = insertvalue { double, double } %44, double %43, 1
  %46 = load i64, ptr %"iv'ac", align 8
  %forfree = load ptr, ptr %theta1.0187_cache, align 8, !dereferenceable !30, !invariant.group !20
  tail call void @free(ptr nonnull %forfree), !enzyme_cache_free !18
  %47 = load i64, ptr %"iv'ac", align 8
  %forfree9 = load ptr, ptr %omega1.0186_cache, align 8, !dereferenceable !30, !invariant.group !23
  tail call void @free(ptr nonnull %forfree9), !enzyme_cache_free !21
  %48 = load i64, ptr %"iv'ac", align 8
  %forfree13 = load ptr, ptr %theta2.0185_cache, align 8, !dereferenceable !30, !invariant.group !26
  tail call void @free(ptr nonnull %forfree13), !enzyme_cache_free !24
  %49 = load i64, ptr %"iv'ac", align 8
  %forfree17 = load ptr, ptr %omega2.0184_cache, align 8, !dereferenceable !30, !invariant.group !29
  tail call void @free(ptr nonnull %forfree17), !enzyme_cache_free !27
  ret { double, double } %45

invertfor.cond.cleanup:                           ; preds = %for.cond.cleanup
  store double %differeturn, ptr %"add65'de", align 8
  %50 = load double, ptr %"add65'de", align 8
  store double 0.000000e+00, ptr %"add65'de", align 8
  %51 = load double, ptr %"add60'de", align 8
  %52 = fadd fast double %51, %50
  store double %52, ptr %"add60'de", align 8
  %53 = load double, ptr %"mul58'de", align 8
  %54 = fadd fast double %53, %50
  store double %54, ptr %"mul58'de", align 8
  %55 = load double, ptr %"add60'de", align 8
  store double 0.000000e+00, ptr %"add60'de", align 8
  %56 = load double, ptr %"mul59'de", align 8
  %57 = fadd fast double %56, %55
  store double %57, ptr %"mul59'de", align 8
  %58 = load double, ptr %"mul64'de", align 8
  %59 = fadd fast double %58, %55
  store double %59, ptr %"mul64'de", align 8
  %60 = load double, ptr %"mul64'de", align 8
  store double 0.000000e+00, ptr %"mul64'de", align 8
  %61 = fmul fast double %60, 1.000000e-03
  %62 = load double, ptr %"add63'de", align 8
  %63 = fadd fast double %62, %61
  store double %63, ptr %"add63'de", align 8
  %64 = load double, ptr %"add63'de", align 8
  store double 0.000000e+00, ptr %"add63'de", align 8
  %65 = load double, ptr %"mul62'de", align 8
  %66 = fadd fast double %65, %64
  store double %66, ptr %"mul62'de", align 8
  %67 = load double, ptr %"mul61'de", align 8
  %68 = fadd fast double %67, %64
  store double %68, ptr %"mul61'de", align 8
  %69 = load double, ptr %"mul62'de", align 8
  store double 0.000000e+00, ptr %"mul62'de", align 8
  %70 = fmul fast double %69, %omega2_0
  %71 = load double, ptr %"omega2_0'de", align 8
  %72 = fadd fast double %71, %70
  store double %72, ptr %"omega2_0'de", align 8
  %73 = fmul fast double %69, %omega2_0
  %74 = load double, ptr %"omega2_0'de", align 8
  %75 = fadd fast double %74, %73
  store double %75, ptr %"omega2_0'de", align 8
  %76 = load double, ptr %"mul61'de", align 8
  store double 0.000000e+00, ptr %"mul61'de", align 8
  %77 = fmul fast double %76, %omega1_0
  %78 = load double, ptr %"omega1_0'de", align 8
  %79 = fadd fast double %78, %77
  store double %79, ptr %"omega1_0'de", align 8
  %80 = fmul fast double %76, %omega1_0
  %81 = load double, ptr %"omega1_0'de", align 8
  %82 = fadd fast double %81, %80
  store double %82, ptr %"omega1_0'de", align 8
  %83 = load double, ptr %"mul59'de", align 8
  store double 0.000000e+00, ptr %"mul59'de", align 8
  %84 = fmul fast double %83, %sub57
  %85 = load double, ptr %"sub57'de", align 8
  %86 = fadd fast double %85, %84
  store double %86, ptr %"sub57'de", align 8
  %87 = fmul fast double %83, %sub57
  %88 = load double, ptr %"sub57'de", align 8
  %89 = fadd fast double %88, %87
  store double %89, ptr %"sub57'de", align 8
  %90 = load double, ptr %"mul58'de", align 8
  store double 0.000000e+00, ptr %"mul58'de", align 8
  %91 = fmul fast double %90, %add53
  %92 = load double, ptr %"add53'de", align 8
  %93 = fadd fast double %92, %91
  store double %93, ptr %"add53'de", align 8
  %94 = fmul fast double %90, %add53
  %95 = load double, ptr %"add53'de", align 8
  %96 = fadd fast double %95, %94
  store double %96, ptr %"add53'de", align 8
  %97 = load double, ptr %"sub57'de", align 8
  store double 0.000000e+00, ptr %"sub57'de", align 8
  %98 = fneg fast double %97
  %99 = load double, ptr %"'de", align 8
  %100 = fadd fast double %99, %98
  store double %100, ptr %"'de", align 8
  %101 = load double, ptr %"'de", align 8
  store double 0.000000e+00, ptr %"'de", align 8
  %102 = load double, ptr %"'de1", align 8
  %103 = fadd fast double %102, %101
  store double %103, ptr %"'de1", align 8
  %104 = load double, ptr %"'de2", align 8
  %105 = fadd fast double %104, %101
  store double %105, ptr %"'de2", align 8
  %106 = load double, ptr %"'de1", align 8
  store double 0.000000e+00, ptr %"'de1", align 8
  %107 = call fast double @llvm.sin.f64(double %add43)
  %108 = fneg fast double %107
  %109 = fmul fast double %106, %108
  %110 = load double, ptr %"add43'de", align 8
  %111 = fadd fast double %110, %109
  store double %111, ptr %"add43'de", align 8
  %112 = load double, ptr %"'de2", align 8
  store double 0.000000e+00, ptr %"'de2", align 8
  %113 = call fast double @llvm.sin.f64(double %add29)
  %114 = fneg fast double %113
  %115 = fmul fast double %112, %114
  %116 = load double, ptr %"add29'de", align 8
  %117 = fadd fast double %116, %115
  store double %117, ptr %"add29'de", align 8
  %118 = load double, ptr %"add53'de", align 8
  store double 0.000000e+00, ptr %"add53'de", align 8
  %119 = load double, ptr %"'de3", align 8
  %120 = fadd fast double %119, %118
  store double %120, ptr %"'de3", align 8
  %121 = load double, ptr %"'de4", align 8
  %122 = fadd fast double %121, %118
  store double %122, ptr %"'de4", align 8
  %123 = load double, ptr %"'de4", align 8
  store double 0.000000e+00, ptr %"'de4", align 8
  %124 = call fast double @llvm.cos.f64(double %add43)
  %125 = fmul fast double %123, %124
  %126 = load double, ptr %"add43'de", align 8
  %127 = fadd fast double %126, %125
  store double %127, ptr %"add43'de", align 8
  %128 = load double, ptr %"'de3", align 8
  store double 0.000000e+00, ptr %"'de3", align 8
  %129 = call fast double @llvm.cos.f64(double %add29)
  %130 = fmul fast double %128, %129
  %131 = load double, ptr %"add29'de", align 8
  %132 = fadd fast double %131, %130
  store double %132, ptr %"add29'de", align 8
  br label %mergeinvertfor.body_for.cond.cleanup

mergeinvertfor.body_for.cond.cleanup:             ; preds = %invertfor.cond.cleanup
  store i64 999, ptr %"iv'ac", align 8
  br label %invertfor.body

invertfor.body:                                   ; preds = %incinvertfor.body, %mergeinvertfor.body_for.cond.cleanup
  %133 = load double, ptr %"add50'de", align 8
  store double 0.000000e+00, ptr %"add50'de", align 8
  %134 = load double, ptr %"mul49'de", align 8
  %135 = fadd fast double %134, %133
  store double %135, ptr %"mul49'de", align 8
  %136 = load double, ptr %"omega2.0184'de", align 8
  %137 = fadd fast double %136, %133
  store double %137, ptr %"omega2.0184'de", align 8
  %138 = load double, ptr %"mul49'de", align 8
  store double 0.000000e+00, ptr %"mul49'de", align 8
  %139 = fmul fast double %138, 0x3F25D867C3ECE2A5
  %140 = load double, ptr %"add48'de", align 8
  %141 = fadd fast double %140, %139
  store double %141, ptr %"add48'de", align 8
  %142 = load double, ptr %"add48'de", align 8
  store double 0.000000e+00, ptr %"add48'de", align 8
  %143 = load double, ptr %"add47'de", align 8
  %144 = fadd fast double %143, %142
  store double %144, ptr %"add47'de", align 8
  %145 = load double, ptr %"div40.i158'de", align 8
  %146 = fadd fast double %145, %142
  store double %146, ptr %"div40.i158'de", align 8
  %147 = load double, ptr %"add47'de", align 8
  store double 0.000000e+00, ptr %"add47'de", align 8
  %148 = load double, ptr %"reass.mul182'de", align 8
  %149 = fadd fast double %148, %147
  store double %149, ptr %"reass.mul182'de", align 8
  %150 = load double, ptr %"div40.i'de", align 8
  %151 = fadd fast double %150, %147
  store double %151, ptr %"div40.i'de", align 8
  %152 = load double, ptr %"reass.mul182'de", align 8
  store double 0.000000e+00, ptr %"reass.mul182'de", align 8
  %153 = fmul fast double %152, 2.000000e+00
  %154 = load double, ptr %"reass.add181'de", align 8
  %155 = fadd fast double %154, %153
  store double %155, ptr %"reass.add181'de", align 8
  %156 = load double, ptr %"reass.add181'de", align 8
  store double 0.000000e+00, ptr %"reass.add181'de", align 8
  %157 = load double, ptr %"div40.i136'de", align 8
  %158 = fadd fast double %157, %156
  store double %158, ptr %"div40.i136'de", align 8
  %159 = load double, ptr %"div40.i114'de", align 8
  %160 = fadd fast double %159, %156
  store double %160, ptr %"div40.i114'de", align 8
  %161 = load double, ptr %"add43'de", align 8
  store double 0.000000e+00, ptr %"add43'de", align 8
  %162 = load double, ptr %"mul42'de", align 8
  %163 = fadd fast double %162, %161
  store double %163, ptr %"mul42'de", align 8
  %164 = load double, ptr %"theta2.0185'de", align 8
  %165 = fadd fast double %164, %161
  store double %165, ptr %"theta2.0185'de", align 8
  %166 = load double, ptr %"mul42'de", align 8
  store double 0.000000e+00, ptr %"mul42'de", align 8
  %167 = fmul fast double %166, 0x3F25D867C3ECE2A5
  %168 = load double, ptr %"add41'de", align 8
  %169 = fadd fast double %168, %167
  store double %169, ptr %"add41'de", align 8
  %170 = load double, ptr %"add41'de", align 8
  store double 0.000000e+00, ptr %"add41'de", align 8
  %171 = load double, ptr %"add40'de", align 8
  %172 = fadd fast double %171, %170
  store double %172, ptr %"add40'de", align 8
  %173 = load double, ptr %"add22'de", align 8
  %174 = fadd fast double %173, %170
  store double %174, ptr %"add22'de", align 8
  %175 = load double, ptr %"add40'de", align 8
  store double 0.000000e+00, ptr %"add40'de", align 8
  %176 = load double, ptr %"reass.mul180'de", align 8
  %177 = fadd fast double %176, %175
  store double %177, ptr %"reass.mul180'de", align 8
  %178 = load double, ptr %"omega2.0184'de", align 8
  %179 = fadd fast double %178, %175
  store double %179, ptr %"omega2.0184'de", align 8
  %180 = load double, ptr %"reass.mul180'de", align 8
  store double 0.000000e+00, ptr %"reass.mul180'de", align 8
  %181 = fmul fast double %180, 2.000000e+00
  %182 = load double, ptr %"reass.add179'de", align 8
  %183 = fadd fast double %182, %181
  store double %183, ptr %"reass.add179'de", align 8
  %184 = load double, ptr %"reass.add179'de", align 8
  store double 0.000000e+00, ptr %"reass.add179'de", align 8
  %185 = load double, ptr %"add14'de", align 8
  %186 = fadd fast double %185, %184
  store double %186, ptr %"add14'de", align 8
  %187 = load double, ptr %"add6'de", align 8
  %188 = fadd fast double %187, %184
  store double %188, ptr %"add6'de", align 8
  %189 = load double, ptr %"add36'de", align 8
  store double 0.000000e+00, ptr %"add36'de", align 8
  %190 = load double, ptr %"mul35'de", align 8
  %191 = fadd fast double %190, %189
  store double %191, ptr %"mul35'de", align 8
  %192 = load double, ptr %"omega1.0186'de", align 8
  %193 = fadd fast double %192, %189
  store double %193, ptr %"omega1.0186'de", align 8
  %194 = load double, ptr %"mul35'de", align 8
  store double 0.000000e+00, ptr %"mul35'de", align 8
  %195 = fmul fast double %194, 0x3F25D867C3ECE2A5
  %196 = load double, ptr %"add34'de", align 8
  %197 = fadd fast double %196, %195
  store double %197, ptr %"add34'de", align 8
  %198 = load double, ptr %"add34'de", align 8
  store double 0.000000e+00, ptr %"add34'de", align 8
  %199 = load double, ptr %"add33'de", align 8
  %200 = fadd fast double %199, %198
  store double %200, ptr %"add33'de", align 8
  %201 = load double, ptr %"div.i151'de", align 8
  %202 = fadd fast double %201, %198
  store double %202, ptr %"div.i151'de", align 8
  %203 = load double, ptr %"add33'de", align 8
  store double 0.000000e+00, ptr %"add33'de", align 8
  %204 = load double, ptr %"reass.mul178'de", align 8
  %205 = fadd fast double %204, %203
  store double %205, ptr %"reass.mul178'de", align 8
  %206 = load double, ptr %"div.i'de", align 8
  %207 = fadd fast double %206, %203
  store double %207, ptr %"div.i'de", align 8
  %208 = load double, ptr %"reass.mul178'de", align 8
  store double 0.000000e+00, ptr %"reass.mul178'de", align 8
  %209 = fmul fast double %208, 2.000000e+00
  %210 = load double, ptr %"reass.add177'de", align 8
  %211 = fadd fast double %210, %209
  store double %211, ptr %"reass.add177'de", align 8
  %212 = load double, ptr %"reass.add177'de", align 8
  store double 0.000000e+00, ptr %"reass.add177'de", align 8
  %213 = load double, ptr %"div.i129'de", align 8
  %214 = fadd fast double %213, %212
  store double %214, ptr %"div.i129'de", align 8
  %215 = load double, ptr %"div.i107'de", align 8
  %216 = fadd fast double %215, %212
  store double %216, ptr %"div.i107'de", align 8
  %217 = load double, ptr %"add29'de", align 8
  store double 0.000000e+00, ptr %"add29'de", align 8
  %218 = load double, ptr %"mul28'de", align 8
  %219 = fadd fast double %218, %217
  store double %219, ptr %"mul28'de", align 8
  %220 = load double, ptr %"theta1.0187'de", align 8
  %221 = fadd fast double %220, %217
  store double %221, ptr %"theta1.0187'de", align 8
  %222 = load double, ptr %"mul28'de", align 8
  store double 0.000000e+00, ptr %"mul28'de", align 8
  %223 = fmul fast double %222, 0x3F25D867C3ECE2A5
  %224 = load double, ptr %"add27'de", align 8
  %225 = fadd fast double %224, %223
  store double %225, ptr %"add27'de", align 8
  %226 = load double, ptr %"add27'de", align 8
  store double 0.000000e+00, ptr %"add27'de", align 8
  %227 = load double, ptr %"add26'de", align 8
  %228 = fadd fast double %227, %226
  store double %228, ptr %"add26'de", align 8
  %229 = load double, ptr %"add18'de", align 8
  %230 = fadd fast double %229, %226
  store double %230, ptr %"add18'de", align 8
  %231 = load double, ptr %"add26'de", align 8
  store double 0.000000e+00, ptr %"add26'de", align 8
  %232 = load double, ptr %"reass.mul'de", align 8
  %233 = fadd fast double %232, %231
  store double %233, ptr %"reass.mul'de", align 8
  %234 = load double, ptr %"omega1.0186'de", align 8
  %235 = fadd fast double %234, %231
  store double %235, ptr %"omega1.0186'de", align 8
  %236 = load double, ptr %"reass.mul'de", align 8
  store double 0.000000e+00, ptr %"reass.mul'de", align 8
  %237 = fmul fast double %236, 2.000000e+00
  %238 = load double, ptr %"reass.add'de", align 8
  %239 = fadd fast double %238, %237
  store double %239, ptr %"reass.add'de", align 8
  %240 = load double, ptr %"reass.add'de", align 8
  store double 0.000000e+00, ptr %"reass.add'de", align 8
  %241 = load double, ptr %"add10'de", align 8
  %242 = fadd fast double %241, %240
  store double %242, ptr %"add10'de", align 8
  %243 = load double, ptr %"add2'de", align 8
  %244 = fadd fast double %243, %240
  store double %244, ptr %"add2'de", align 8
  %245 = load double, ptr %"div40.i158'de", align 8
  store double 0.000000e+00, ptr %"div40.i158'de", align 8
  %246 = load i64, ptr %"iv'ac", align 8
  %247 = load ptr, ptr %theta1.0187_cache, align 8, !dereferenceable !30, !invariant.group !20
  %248 = getelementptr inbounds double, ptr %247, i64 %246
  %249 = load double, ptr %248, align 8, !invariant.group !31
  %250 = load ptr, ptr %omega1.0186_cache, align 8, !dereferenceable !30, !invariant.group !23
  %251 = getelementptr inbounds double, ptr %250, i64 %246
  %252 = load double, ptr %251, align 8, !invariant.group !34
  %mul_unwrap = fmul fast double %252, 5.000000e-04
  %add_unwrap = fadd fast double %249, %mul_unwrap
  %253 = load ptr, ptr %theta2.0185_cache, align 8, !dereferenceable !30, !invariant.group !26
  %254 = getelementptr inbounds double, ptr %253, i64 %246
  %255 = load double, ptr %254, align 8, !invariant.group !33
  %256 = load ptr, ptr %omega2.0184_cache, align 8, !dereferenceable !30, !invariant.group !29
  %257 = getelementptr inbounds double, ptr %256, i64 %246
  %258 = load double, ptr %257, align 8, !invariant.group !32
  %mul3_unwrap = fmul fast double %258, 5.000000e-04
  %add4_unwrap = fadd fast double %255, %mul3_unwrap
  %mul9.i97_unwrap = fmul fast double %add4_unwrap, 2.000000e+00
  %sub10.i98_unwrap = fsub fast double %add_unwrap, %mul9.i97_unwrap
  %259 = tail call fast double @llvm.sin.f64(double %sub10.i98_unwrap) #10
  %mul11.neg.i104_unwrap = fmul fast double %259, -9.810000e+00
  %260 = tail call fast double @llvm.sin.f64(double %add_unwrap) #10
  %mul7.i96_unwrap = fmul fast double %260, -2.943000e+01
  %.neg.i105_unwrap = fadd fast double %mul11.neg.i104_unwrap, %mul7.i96_unwrap
  %mul9.i_unwrap = fmul fast double %255, 2.000000e+00
  %sub10.i_unwrap = fsub fast double %249, %mul9.i_unwrap
  %261 = tail call fast double @llvm.sin.f64(double %sub10.i_unwrap) #10
  %mul11.neg.i_unwrap = fmul fast double %261, -9.810000e+00
  %262 = tail call fast double @llvm.sin.f64(double %249) #10
  %mul7.i_unwrap = fmul fast double %262, -2.943000e+01
  %.neg.i_unwrap = fadd fast double %mul11.neg.i_unwrap, %mul7.i_unwrap
  %sub.i_unwrap = fsub fast double %249, %255
  %263 = tail call fast double @llvm.cos.f64(double %sub.i_unwrap) #10
  %mul17.i_unwrap = fmul fast double %252, %252
  %mul19.i_unwrap = fmul fast double %263, %mul17.i_unwrap
  %mul15.i_unwrap = fmul fast double %258, %258
  %add20.i_unwrap = fadd fast double %mul19.i_unwrap, %mul15.i_unwrap
  %264 = tail call fast double @llvm.sin.f64(double %sub.i_unwrap) #10
  %mul13.i_unwrap = fmul fast double %264, 2.000000e+00
  %_unwrap = fmul fast double %add20.i_unwrap, %mul13.i_unwrap
  %sub22.i_unwrap = fsub fast double %.neg.i_unwrap, %_unwrap
  %mul1.i_unwrap = fmul fast double %sub.i_unwrap, 2.000000e+00
  %265 = tail call fast double @llvm.cos.f64(double %mul1.i_unwrap) #10
  %sub3.i_unwrap = fsub fast double 3.000000e+00, %265
  %div.i_unwrap = fdiv fast double %sub22.i_unwrap, %sub3.i_unwrap
  %mul1_unwrap = fmul fast double %div.i_unwrap, 5.000000e-04
  %add2_unwrap = fadd fast double %mul1_unwrap, %252
  %mul17.i101_unwrap = fmul fast double %add2_unwrap, %add2_unwrap
  %sub.i93_unwrap = fsub fast double %add_unwrap, %add4_unwrap
  %266 = tail call fast double @llvm.cos.f64(double %sub.i93_unwrap) #10
  %mul19.i102_unwrap = fmul fast double %mul17.i101_unwrap, %266
  %267 = tail call fast double @llvm.cos.f64(double %249) #10
  %mul31.i_unwrap = fmul fast double %267, 1.962000e+01
  %mul28.i_unwrap = fmul fast double %mul17.i_unwrap, 2.000000e+00
  %add32.i_unwrap = fadd fast double %mul31.i_unwrap, %mul28.i_unwrap
  %mul36.i_unwrap = fmul fast double %263, %mul15.i_unwrap
  %add37.i_unwrap = fadd fast double %add32.i_unwrap, %mul36.i_unwrap
  %mul38.i_unwrap = fmul fast double %add37.i_unwrap, %mul13.i_unwrap
  %div40.i_unwrap = fdiv fast double %mul38.i_unwrap, %sub3.i_unwrap
  %mul5_unwrap = fmul fast double %div40.i_unwrap, 5.000000e-04
  %add6_unwrap = fadd fast double %mul5_unwrap, %258
  %mul15.i100_unwrap = fmul fast double %add6_unwrap, %add6_unwrap
  %add20.i103_unwrap = fadd fast double %mul19.i102_unwrap, %mul15.i100_unwrap
  %268 = tail call fast double @llvm.sin.f64(double %sub.i93_unwrap) #10
  %mul13.i99_unwrap = fmul fast double %268, 2.000000e+00
  %_unwrap20 = fmul fast double %add20.i103_unwrap, %mul13.i99_unwrap
  %sub22.i106_unwrap = fsub fast double %.neg.i105_unwrap, %_unwrap20
  %mul1.i94_unwrap = fmul fast double %sub.i93_unwrap, 2.000000e+00
  %269 = tail call fast double @llvm.cos.f64(double %mul1.i94_unwrap) #10
  %sub3.i95_unwrap = fsub fast double 3.000000e+00, %269
  %div.i107_unwrap = fdiv fast double %sub22.i106_unwrap, %sub3.i95_unwrap
  %mul9_unwrap = fmul fast double %div.i107_unwrap, 5.000000e-04
  %add10_unwrap = fadd fast double %mul9_unwrap, %252
  %mul15_unwrap = fmul fast double %add10_unwrap, 1.000000e-03
  %add16_unwrap = fadd fast double %mul15_unwrap, %249
  %mul36.i111_unwrap = fmul fast double %mul15.i100_unwrap, %266
  %270 = tail call fast double @llvm.cos.f64(double %add_unwrap) #10
  %mul31.i109_unwrap = fmul fast double %270, 1.962000e+01
  %add32.i110_unwrap = fadd fast double %mul36.i111_unwrap, %mul31.i109_unwrap
  %mul28.i108_unwrap = fmul fast double %mul17.i101_unwrap, 2.000000e+00
  %add37.i112_unwrap = fadd fast double %add32.i110_unwrap, %mul28.i108_unwrap
  %mul38.i113_unwrap = fmul fast double %add37.i112_unwrap, %mul13.i99_unwrap
  %div40.i114_unwrap = fdiv fast double %mul38.i113_unwrap, %sub3.i95_unwrap
  %mul13_unwrap = fmul fast double %div40.i114_unwrap, 5.000000e-04
  %add14_unwrap = fadd fast double %mul13_unwrap, %258
  %mul19_unwrap = fmul fast double %add14_unwrap, 1.000000e-03
  %add20_unwrap = fadd fast double %mul19_unwrap, %255
  %sub.i137_unwrap = fsub fast double %add16_unwrap, %add20_unwrap
  %mul1.i138_unwrap = fmul fast double %sub.i137_unwrap, 2.000000e+00
  %271 = tail call fast double @llvm.cos.f64(double %mul1.i138_unwrap) #10
  %sub3.i139_unwrap = fsub fast double 3.000000e+00, %271
  %272 = fdiv fast double %245, %sub3.i139_unwrap
  %273 = load double, ptr %"mul38.i157'de", align 8
  %274 = fadd fast double %273, %272
  store double %274, ptr %"mul38.i157'de", align 8
  %275 = fdiv fast double %245, %sub3.i139_unwrap
  %276 = load i64, ptr %"iv'ac", align 8
  %mul7_unwrap = fmul fast double %add2_unwrap, 5.000000e-04
  %add8_unwrap = fadd fast double %mul7_unwrap, %249
  %mul11_unwrap = fmul fast double %add6_unwrap, 5.000000e-04
  %add12_unwrap = fadd fast double %mul11_unwrap, %255
  %mul9.i119_unwrap = fmul fast double %add12_unwrap, 2.000000e+00
  %sub10.i120_unwrap = fsub fast double %add8_unwrap, %mul9.i119_unwrap
  %277 = tail call fast double @llvm.sin.f64(double %sub10.i120_unwrap) #10
  %mul11.neg.i126_unwrap = fmul fast double %277, -9.810000e+00
  %278 = tail call fast double @llvm.sin.f64(double %add8_unwrap) #10
  %mul7.i118_unwrap = fmul fast double %278, -2.943000e+01
  %.neg.i127_unwrap = fadd fast double %mul11.neg.i126_unwrap, %mul7.i118_unwrap
  %mul17.i123_unwrap = fmul fast double %add10_unwrap, %add10_unwrap
  %sub.i115_unwrap = fsub fast double %add8_unwrap, %add12_unwrap
  %279 = tail call fast double @llvm.cos.f64(double %sub.i115_unwrap) #10
  %mul19.i124_unwrap = fmul fast double %mul17.i123_unwrap, %279
  %mul15.i122_unwrap = fmul fast double %add14_unwrap, %add14_unwrap
  %add20.i125_unwrap = fadd fast double %mul19.i124_unwrap, %mul15.i122_unwrap
  %280 = tail call fast double @llvm.sin.f64(double %sub.i115_unwrap) #10
  %mul13.i121_unwrap = fmul fast double %280, 2.000000e+00
  %_unwrap21 = fmul fast double %add20.i125_unwrap, %mul13.i121_unwrap
  %sub22.i128_unwrap = fsub fast double %.neg.i127_unwrap, %_unwrap21
  %mul1.i116_unwrap = fmul fast double %sub.i115_unwrap, 2.000000e+00
  %281 = tail call fast double @llvm.cos.f64(double %mul1.i116_unwrap) #10
  %sub3.i117_unwrap = fsub fast double 3.000000e+00, %281
  %div.i129_unwrap = fdiv fast double %sub22.i128_unwrap, %sub3.i117_unwrap
  %mul17_unwrap = fmul fast double %div.i129_unwrap, 1.000000e-03
  %add18_unwrap = fadd fast double %mul17_unwrap, %252
  %mul17.i145_unwrap = fmul fast double %add18_unwrap, %add18_unwrap
  %mul28.i152_unwrap = fmul fast double %mul17.i145_unwrap, 2.000000e+00
  %282 = tail call fast double @llvm.cos.f64(double %add16_unwrap) #10
  %mul31.i153_unwrap = fmul fast double %282, 1.962000e+01
  %add32.i154_unwrap = fadd fast double %mul28.i152_unwrap, %mul31.i153_unwrap
  %mul28.i130_unwrap = fmul fast double %mul17.i123_unwrap, 2.000000e+00
  %283 = tail call fast double @llvm.cos.f64(double %add8_unwrap) #10
  %mul31.i131_unwrap = fmul fast double %283, 1.962000e+01
  %add32.i132_unwrap = fadd fast double %mul28.i130_unwrap, %mul31.i131_unwrap
  %mul36.i133_unwrap = fmul fast double %mul15.i122_unwrap, %279
  %add37.i134_unwrap = fadd fast double %add32.i132_unwrap, %mul36.i133_unwrap
  %mul38.i135_unwrap = fmul fast double %add37.i134_unwrap, %mul13.i121_unwrap
  %div40.i136_unwrap = fdiv fast double %mul38.i135_unwrap, %sub3.i117_unwrap
  %mul21_unwrap = fmul fast double %div40.i136_unwrap, 1.000000e-03
  %add22_unwrap = fadd fast double %mul21_unwrap, %258
  %mul15.i144_unwrap = fmul fast double %add22_unwrap, %add22_unwrap
  %284 = tail call fast double @llvm.cos.f64(double %sub.i137_unwrap) #10
  %mul36.i155_unwrap = fmul fast double %mul15.i144_unwrap, %284
  %add37.i156_unwrap = fadd fast double %add32.i154_unwrap, %mul36.i155_unwrap
  %285 = tail call fast double @llvm.sin.f64(double %sub.i137_unwrap) #10
  %mul13.i143_unwrap = fmul fast double %285, 2.000000e+00
  %mul38.i157_unwrap = fmul fast double %add37.i156_unwrap, %mul13.i143_unwrap
  %286 = fdiv fast double %mul38.i157_unwrap, %sub3.i139_unwrap
  %287 = fmul fast double %275, %286
  %288 = fneg fast double %287
  %289 = load double, ptr %"sub3.i139'de", align 8
  %290 = fadd fast double %289, %288
  store double %290, ptr %"sub3.i139'de", align 8
  %291 = load double, ptr %"mul38.i157'de", align 8
  store double 0.000000e+00, ptr %"mul38.i157'de", align 8
  %292 = fmul fast double %291, %mul13.i143_unwrap
  %293 = load double, ptr %"add37.i156'de", align 8
  %294 = fadd fast double %293, %292
  store double %294, ptr %"add37.i156'de", align 8
  %295 = fmul fast double %291, %add37.i156_unwrap
  %296 = load double, ptr %"mul13.i143'de", align 8
  %297 = fadd fast double %296, %295
  store double %297, ptr %"mul13.i143'de", align 8
  %298 = load double, ptr %"add37.i156'de", align 8
  store double 0.000000e+00, ptr %"add37.i156'de", align 8
  %299 = load double, ptr %"add32.i154'de", align 8
  %300 = fadd fast double %299, %298
  store double %300, ptr %"add32.i154'de", align 8
  %301 = load double, ptr %"mul36.i155'de", align 8
  %302 = fadd fast double %301, %298
  store double %302, ptr %"mul36.i155'de", align 8
  %303 = load double, ptr %"mul36.i155'de", align 8
  store double 0.000000e+00, ptr %"mul36.i155'de", align 8
  %304 = fmul fast double %303, %284
  %305 = load double, ptr %"mul15.i144'de", align 8
  %306 = fadd fast double %305, %304
  store double %306, ptr %"mul15.i144'de", align 8
  %307 = fmul fast double %303, %mul15.i144_unwrap
  %308 = load double, ptr %"'de22", align 8
  %309 = fadd fast double %308, %307
  store double %309, ptr %"'de22", align 8
  %310 = load double, ptr %"add32.i154'de", align 8
  store double 0.000000e+00, ptr %"add32.i154'de", align 8
  %311 = load double, ptr %"mul28.i152'de", align 8
  %312 = fadd fast double %311, %310
  store double %312, ptr %"mul28.i152'de", align 8
  %313 = load double, ptr %"mul31.i153'de", align 8
  %314 = fadd fast double %313, %310
  store double %314, ptr %"mul31.i153'de", align 8
  %315 = load double, ptr %"mul31.i153'de", align 8
  store double 0.000000e+00, ptr %"mul31.i153'de", align 8
  %316 = fmul fast double %315, 1.962000e+01
  %317 = load double, ptr %"'de23", align 8
  %318 = fadd fast double %317, %316
  store double %318, ptr %"'de23", align 8
  %319 = load double, ptr %"'de23", align 8
  store double 0.000000e+00, ptr %"'de23", align 8
  %320 = call fast double @llvm.sin.f64(double %add16_unwrap)
  %321 = fneg fast double %320
  %322 = fmul fast double %319, %321
  %323 = load double, ptr %"add16'de", align 8
  %324 = fadd fast double %323, %322
  store double %324, ptr %"add16'de", align 8
  %325 = load double, ptr %"mul28.i152'de", align 8
  store double 0.000000e+00, ptr %"mul28.i152'de", align 8
  %326 = fmul fast double %325, 2.000000e+00
  %327 = load double, ptr %"mul17.i145'de", align 8
  %328 = fadd fast double %327, %326
  store double %328, ptr %"mul17.i145'de", align 8
  %329 = load double, ptr %"div.i151'de", align 8
  store double 0.000000e+00, ptr %"div.i151'de", align 8
  %330 = fdiv fast double %329, %sub3.i139_unwrap
  %331 = load double, ptr %"sub22.i150'de", align 8
  %332 = fadd fast double %331, %330
  store double %332, ptr %"sub22.i150'de", align 8
  %333 = fdiv fast double %329, %sub3.i139_unwrap
  %334 = load i64, ptr %"iv'ac", align 8
  %mul9.i141_unwrap = fmul fast double %add20_unwrap, 2.000000e+00
  %sub10.i142_unwrap = fsub fast double %add16_unwrap, %mul9.i141_unwrap
  %335 = tail call fast double @llvm.sin.f64(double %sub10.i142_unwrap) #10
  %mul11.neg.i148_unwrap = fmul fast double %335, -9.810000e+00
  %336 = tail call fast double @llvm.sin.f64(double %add16_unwrap) #10
  %mul7.i140_unwrap = fmul fast double %336, -2.943000e+01
  %.neg.i149_unwrap = fadd fast double %mul11.neg.i148_unwrap, %mul7.i140_unwrap
  %mul19.i146_unwrap = fmul fast double %mul17.i145_unwrap, %284
  %add20.i147_unwrap = fadd fast double %mul19.i146_unwrap, %mul15.i144_unwrap
  %_unwrap24 = fmul fast double %add20.i147_unwrap, %mul13.i143_unwrap
  %sub22.i150_unwrap = fsub fast double %.neg.i149_unwrap, %_unwrap24
  %337 = fdiv fast double %sub22.i150_unwrap, %sub3.i139_unwrap
  %338 = fmul fast double %333, %337
  %339 = fneg fast double %338
  %340 = load double, ptr %"sub3.i139'de", align 8
  %341 = fadd fast double %340, %339
  store double %341, ptr %"sub3.i139'de", align 8
  %342 = load double, ptr %"sub22.i150'de", align 8
  store double 0.000000e+00, ptr %"sub22.i150'de", align 8
  %343 = load double, ptr %".neg.i149'de", align 8
  %344 = fadd fast double %343, %342
  store double %344, ptr %".neg.i149'de", align 8
  %345 = fneg fast double %342
  %346 = load double, ptr %"'de25", align 8
  %347 = fadd fast double %346, %345
  store double %347, ptr %"'de25", align 8
  %348 = load double, ptr %"'de25", align 8
  store double 0.000000e+00, ptr %"'de25", align 8
  %349 = fmul fast double %348, %mul13.i143_unwrap
  %350 = load double, ptr %"add20.i147'de", align 8
  %351 = fadd fast double %350, %349
  store double %351, ptr %"add20.i147'de", align 8
  %352 = fmul fast double %348, %add20.i147_unwrap
  %353 = load double, ptr %"mul13.i143'de", align 8
  %354 = fadd fast double %353, %352
  store double %354, ptr %"mul13.i143'de", align 8
  %355 = load double, ptr %".neg.i149'de", align 8
  store double 0.000000e+00, ptr %".neg.i149'de", align 8
  %356 = load double, ptr %"mul11.neg.i148'de", align 8
  %357 = fadd fast double %356, %355
  store double %357, ptr %"mul11.neg.i148'de", align 8
  %358 = load double, ptr %"mul7.i140'de", align 8
  %359 = fadd fast double %358, %355
  store double %359, ptr %"mul7.i140'de", align 8
  %360 = load double, ptr %"mul11.neg.i148'de", align 8
  store double 0.000000e+00, ptr %"mul11.neg.i148'de", align 8
  %361 = fmul fast double %360, -9.810000e+00
  %362 = load double, ptr %"'de26", align 8
  %363 = fadd fast double %362, %361
  store double %363, ptr %"'de26", align 8
  %364 = load double, ptr %"add20.i147'de", align 8
  store double 0.000000e+00, ptr %"add20.i147'de", align 8
  %365 = load double, ptr %"mul19.i146'de", align 8
  %366 = fadd fast double %365, %364
  store double %366, ptr %"mul19.i146'de", align 8
  %367 = load double, ptr %"mul15.i144'de", align 8
  %368 = fadd fast double %367, %364
  store double %368, ptr %"mul15.i144'de", align 8
  %369 = load double, ptr %"mul19.i146'de", align 8
  store double 0.000000e+00, ptr %"mul19.i146'de", align 8
  %370 = fmul fast double %369, %284
  %371 = load double, ptr %"mul17.i145'de", align 8
  %372 = fadd fast double %371, %370
  store double %372, ptr %"mul17.i145'de", align 8
  %373 = fmul fast double %369, %mul17.i145_unwrap
  %374 = load double, ptr %"'de22", align 8
  %375 = fadd fast double %374, %373
  store double %375, ptr %"'de22", align 8
  %376 = load double, ptr %"mul17.i145'de", align 8
  store double 0.000000e+00, ptr %"mul17.i145'de", align 8
  %377 = fmul fast double %376, %add18_unwrap
  %378 = load double, ptr %"add18'de", align 8
  %379 = fadd fast double %378, %377
  store double %379, ptr %"add18'de", align 8
  %380 = fmul fast double %376, %add18_unwrap
  %381 = load double, ptr %"add18'de", align 8
  %382 = fadd fast double %381, %380
  store double %382, ptr %"add18'de", align 8
  %383 = load double, ptr %"mul15.i144'de", align 8
  store double 0.000000e+00, ptr %"mul15.i144'de", align 8
  %384 = fmul fast double %383, %add22_unwrap
  %385 = load double, ptr %"add22'de", align 8
  %386 = fadd fast double %385, %384
  store double %386, ptr %"add22'de", align 8
  %387 = fmul fast double %383, %add22_unwrap
  %388 = load double, ptr %"add22'de", align 8
  %389 = fadd fast double %388, %387
  store double %389, ptr %"add22'de", align 8
  %390 = load double, ptr %"mul13.i143'de", align 8
  store double 0.000000e+00, ptr %"mul13.i143'de", align 8
  %391 = fmul fast double %390, 2.000000e+00
  %392 = load double, ptr %"'de27", align 8
  %393 = fadd fast double %392, %391
  store double %393, ptr %"'de27", align 8
  %394 = load double, ptr %"'de26", align 8
  store double 0.000000e+00, ptr %"'de26", align 8
  %395 = call fast double @llvm.cos.f64(double %sub10.i142_unwrap)
  %396 = fmul fast double %394, %395
  %397 = load double, ptr %"sub10.i142'de", align 8
  %398 = fadd fast double %397, %396
  store double %398, ptr %"sub10.i142'de", align 8
  %399 = load double, ptr %"sub10.i142'de", align 8
  store double 0.000000e+00, ptr %"sub10.i142'de", align 8
  %400 = load double, ptr %"add16'de", align 8
  %401 = fadd fast double %400, %399
  store double %401, ptr %"add16'de", align 8
  %402 = fneg fast double %399
  %403 = load double, ptr %"mul9.i141'de", align 8
  %404 = fadd fast double %403, %402
  store double %404, ptr %"mul9.i141'de", align 8
  %405 = load double, ptr %"mul9.i141'de", align 8
  store double 0.000000e+00, ptr %"mul9.i141'de", align 8
  %406 = fmul fast double %405, 2.000000e+00
  %407 = load double, ptr %"add20'de", align 8
  %408 = fadd fast double %407, %406
  store double %408, ptr %"add20'de", align 8
  %409 = load double, ptr %"mul7.i140'de", align 8
  store double 0.000000e+00, ptr %"mul7.i140'de", align 8
  %410 = fmul fast double %409, -2.943000e+01
  %411 = load double, ptr %"'de28", align 8
  %412 = fadd fast double %411, %410
  store double %412, ptr %"'de28", align 8
  %413 = load double, ptr %"'de28", align 8
  store double 0.000000e+00, ptr %"'de28", align 8
  %414 = call fast double @llvm.cos.f64(double %add16_unwrap)
  %415 = fmul fast double %413, %414
  %416 = load double, ptr %"add16'de", align 8
  %417 = fadd fast double %416, %415
  store double %417, ptr %"add16'de", align 8
  %418 = load double, ptr %"sub3.i139'de", align 8
  store double 0.000000e+00, ptr %"sub3.i139'de", align 8
  %419 = fneg fast double %418
  %420 = load double, ptr %"'de29", align 8
  %421 = fadd fast double %420, %419
  store double %421, ptr %"'de29", align 8
  %422 = load double, ptr %"'de29", align 8
  store double 0.000000e+00, ptr %"'de29", align 8
  %423 = call fast double @llvm.sin.f64(double %mul1.i138_unwrap)
  %424 = fneg fast double %423
  %425 = fmul fast double %422, %424
  %426 = load double, ptr %"mul1.i138'de", align 8
  %427 = fadd fast double %426, %425
  store double %427, ptr %"mul1.i138'de", align 8
  %428 = load double, ptr %"mul1.i138'de", align 8
  store double 0.000000e+00, ptr %"mul1.i138'de", align 8
  %429 = fmul fast double %428, 2.000000e+00
  %430 = load double, ptr %"sub.i137'de", align 8
  %431 = fadd fast double %430, %429
  store double %431, ptr %"sub.i137'de", align 8
  %432 = load double, ptr %"'de27", align 8
  store double 0.000000e+00, ptr %"'de27", align 8
  %433 = call fast double @llvm.cos.f64(double %sub.i137_unwrap)
  %434 = fmul fast double %432, %433
  %435 = load double, ptr %"sub.i137'de", align 8
  %436 = fadd fast double %435, %434
  store double %436, ptr %"sub.i137'de", align 8
  %437 = load double, ptr %"'de22", align 8
  store double 0.000000e+00, ptr %"'de22", align 8
  %438 = call fast double @llvm.sin.f64(double %sub.i137_unwrap)
  %439 = fneg fast double %438
  %440 = fmul fast double %437, %439
  %441 = load double, ptr %"sub.i137'de", align 8
  %442 = fadd fast double %441, %440
  store double %442, ptr %"sub.i137'de", align 8
  %443 = load double, ptr %"sub.i137'de", align 8
  store double 0.000000e+00, ptr %"sub.i137'de", align 8
  %444 = load double, ptr %"add16'de", align 8
  %445 = fadd fast double %444, %443
  store double %445, ptr %"add16'de", align 8
  %446 = fneg fast double %443
  %447 = load double, ptr %"add20'de", align 8
  %448 = fadd fast double %447, %446
  store double %448, ptr %"add20'de", align 8
  %449 = load double, ptr %"add22'de", align 8
  store double 0.000000e+00, ptr %"add22'de", align 8
  %450 = load double, ptr %"mul21'de", align 8
  %451 = fadd fast double %450, %449
  store double %451, ptr %"mul21'de", align 8
  %452 = load double, ptr %"omega2.0184'de", align 8
  %453 = fadd fast double %452, %449
  store double %453, ptr %"omega2.0184'de", align 8
  %454 = load double, ptr %"mul21'de", align 8
  store double 0.000000e+00, ptr %"mul21'de", align 8
  %455 = fmul fast double %454, 1.000000e-03
  %456 = load double, ptr %"div40.i136'de", align 8
  %457 = fadd fast double %456, %455
  store double %457, ptr %"div40.i136'de", align 8
  %458 = load double, ptr %"add20'de", align 8
  store double 0.000000e+00, ptr %"add20'de", align 8
  %459 = load double, ptr %"mul19'de", align 8
  %460 = fadd fast double %459, %458
  store double %460, ptr %"mul19'de", align 8
  %461 = load double, ptr %"theta2.0185'de", align 8
  %462 = fadd fast double %461, %458
  store double %462, ptr %"theta2.0185'de", align 8
  %463 = load double, ptr %"mul19'de", align 8
  store double 0.000000e+00, ptr %"mul19'de", align 8
  %464 = fmul fast double %463, 1.000000e-03
  %465 = load double, ptr %"add14'de", align 8
  %466 = fadd fast double %465, %464
  store double %466, ptr %"add14'de", align 8
  %467 = load double, ptr %"add18'de", align 8
  store double 0.000000e+00, ptr %"add18'de", align 8
  %468 = load double, ptr %"mul17'de", align 8
  %469 = fadd fast double %468, %467
  store double %469, ptr %"mul17'de", align 8
  %470 = load double, ptr %"omega1.0186'de", align 8
  %471 = fadd fast double %470, %467
  store double %471, ptr %"omega1.0186'de", align 8
  %472 = load double, ptr %"mul17'de", align 8
  store double 0.000000e+00, ptr %"mul17'de", align 8
  %473 = fmul fast double %472, 1.000000e-03
  %474 = load double, ptr %"div.i129'de", align 8
  %475 = fadd fast double %474, %473
  store double %475, ptr %"div.i129'de", align 8
  %476 = load double, ptr %"add16'de", align 8
  store double 0.000000e+00, ptr %"add16'de", align 8
  %477 = load double, ptr %"mul15'de", align 8
  %478 = fadd fast double %477, %476
  store double %478, ptr %"mul15'de", align 8
  %479 = load double, ptr %"theta1.0187'de", align 8
  %480 = fadd fast double %479, %476
  store double %480, ptr %"theta1.0187'de", align 8
  %481 = load double, ptr %"mul15'de", align 8
  store double 0.000000e+00, ptr %"mul15'de", align 8
  %482 = fmul fast double %481, 1.000000e-03
  %483 = load double, ptr %"add10'de", align 8
  %484 = fadd fast double %483, %482
  store double %484, ptr %"add10'de", align 8
  %485 = load double, ptr %"div40.i136'de", align 8
  store double 0.000000e+00, ptr %"div40.i136'de", align 8
  %486 = fdiv fast double %485, %sub3.i117_unwrap
  %487 = load double, ptr %"mul38.i135'de", align 8
  %488 = fadd fast double %487, %486
  store double %488, ptr %"mul38.i135'de", align 8
  %489 = fdiv fast double %485, %sub3.i117_unwrap
  %490 = fdiv fast double %mul38.i135_unwrap, %sub3.i117_unwrap
  %491 = fmul fast double %489, %490
  %492 = fneg fast double %491
  %493 = load double, ptr %"sub3.i117'de", align 8
  %494 = fadd fast double %493, %492
  store double %494, ptr %"sub3.i117'de", align 8
  %495 = load double, ptr %"mul38.i135'de", align 8
  store double 0.000000e+00, ptr %"mul38.i135'de", align 8
  %496 = fmul fast double %495, %mul13.i121_unwrap
  %497 = load double, ptr %"add37.i134'de", align 8
  %498 = fadd fast double %497, %496
  store double %498, ptr %"add37.i134'de", align 8
  %499 = fmul fast double %495, %add37.i134_unwrap
  %500 = load double, ptr %"mul13.i121'de", align 8
  %501 = fadd fast double %500, %499
  store double %501, ptr %"mul13.i121'de", align 8
  %502 = load double, ptr %"add37.i134'de", align 8
  store double 0.000000e+00, ptr %"add37.i134'de", align 8
  %503 = load double, ptr %"add32.i132'de", align 8
  %504 = fadd fast double %503, %502
  store double %504, ptr %"add32.i132'de", align 8
  %505 = load double, ptr %"mul36.i133'de", align 8
  %506 = fadd fast double %505, %502
  store double %506, ptr %"mul36.i133'de", align 8
  %507 = load double, ptr %"mul36.i133'de", align 8
  store double 0.000000e+00, ptr %"mul36.i133'de", align 8
  %508 = fmul fast double %507, %279
  %509 = load double, ptr %"mul15.i122'de", align 8
  %510 = fadd fast double %509, %508
  store double %510, ptr %"mul15.i122'de", align 8
  %511 = fmul fast double %507, %mul15.i122_unwrap
  %512 = load double, ptr %"'de30", align 8
  %513 = fadd fast double %512, %511
  store double %513, ptr %"'de30", align 8
  %514 = load double, ptr %"add32.i132'de", align 8
  store double 0.000000e+00, ptr %"add32.i132'de", align 8
  %515 = load double, ptr %"mul28.i130'de", align 8
  %516 = fadd fast double %515, %514
  store double %516, ptr %"mul28.i130'de", align 8
  %517 = load double, ptr %"mul31.i131'de", align 8
  %518 = fadd fast double %517, %514
  store double %518, ptr %"mul31.i131'de", align 8
  %519 = load double, ptr %"mul31.i131'de", align 8
  store double 0.000000e+00, ptr %"mul31.i131'de", align 8
  %520 = fmul fast double %519, 1.962000e+01
  %521 = load double, ptr %"'de31", align 8
  %522 = fadd fast double %521, %520
  store double %522, ptr %"'de31", align 8
  %523 = load double, ptr %"'de31", align 8
  store double 0.000000e+00, ptr %"'de31", align 8
  %524 = call fast double @llvm.sin.f64(double %add8_unwrap)
  %525 = fneg fast double %524
  %526 = fmul fast double %523, %525
  %527 = load double, ptr %"add8'de", align 8
  %528 = fadd fast double %527, %526
  store double %528, ptr %"add8'de", align 8
  %529 = load double, ptr %"mul28.i130'de", align 8
  store double 0.000000e+00, ptr %"mul28.i130'de", align 8
  %530 = fmul fast double %529, 2.000000e+00
  %531 = load double, ptr %"mul17.i123'de", align 8
  %532 = fadd fast double %531, %530
  store double %532, ptr %"mul17.i123'de", align 8
  %533 = load double, ptr %"div.i129'de", align 8
  store double 0.000000e+00, ptr %"div.i129'de", align 8
  %534 = fdiv fast double %533, %sub3.i117_unwrap
  %535 = load double, ptr %"sub22.i128'de", align 8
  %536 = fadd fast double %535, %534
  store double %536, ptr %"sub22.i128'de", align 8
  %537 = fdiv fast double %533, %sub3.i117_unwrap
  %538 = fdiv fast double %sub22.i128_unwrap, %sub3.i117_unwrap
  %539 = fmul fast double %537, %538
  %540 = fneg fast double %539
  %541 = load double, ptr %"sub3.i117'de", align 8
  %542 = fadd fast double %541, %540
  store double %542, ptr %"sub3.i117'de", align 8
  %543 = load double, ptr %"sub22.i128'de", align 8
  store double 0.000000e+00, ptr %"sub22.i128'de", align 8
  %544 = load double, ptr %".neg.i127'de", align 8
  %545 = fadd fast double %544, %543
  store double %545, ptr %".neg.i127'de", align 8
  %546 = fneg fast double %543
  %547 = load double, ptr %"'de32", align 8
  %548 = fadd fast double %547, %546
  store double %548, ptr %"'de32", align 8
  %549 = load double, ptr %"'de32", align 8
  store double 0.000000e+00, ptr %"'de32", align 8
  %550 = fmul fast double %549, %mul13.i121_unwrap
  %551 = load double, ptr %"add20.i125'de", align 8
  %552 = fadd fast double %551, %550
  store double %552, ptr %"add20.i125'de", align 8
  %553 = fmul fast double %549, %add20.i125_unwrap
  %554 = load double, ptr %"mul13.i121'de", align 8
  %555 = fadd fast double %554, %553
  store double %555, ptr %"mul13.i121'de", align 8
  %556 = load double, ptr %".neg.i127'de", align 8
  store double 0.000000e+00, ptr %".neg.i127'de", align 8
  %557 = load double, ptr %"mul11.neg.i126'de", align 8
  %558 = fadd fast double %557, %556
  store double %558, ptr %"mul11.neg.i126'de", align 8
  %559 = load double, ptr %"mul7.i118'de", align 8
  %560 = fadd fast double %559, %556
  store double %560, ptr %"mul7.i118'de", align 8
  %561 = load double, ptr %"mul11.neg.i126'de", align 8
  store double 0.000000e+00, ptr %"mul11.neg.i126'de", align 8
  %562 = fmul fast double %561, -9.810000e+00
  %563 = load double, ptr %"'de33", align 8
  %564 = fadd fast double %563, %562
  store double %564, ptr %"'de33", align 8
  %565 = load double, ptr %"add20.i125'de", align 8
  store double 0.000000e+00, ptr %"add20.i125'de", align 8
  %566 = load double, ptr %"mul19.i124'de", align 8
  %567 = fadd fast double %566, %565
  store double %567, ptr %"mul19.i124'de", align 8
  %568 = load double, ptr %"mul15.i122'de", align 8
  %569 = fadd fast double %568, %565
  store double %569, ptr %"mul15.i122'de", align 8
  %570 = load double, ptr %"mul19.i124'de", align 8
  store double 0.000000e+00, ptr %"mul19.i124'de", align 8
  %571 = fmul fast double %570, %279
  %572 = load double, ptr %"mul17.i123'de", align 8
  %573 = fadd fast double %572, %571
  store double %573, ptr %"mul17.i123'de", align 8
  %574 = fmul fast double %570, %mul17.i123_unwrap
  %575 = load double, ptr %"'de30", align 8
  %576 = fadd fast double %575, %574
  store double %576, ptr %"'de30", align 8
  %577 = load double, ptr %"mul17.i123'de", align 8
  store double 0.000000e+00, ptr %"mul17.i123'de", align 8
  %578 = fmul fast double %577, %add10_unwrap
  %579 = load double, ptr %"add10'de", align 8
  %580 = fadd fast double %579, %578
  store double %580, ptr %"add10'de", align 8
  %581 = fmul fast double %577, %add10_unwrap
  %582 = load double, ptr %"add10'de", align 8
  %583 = fadd fast double %582, %581
  store double %583, ptr %"add10'de", align 8
  %584 = load double, ptr %"mul15.i122'de", align 8
  store double 0.000000e+00, ptr %"mul15.i122'de", align 8
  %585 = fmul fast double %584, %add14_unwrap
  %586 = load double, ptr %"add14'de", align 8
  %587 = fadd fast double %586, %585
  store double %587, ptr %"add14'de", align 8
  %588 = fmul fast double %584, %add14_unwrap
  %589 = load double, ptr %"add14'de", align 8
  %590 = fadd fast double %589, %588
  store double %590, ptr %"add14'de", align 8
  %591 = load double, ptr %"mul13.i121'de", align 8
  store double 0.000000e+00, ptr %"mul13.i121'de", align 8
  %592 = fmul fast double %591, 2.000000e+00
  %593 = load double, ptr %"'de34", align 8
  %594 = fadd fast double %593, %592
  store double %594, ptr %"'de34", align 8
  %595 = load double, ptr %"'de33", align 8
  store double 0.000000e+00, ptr %"'de33", align 8
  %596 = call fast double @llvm.cos.f64(double %sub10.i120_unwrap)
  %597 = fmul fast double %595, %596
  %598 = load double, ptr %"sub10.i120'de", align 8
  %599 = fadd fast double %598, %597
  store double %599, ptr %"sub10.i120'de", align 8
  %600 = load double, ptr %"sub10.i120'de", align 8
  store double 0.000000e+00, ptr %"sub10.i120'de", align 8
  %601 = load double, ptr %"add8'de", align 8
  %602 = fadd fast double %601, %600
  store double %602, ptr %"add8'de", align 8
  %603 = fneg fast double %600
  %604 = load double, ptr %"mul9.i119'de", align 8
  %605 = fadd fast double %604, %603
  store double %605, ptr %"mul9.i119'de", align 8
  %606 = load double, ptr %"mul9.i119'de", align 8
  store double 0.000000e+00, ptr %"mul9.i119'de", align 8
  %607 = fmul fast double %606, 2.000000e+00
  %608 = load double, ptr %"add12'de", align 8
  %609 = fadd fast double %608, %607
  store double %609, ptr %"add12'de", align 8
  %610 = load double, ptr %"mul7.i118'de", align 8
  store double 0.000000e+00, ptr %"mul7.i118'de", align 8
  %611 = fmul fast double %610, -2.943000e+01
  %612 = load double, ptr %"'de35", align 8
  %613 = fadd fast double %612, %611
  store double %613, ptr %"'de35", align 8
  %614 = load double, ptr %"'de35", align 8
  store double 0.000000e+00, ptr %"'de35", align 8
  %615 = call fast double @llvm.cos.f64(double %add8_unwrap)
  %616 = fmul fast double %614, %615
  %617 = load double, ptr %"add8'de", align 8
  %618 = fadd fast double %617, %616
  store double %618, ptr %"add8'de", align 8
  %619 = load double, ptr %"sub3.i117'de", align 8
  store double 0.000000e+00, ptr %"sub3.i117'de", align 8
  %620 = fneg fast double %619
  %621 = load double, ptr %"'de36", align 8
  %622 = fadd fast double %621, %620
  store double %622, ptr %"'de36", align 8
  %623 = load double, ptr %"'de36", align 8
  store double 0.000000e+00, ptr %"'de36", align 8
  %624 = call fast double @llvm.sin.f64(double %mul1.i116_unwrap)
  %625 = fneg fast double %624
  %626 = fmul fast double %623, %625
  %627 = load double, ptr %"mul1.i116'de", align 8
  %628 = fadd fast double %627, %626
  store double %628, ptr %"mul1.i116'de", align 8
  %629 = load double, ptr %"mul1.i116'de", align 8
  store double 0.000000e+00, ptr %"mul1.i116'de", align 8
  %630 = fmul fast double %629, 2.000000e+00
  %631 = load double, ptr %"sub.i115'de", align 8
  %632 = fadd fast double %631, %630
  store double %632, ptr %"sub.i115'de", align 8
  %633 = load double, ptr %"'de34", align 8
  store double 0.000000e+00, ptr %"'de34", align 8
  %634 = call fast double @llvm.cos.f64(double %sub.i115_unwrap)
  %635 = fmul fast double %633, %634
  %636 = load double, ptr %"sub.i115'de", align 8
  %637 = fadd fast double %636, %635
  store double %637, ptr %"sub.i115'de", align 8
  %638 = load double, ptr %"'de30", align 8
  store double 0.000000e+00, ptr %"'de30", align 8
  %639 = call fast double @llvm.sin.f64(double %sub.i115_unwrap)
  %640 = fneg fast double %639
  %641 = fmul fast double %638, %640
  %642 = load double, ptr %"sub.i115'de", align 8
  %643 = fadd fast double %642, %641
  store double %643, ptr %"sub.i115'de", align 8
  %644 = load double, ptr %"sub.i115'de", align 8
  store double 0.000000e+00, ptr %"sub.i115'de", align 8
  %645 = load double, ptr %"add8'de", align 8
  %646 = fadd fast double %645, %644
  store double %646, ptr %"add8'de", align 8
  %647 = fneg fast double %644
  %648 = load double, ptr %"add12'de", align 8
  %649 = fadd fast double %648, %647
  store double %649, ptr %"add12'de", align 8
  %650 = load double, ptr %"add14'de", align 8
  store double 0.000000e+00, ptr %"add14'de", align 8
  %651 = load double, ptr %"mul13'de", align 8
  %652 = fadd fast double %651, %650
  store double %652, ptr %"mul13'de", align 8
  %653 = load double, ptr %"omega2.0184'de", align 8
  %654 = fadd fast double %653, %650
  store double %654, ptr %"omega2.0184'de", align 8
  %655 = load double, ptr %"mul13'de", align 8
  store double 0.000000e+00, ptr %"mul13'de", align 8
  %656 = fmul fast double %655, 5.000000e-04
  %657 = load double, ptr %"div40.i114'de", align 8
  %658 = fadd fast double %657, %656
  store double %658, ptr %"div40.i114'de", align 8
  %659 = load double, ptr %"add12'de", align 8
  store double 0.000000e+00, ptr %"add12'de", align 8
  %660 = load double, ptr %"mul11'de", align 8
  %661 = fadd fast double %660, %659
  store double %661, ptr %"mul11'de", align 8
  %662 = load double, ptr %"theta2.0185'de", align 8
  %663 = fadd fast double %662, %659
  store double %663, ptr %"theta2.0185'de", align 8
  %664 = load double, ptr %"mul11'de", align 8
  store double 0.000000e+00, ptr %"mul11'de", align 8
  %665 = fmul fast double %664, 5.000000e-04
  %666 = load double, ptr %"add6'de", align 8
  %667 = fadd fast double %666, %665
  store double %667, ptr %"add6'de", align 8
  %668 = load double, ptr %"add10'de", align 8
  store double 0.000000e+00, ptr %"add10'de", align 8
  %669 = load double, ptr %"mul9'de", align 8
  %670 = fadd fast double %669, %668
  store double %670, ptr %"mul9'de", align 8
  %671 = load double, ptr %"omega1.0186'de", align 8
  %672 = fadd fast double %671, %668
  store double %672, ptr %"omega1.0186'de", align 8
  %673 = load double, ptr %"mul9'de", align 8
  store double 0.000000e+00, ptr %"mul9'de", align 8
  %674 = fmul fast double %673, 5.000000e-04
  %675 = load double, ptr %"div.i107'de", align 8
  %676 = fadd fast double %675, %674
  store double %676, ptr %"div.i107'de", align 8
  %677 = load double, ptr %"add8'de", align 8
  store double 0.000000e+00, ptr %"add8'de", align 8
  %678 = load double, ptr %"mul7'de", align 8
  %679 = fadd fast double %678, %677
  store double %679, ptr %"mul7'de", align 8
  %680 = load double, ptr %"theta1.0187'de", align 8
  %681 = fadd fast double %680, %677
  store double %681, ptr %"theta1.0187'de", align 8
  %682 = load double, ptr %"mul7'de", align 8
  store double 0.000000e+00, ptr %"mul7'de", align 8
  %683 = fmul fast double %682, 5.000000e-04
  %684 = load double, ptr %"add2'de", align 8
  %685 = fadd fast double %684, %683
  store double %685, ptr %"add2'de", align 8
  %686 = load double, ptr %"div40.i114'de", align 8
  store double 0.000000e+00, ptr %"div40.i114'de", align 8
  %687 = fdiv fast double %686, %sub3.i95_unwrap
  %688 = load double, ptr %"mul38.i113'de", align 8
  %689 = fadd fast double %688, %687
  store double %689, ptr %"mul38.i113'de", align 8
  %690 = fdiv fast double %686, %sub3.i95_unwrap
  %691 = fdiv fast double %mul38.i113_unwrap, %sub3.i95_unwrap
  %692 = fmul fast double %690, %691
  %693 = fneg fast double %692
  %694 = load double, ptr %"sub3.i95'de", align 8
  %695 = fadd fast double %694, %693
  store double %695, ptr %"sub3.i95'de", align 8
  %696 = load double, ptr %"mul38.i113'de", align 8
  store double 0.000000e+00, ptr %"mul38.i113'de", align 8
  %697 = fmul fast double %696, %mul13.i99_unwrap
  %698 = load double, ptr %"add37.i112'de", align 8
  %699 = fadd fast double %698, %697
  store double %699, ptr %"add37.i112'de", align 8
  %700 = fmul fast double %696, %add37.i112_unwrap
  %701 = load double, ptr %"mul13.i99'de", align 8
  %702 = fadd fast double %701, %700
  store double %702, ptr %"mul13.i99'de", align 8
  %703 = load double, ptr %"add37.i112'de", align 8
  store double 0.000000e+00, ptr %"add37.i112'de", align 8
  %704 = load double, ptr %"add32.i110'de", align 8
  %705 = fadd fast double %704, %703
  store double %705, ptr %"add32.i110'de", align 8
  %706 = load double, ptr %"mul28.i108'de", align 8
  %707 = fadd fast double %706, %703
  store double %707, ptr %"mul28.i108'de", align 8
  %708 = load double, ptr %"add32.i110'de", align 8
  store double 0.000000e+00, ptr %"add32.i110'de", align 8
  %709 = load double, ptr %"mul36.i111'de", align 8
  %710 = fadd fast double %709, %708
  store double %710, ptr %"mul36.i111'de", align 8
  %711 = load double, ptr %"mul31.i109'de", align 8
  %712 = fadd fast double %711, %708
  store double %712, ptr %"mul31.i109'de", align 8
  %713 = load double, ptr %"mul36.i111'de", align 8
  store double 0.000000e+00, ptr %"mul36.i111'de", align 8
  %714 = fmul fast double %713, %266
  %715 = load double, ptr %"mul15.i100'de", align 8
  %716 = fadd fast double %715, %714
  store double %716, ptr %"mul15.i100'de", align 8
  %717 = fmul fast double %713, %mul15.i100_unwrap
  %718 = load double, ptr %"'de37", align 8
  %719 = fadd fast double %718, %717
  store double %719, ptr %"'de37", align 8
  %720 = load double, ptr %"mul31.i109'de", align 8
  store double 0.000000e+00, ptr %"mul31.i109'de", align 8
  %721 = fmul fast double %720, 1.962000e+01
  %722 = load double, ptr %"'de38", align 8
  %723 = fadd fast double %722, %721
  store double %723, ptr %"'de38", align 8
  %724 = load double, ptr %"'de38", align 8
  store double 0.000000e+00, ptr %"'de38", align 8
  %725 = call fast double @llvm.sin.f64(double %add_unwrap)
  %726 = fneg fast double %725
  %727 = fmul fast double %724, %726
  %728 = load double, ptr %"add'de", align 8
  %729 = fadd fast double %728, %727
  store double %729, ptr %"add'de", align 8
  %730 = load double, ptr %"mul28.i108'de", align 8
  store double 0.000000e+00, ptr %"mul28.i108'de", align 8
  %731 = fmul fast double %730, 2.000000e+00
  %732 = load double, ptr %"mul17.i101'de", align 8
  %733 = fadd fast double %732, %731
  store double %733, ptr %"mul17.i101'de", align 8
  %734 = load double, ptr %"div.i107'de", align 8
  store double 0.000000e+00, ptr %"div.i107'de", align 8
  %735 = fdiv fast double %734, %sub3.i95_unwrap
  %736 = load double, ptr %"sub22.i106'de", align 8
  %737 = fadd fast double %736, %735
  store double %737, ptr %"sub22.i106'de", align 8
  %738 = fdiv fast double %734, %sub3.i95_unwrap
  %739 = fdiv fast double %sub22.i106_unwrap, %sub3.i95_unwrap
  %740 = fmul fast double %738, %739
  %741 = fneg fast double %740
  %742 = load double, ptr %"sub3.i95'de", align 8
  %743 = fadd fast double %742, %741
  store double %743, ptr %"sub3.i95'de", align 8
  %744 = load double, ptr %"sub22.i106'de", align 8
  store double 0.000000e+00, ptr %"sub22.i106'de", align 8
  %745 = load double, ptr %".neg.i105'de", align 8
  %746 = fadd fast double %745, %744
  store double %746, ptr %".neg.i105'de", align 8
  %747 = fneg fast double %744
  %748 = load double, ptr %"'de39", align 8
  %749 = fadd fast double %748, %747
  store double %749, ptr %"'de39", align 8
  %750 = load double, ptr %"'de39", align 8
  store double 0.000000e+00, ptr %"'de39", align 8
  %751 = fmul fast double %750, %mul13.i99_unwrap
  %752 = load double, ptr %"add20.i103'de", align 8
  %753 = fadd fast double %752, %751
  store double %753, ptr %"add20.i103'de", align 8
  %754 = fmul fast double %750, %add20.i103_unwrap
  %755 = load double, ptr %"mul13.i99'de", align 8
  %756 = fadd fast double %755, %754
  store double %756, ptr %"mul13.i99'de", align 8
  %757 = load double, ptr %".neg.i105'de", align 8
  store double 0.000000e+00, ptr %".neg.i105'de", align 8
  %758 = load double, ptr %"mul11.neg.i104'de", align 8
  %759 = fadd fast double %758, %757
  store double %759, ptr %"mul11.neg.i104'de", align 8
  %760 = load double, ptr %"mul7.i96'de", align 8
  %761 = fadd fast double %760, %757
  store double %761, ptr %"mul7.i96'de", align 8
  %762 = load double, ptr %"mul11.neg.i104'de", align 8
  store double 0.000000e+00, ptr %"mul11.neg.i104'de", align 8
  %763 = fmul fast double %762, -9.810000e+00
  %764 = load double, ptr %"'de40", align 8
  %765 = fadd fast double %764, %763
  store double %765, ptr %"'de40", align 8
  %766 = load double, ptr %"add20.i103'de", align 8
  store double 0.000000e+00, ptr %"add20.i103'de", align 8
  %767 = load double, ptr %"mul19.i102'de", align 8
  %768 = fadd fast double %767, %766
  store double %768, ptr %"mul19.i102'de", align 8
  %769 = load double, ptr %"mul15.i100'de", align 8
  %770 = fadd fast double %769, %766
  store double %770, ptr %"mul15.i100'de", align 8
  %771 = load double, ptr %"mul19.i102'de", align 8
  store double 0.000000e+00, ptr %"mul19.i102'de", align 8
  %772 = fmul fast double %771, %266
  %773 = load double, ptr %"mul17.i101'de", align 8
  %774 = fadd fast double %773, %772
  store double %774, ptr %"mul17.i101'de", align 8
  %775 = fmul fast double %771, %mul17.i101_unwrap
  %776 = load double, ptr %"'de37", align 8
  %777 = fadd fast double %776, %775
  store double %777, ptr %"'de37", align 8
  %778 = load double, ptr %"mul17.i101'de", align 8
  store double 0.000000e+00, ptr %"mul17.i101'de", align 8
  %779 = fmul fast double %778, %add2_unwrap
  %780 = load double, ptr %"add2'de", align 8
  %781 = fadd fast double %780, %779
  store double %781, ptr %"add2'de", align 8
  %782 = fmul fast double %778, %add2_unwrap
  %783 = load double, ptr %"add2'de", align 8
  %784 = fadd fast double %783, %782
  store double %784, ptr %"add2'de", align 8
  %785 = load double, ptr %"mul15.i100'de", align 8
  store double 0.000000e+00, ptr %"mul15.i100'de", align 8
  %786 = fmul fast double %785, %add6_unwrap
  %787 = load double, ptr %"add6'de", align 8
  %788 = fadd fast double %787, %786
  store double %788, ptr %"add6'de", align 8
  %789 = fmul fast double %785, %add6_unwrap
  %790 = load double, ptr %"add6'de", align 8
  %791 = fadd fast double %790, %789
  store double %791, ptr %"add6'de", align 8
  %792 = load double, ptr %"mul13.i99'de", align 8
  store double 0.000000e+00, ptr %"mul13.i99'de", align 8
  %793 = fmul fast double %792, 2.000000e+00
  %794 = load double, ptr %"'de41", align 8
  %795 = fadd fast double %794, %793
  store double %795, ptr %"'de41", align 8
  %796 = load double, ptr %"'de40", align 8
  store double 0.000000e+00, ptr %"'de40", align 8
  %797 = call fast double @llvm.cos.f64(double %sub10.i98_unwrap)
  %798 = fmul fast double %796, %797
  %799 = load double, ptr %"sub10.i98'de", align 8
  %800 = fadd fast double %799, %798
  store double %800, ptr %"sub10.i98'de", align 8
  %801 = load double, ptr %"sub10.i98'de", align 8
  store double 0.000000e+00, ptr %"sub10.i98'de", align 8
  %802 = load double, ptr %"add'de", align 8
  %803 = fadd fast double %802, %801
  store double %803, ptr %"add'de", align 8
  %804 = fneg fast double %801
  %805 = load double, ptr %"mul9.i97'de", align 8
  %806 = fadd fast double %805, %804
  store double %806, ptr %"mul9.i97'de", align 8
  %807 = load double, ptr %"mul9.i97'de", align 8
  store double 0.000000e+00, ptr %"mul9.i97'de", align 8
  %808 = fmul fast double %807, 2.000000e+00
  %809 = load double, ptr %"add4'de", align 8
  %810 = fadd fast double %809, %808
  store double %810, ptr %"add4'de", align 8
  %811 = load double, ptr %"mul7.i96'de", align 8
  store double 0.000000e+00, ptr %"mul7.i96'de", align 8
  %812 = fmul fast double %811, -2.943000e+01
  %813 = load double, ptr %"'de42", align 8
  %814 = fadd fast double %813, %812
  store double %814, ptr %"'de42", align 8
  %815 = load double, ptr %"'de42", align 8
  store double 0.000000e+00, ptr %"'de42", align 8
  %816 = call fast double @llvm.cos.f64(double %add_unwrap)
  %817 = fmul fast double %815, %816
  %818 = load double, ptr %"add'de", align 8
  %819 = fadd fast double %818, %817
  store double %819, ptr %"add'de", align 8
  %820 = load double, ptr %"sub3.i95'de", align 8
  store double 0.000000e+00, ptr %"sub3.i95'de", align 8
  %821 = fneg fast double %820
  %822 = load double, ptr %"'de43", align 8
  %823 = fadd fast double %822, %821
  store double %823, ptr %"'de43", align 8
  %824 = load double, ptr %"'de43", align 8
  store double 0.000000e+00, ptr %"'de43", align 8
  %825 = call fast double @llvm.sin.f64(double %mul1.i94_unwrap)
  %826 = fneg fast double %825
  %827 = fmul fast double %824, %826
  %828 = load double, ptr %"mul1.i94'de", align 8
  %829 = fadd fast double %828, %827
  store double %829, ptr %"mul1.i94'de", align 8
  %830 = load double, ptr %"mul1.i94'de", align 8
  store double 0.000000e+00, ptr %"mul1.i94'de", align 8
  %831 = fmul fast double %830, 2.000000e+00
  %832 = load double, ptr %"sub.i93'de", align 8
  %833 = fadd fast double %832, %831
  store double %833, ptr %"sub.i93'de", align 8
  %834 = load double, ptr %"'de41", align 8
  store double 0.000000e+00, ptr %"'de41", align 8
  %835 = call fast double @llvm.cos.f64(double %sub.i93_unwrap)
  %836 = fmul fast double %834, %835
  %837 = load double, ptr %"sub.i93'de", align 8
  %838 = fadd fast double %837, %836
  store double %838, ptr %"sub.i93'de", align 8
  %839 = load double, ptr %"'de37", align 8
  store double 0.000000e+00, ptr %"'de37", align 8
  %840 = call fast double @llvm.sin.f64(double %sub.i93_unwrap)
  %841 = fneg fast double %840
  %842 = fmul fast double %839, %841
  %843 = load double, ptr %"sub.i93'de", align 8
  %844 = fadd fast double %843, %842
  store double %844, ptr %"sub.i93'de", align 8
  %845 = load double, ptr %"sub.i93'de", align 8
  store double 0.000000e+00, ptr %"sub.i93'de", align 8
  %846 = load double, ptr %"add'de", align 8
  %847 = fadd fast double %846, %845
  store double %847, ptr %"add'de", align 8
  %848 = fneg fast double %845
  %849 = load double, ptr %"add4'de", align 8
  %850 = fadd fast double %849, %848
  store double %850, ptr %"add4'de", align 8
  %851 = load double, ptr %"add6'de", align 8
  store double 0.000000e+00, ptr %"add6'de", align 8
  %852 = load double, ptr %"mul5'de", align 8
  %853 = fadd fast double %852, %851
  store double %853, ptr %"mul5'de", align 8
  %854 = load double, ptr %"omega2.0184'de", align 8
  %855 = fadd fast double %854, %851
  store double %855, ptr %"omega2.0184'de", align 8
  %856 = load double, ptr %"mul5'de", align 8
  store double 0.000000e+00, ptr %"mul5'de", align 8
  %857 = fmul fast double %856, 5.000000e-04
  %858 = load double, ptr %"div40.i'de", align 8
  %859 = fadd fast double %858, %857
  store double %859, ptr %"div40.i'de", align 8
  %860 = load double, ptr %"add4'de", align 8
  store double 0.000000e+00, ptr %"add4'de", align 8
  %861 = load double, ptr %"theta2.0185'de", align 8
  %862 = fadd fast double %861, %860
  store double %862, ptr %"theta2.0185'de", align 8
  %863 = load double, ptr %"mul3'de", align 8
  %864 = fadd fast double %863, %860
  store double %864, ptr %"mul3'de", align 8
  %865 = load double, ptr %"mul3'de", align 8
  store double 0.000000e+00, ptr %"mul3'de", align 8
  %866 = fmul fast double %865, 5.000000e-04
  %867 = load double, ptr %"omega2.0184'de", align 8
  %868 = fadd fast double %867, %866
  store double %868, ptr %"omega2.0184'de", align 8
  %869 = load double, ptr %"add2'de", align 8
  store double 0.000000e+00, ptr %"add2'de", align 8
  %870 = load double, ptr %"mul1'de", align 8
  %871 = fadd fast double %870, %869
  store double %871, ptr %"mul1'de", align 8
  %872 = load double, ptr %"omega1.0186'de", align 8
  %873 = fadd fast double %872, %869
  store double %873, ptr %"omega1.0186'de", align 8
  %874 = load double, ptr %"mul1'de", align 8
  store double 0.000000e+00, ptr %"mul1'de", align 8
  %875 = fmul fast double %874, 5.000000e-04
  %876 = load double, ptr %"div.i'de", align 8
  %877 = fadd fast double %876, %875
  store double %877, ptr %"div.i'de", align 8
  %878 = load double, ptr %"add'de", align 8
  store double 0.000000e+00, ptr %"add'de", align 8
  %879 = load double, ptr %"theta1.0187'de", align 8
  %880 = fadd fast double %879, %878
  store double %880, ptr %"theta1.0187'de", align 8
  %881 = load double, ptr %"mul'de", align 8
  %882 = fadd fast double %881, %878
  store double %882, ptr %"mul'de", align 8
  %883 = load double, ptr %"mul'de", align 8
  store double 0.000000e+00, ptr %"mul'de", align 8
  %884 = fmul fast double %883, 5.000000e-04
  %885 = load double, ptr %"omega1.0186'de", align 8
  %886 = fadd fast double %885, %884
  store double %886, ptr %"omega1.0186'de", align 8
  %887 = load double, ptr %"div40.i'de", align 8
  store double 0.000000e+00, ptr %"div40.i'de", align 8
  %888 = fdiv fast double %887, %sub3.i_unwrap
  %889 = load double, ptr %"mul38.i'de", align 8
  %890 = fadd fast double %889, %888
  store double %890, ptr %"mul38.i'de", align 8
  %891 = fdiv fast double %887, %sub3.i_unwrap
  %892 = fdiv fast double %mul38.i_unwrap, %sub3.i_unwrap
  %893 = fmul fast double %891, %892
  %894 = fneg fast double %893
  %895 = load double, ptr %"sub3.i'de", align 8
  %896 = fadd fast double %895, %894
  store double %896, ptr %"sub3.i'de", align 8
  %897 = load double, ptr %"mul38.i'de", align 8
  store double 0.000000e+00, ptr %"mul38.i'de", align 8
  %898 = fmul fast double %897, %mul13.i_unwrap
  %899 = load double, ptr %"add37.i'de", align 8
  %900 = fadd fast double %899, %898
  store double %900, ptr %"add37.i'de", align 8
  %901 = fmul fast double %897, %add37.i_unwrap
  %902 = load double, ptr %"mul13.i'de", align 8
  %903 = fadd fast double %902, %901
  store double %903, ptr %"mul13.i'de", align 8
  %904 = load double, ptr %"add37.i'de", align 8
  store double 0.000000e+00, ptr %"add37.i'de", align 8
  %905 = load double, ptr %"add32.i'de", align 8
  %906 = fadd fast double %905, %904
  store double %906, ptr %"add32.i'de", align 8
  %907 = load double, ptr %"mul36.i'de", align 8
  %908 = fadd fast double %907, %904
  store double %908, ptr %"mul36.i'de", align 8
  %909 = load double, ptr %"mul36.i'de", align 8
  store double 0.000000e+00, ptr %"mul36.i'de", align 8
  %910 = fmul fast double %909, %mul15.i_unwrap
  %911 = load double, ptr %"'de44", align 8
  %912 = fadd fast double %911, %910
  store double %912, ptr %"'de44", align 8
  %913 = fmul fast double %909, %263
  %914 = load double, ptr %"mul15.i'de", align 8
  %915 = fadd fast double %914, %913
  store double %915, ptr %"mul15.i'de", align 8
  %916 = load double, ptr %"add32.i'de", align 8
  store double 0.000000e+00, ptr %"add32.i'de", align 8
  %917 = load double, ptr %"mul31.i'de", align 8
  %918 = fadd fast double %917, %916
  store double %918, ptr %"mul31.i'de", align 8
  %919 = load double, ptr %"mul28.i'de", align 8
  %920 = fadd fast double %919, %916
  store double %920, ptr %"mul28.i'de", align 8
  %921 = load double, ptr %"mul31.i'de", align 8
  store double 0.000000e+00, ptr %"mul31.i'de", align 8
  %922 = fmul fast double %921, 1.962000e+01
  %923 = load double, ptr %"'de45", align 8
  %924 = fadd fast double %923, %922
  store double %924, ptr %"'de45", align 8
  %925 = load double, ptr %"'de45", align 8
  store double 0.000000e+00, ptr %"'de45", align 8
  %926 = call fast double @llvm.sin.f64(double %249)
  %927 = fneg fast double %926
  %928 = fmul fast double %925, %927
  %929 = load double, ptr %"theta1.0187'de", align 8
  %930 = fadd fast double %929, %928
  store double %930, ptr %"theta1.0187'de", align 8
  %931 = load double, ptr %"mul28.i'de", align 8
  store double 0.000000e+00, ptr %"mul28.i'de", align 8
  %932 = fmul fast double %931, 2.000000e+00
  %933 = load double, ptr %"mul17.i'de", align 8
  %934 = fadd fast double %933, %932
  store double %934, ptr %"mul17.i'de", align 8
  %935 = load double, ptr %"div.i'de", align 8
  store double 0.000000e+00, ptr %"div.i'de", align 8
  %936 = fdiv fast double %935, %sub3.i_unwrap
  %937 = load double, ptr %"sub22.i'de", align 8
  %938 = fadd fast double %937, %936
  store double %938, ptr %"sub22.i'de", align 8
  %939 = fdiv fast double %935, %sub3.i_unwrap
  %940 = fdiv fast double %sub22.i_unwrap, %sub3.i_unwrap
  %941 = fmul fast double %939, %940
  %942 = fneg fast double %941
  %943 = load double, ptr %"sub3.i'de", align 8
  %944 = fadd fast double %943, %942
  store double %944, ptr %"sub3.i'de", align 8
  %945 = load double, ptr %"sub22.i'de", align 8
  store double 0.000000e+00, ptr %"sub22.i'de", align 8
  %946 = load double, ptr %".neg.i'de", align 8
  %947 = fadd fast double %946, %945
  store double %947, ptr %".neg.i'de", align 8
  %948 = fneg fast double %945
  %949 = load double, ptr %"'de46", align 8
  %950 = fadd fast double %949, %948
  store double %950, ptr %"'de46", align 8
  %951 = load double, ptr %"'de46", align 8
  store double 0.000000e+00, ptr %"'de46", align 8
  %952 = fmul fast double %951, %mul13.i_unwrap
  %953 = load double, ptr %"add20.i'de", align 8
  %954 = fadd fast double %953, %952
  store double %954, ptr %"add20.i'de", align 8
  %955 = fmul fast double %951, %add20.i_unwrap
  %956 = load double, ptr %"mul13.i'de", align 8
  %957 = fadd fast double %956, %955
  store double %957, ptr %"mul13.i'de", align 8
  %958 = load double, ptr %".neg.i'de", align 8
  store double 0.000000e+00, ptr %".neg.i'de", align 8
  %959 = load double, ptr %"mul11.neg.i'de", align 8
  %960 = fadd fast double %959, %958
  store double %960, ptr %"mul11.neg.i'de", align 8
  %961 = load double, ptr %"mul7.i'de", align 8
  %962 = fadd fast double %961, %958
  store double %962, ptr %"mul7.i'de", align 8
  %963 = load double, ptr %"mul11.neg.i'de", align 8
  store double 0.000000e+00, ptr %"mul11.neg.i'de", align 8
  %964 = fmul fast double %963, -9.810000e+00
  %965 = load double, ptr %"'de47", align 8
  %966 = fadd fast double %965, %964
  store double %966, ptr %"'de47", align 8
  %967 = load double, ptr %"add20.i'de", align 8
  store double 0.000000e+00, ptr %"add20.i'de", align 8
  %968 = load double, ptr %"mul19.i'de", align 8
  %969 = fadd fast double %968, %967
  store double %969, ptr %"mul19.i'de", align 8
  %970 = load double, ptr %"mul15.i'de", align 8
  %971 = fadd fast double %970, %967
  store double %971, ptr %"mul15.i'de", align 8
  %972 = load double, ptr %"mul19.i'de", align 8
  store double 0.000000e+00, ptr %"mul19.i'de", align 8
  %973 = fmul fast double %972, %mul17.i_unwrap
  %974 = load double, ptr %"'de44", align 8
  %975 = fadd fast double %974, %973
  store double %975, ptr %"'de44", align 8
  %976 = fmul fast double %972, %263
  %977 = load double, ptr %"mul17.i'de", align 8
  %978 = fadd fast double %977, %976
  store double %978, ptr %"mul17.i'de", align 8
  %979 = load double, ptr %"mul17.i'de", align 8
  store double 0.000000e+00, ptr %"mul17.i'de", align 8
  %980 = fmul fast double %979, %252
  %981 = load double, ptr %"omega1.0186'de", align 8
  %982 = fadd fast double %981, %980
  store double %982, ptr %"omega1.0186'de", align 8
  %983 = fmul fast double %979, %252
  %984 = load double, ptr %"omega1.0186'de", align 8
  %985 = fadd fast double %984, %983
  store double %985, ptr %"omega1.0186'de", align 8
  %986 = load double, ptr %"mul15.i'de", align 8
  store double 0.000000e+00, ptr %"mul15.i'de", align 8
  %987 = fmul fast double %986, %258
  %988 = load double, ptr %"omega2.0184'de", align 8
  %989 = fadd fast double %988, %987
  store double %989, ptr %"omega2.0184'de", align 8
  %990 = fmul fast double %986, %258
  %991 = load double, ptr %"omega2.0184'de", align 8
  %992 = fadd fast double %991, %990
  store double %992, ptr %"omega2.0184'de", align 8
  %993 = load double, ptr %"mul13.i'de", align 8
  store double 0.000000e+00, ptr %"mul13.i'de", align 8
  %994 = fmul fast double %993, 2.000000e+00
  %995 = load double, ptr %"'de48", align 8
  %996 = fadd fast double %995, %994
  store double %996, ptr %"'de48", align 8
  %997 = load double, ptr %"'de47", align 8
  store double 0.000000e+00, ptr %"'de47", align 8
  %998 = call fast double @llvm.cos.f64(double %sub10.i_unwrap)
  %999 = fmul fast double %997, %998
  %1000 = load double, ptr %"sub10.i'de", align 8
  %1001 = fadd fast double %1000, %999
  store double %1001, ptr %"sub10.i'de", align 8
  %1002 = load double, ptr %"sub10.i'de", align 8
  store double 0.000000e+00, ptr %"sub10.i'de", align 8
  %1003 = load double, ptr %"theta1.0187'de", align 8
  %1004 = fadd fast double %1003, %1002
  store double %1004, ptr %"theta1.0187'de", align 8
  %1005 = fneg fast double %1002
  %1006 = load double, ptr %"mul9.i'de", align 8
  %1007 = fadd fast double %1006, %1005
  store double %1007, ptr %"mul9.i'de", align 8
  %1008 = load double, ptr %"mul9.i'de", align 8
  store double 0.000000e+00, ptr %"mul9.i'de", align 8
  %1009 = fmul fast double %1008, 2.000000e+00
  %1010 = load double, ptr %"theta2.0185'de", align 8
  %1011 = fadd fast double %1010, %1009
  store double %1011, ptr %"theta2.0185'de", align 8
  %1012 = load double, ptr %"mul7.i'de", align 8
  store double 0.000000e+00, ptr %"mul7.i'de", align 8
  %1013 = fmul fast double %1012, -2.943000e+01
  %1014 = load double, ptr %"'de49", align 8
  %1015 = fadd fast double %1014, %1013
  store double %1015, ptr %"'de49", align 8
  %1016 = load double, ptr %"'de49", align 8
  store double 0.000000e+00, ptr %"'de49", align 8
  %1017 = call fast double @llvm.cos.f64(double %249)
  %1018 = fmul fast double %1016, %1017
  %1019 = load double, ptr %"theta1.0187'de", align 8
  %1020 = fadd fast double %1019, %1018
  store double %1020, ptr %"theta1.0187'de", align 8
  %1021 = load double, ptr %"sub3.i'de", align 8
  store double 0.000000e+00, ptr %"sub3.i'de", align 8
  %1022 = fneg fast double %1021
  %1023 = load double, ptr %"'de50", align 8
  %1024 = fadd fast double %1023, %1022
  store double %1024, ptr %"'de50", align 8
  %1025 = load double, ptr %"'de50", align 8
  store double 0.000000e+00, ptr %"'de50", align 8
  %1026 = call fast double @llvm.sin.f64(double %mul1.i_unwrap)
  %1027 = fneg fast double %1026
  %1028 = fmul fast double %1025, %1027
  %1029 = load double, ptr %"mul1.i'de", align 8
  %1030 = fadd fast double %1029, %1028
  store double %1030, ptr %"mul1.i'de", align 8
  %1031 = load double, ptr %"mul1.i'de", align 8
  store double 0.000000e+00, ptr %"mul1.i'de", align 8
  %1032 = fmul fast double %1031, 2.000000e+00
  %1033 = load double, ptr %"sub.i'de", align 8
  %1034 = fadd fast double %1033, %1032
  store double %1034, ptr %"sub.i'de", align 8
  %1035 = load double, ptr %"'de48", align 8
  store double 0.000000e+00, ptr %"'de48", align 8
  %1036 = call fast double @llvm.cos.f64(double %sub.i_unwrap)
  %1037 = fmul fast double %1035, %1036
  %1038 = load double, ptr %"sub.i'de", align 8
  %1039 = fadd fast double %1038, %1037
  store double %1039, ptr %"sub.i'de", align 8
  %1040 = load double, ptr %"'de44", align 8
  store double 0.000000e+00, ptr %"'de44", align 8
  %1041 = call fast double @llvm.sin.f64(double %sub.i_unwrap)
  %1042 = fneg fast double %1041
  %1043 = fmul fast double %1040, %1042
  %1044 = load double, ptr %"sub.i'de", align 8
  %1045 = fadd fast double %1044, %1043
  store double %1045, ptr %"sub.i'de", align 8
  %1046 = load double, ptr %"sub.i'de", align 8
  store double 0.000000e+00, ptr %"sub.i'de", align 8
  %1047 = load double, ptr %"theta1.0187'de", align 8
  %1048 = fadd fast double %1047, %1046
  store double %1048, ptr %"theta1.0187'de", align 8
  %1049 = fneg fast double %1046
  %1050 = load double, ptr %"theta2.0185'de", align 8
  %1051 = fadd fast double %1050, %1049
  store double %1051, ptr %"theta2.0185'de", align 8
  %1052 = load double, ptr %"theta1.0187'de", align 8
  store double 0.000000e+00, ptr %"theta1.0187'de", align 8
  %1053 = load double, ptr %"omega1.0186'de", align 8
  store double 0.000000e+00, ptr %"omega1.0186'de", align 8
  %1054 = load double, ptr %"theta2.0185'de", align 8
  store double 0.000000e+00, ptr %"theta2.0185'de", align 8
  %1055 = load double, ptr %"omega2.0184'de", align 8
  store double 0.000000e+00, ptr %"omega2.0184'de", align 8
  %1056 = load i64, ptr %"iv'ac", align 8
  %1057 = icmp eq i64 %1056, 0
  %1058 = xor i1 %1057, true
  %1059 = select fast i1 %1058, double %1052, double 0.000000e+00
  %1060 = load double, ptr %"add29'de", align 8
  %1061 = fadd fast double %1060, %1052
  %1062 = select fast i1 %1057, double %1060, double %1061
  store double %1062, ptr %"add29'de", align 8
  %1063 = select fast i1 %1058, double %1053, double 0.000000e+00
  %1064 = load double, ptr %"add36'de", align 8
  %1065 = fadd fast double %1064, %1053
  %1066 = select fast i1 %1057, double %1064, double %1065
  store double %1066, ptr %"add36'de", align 8
  %1067 = select fast i1 %1057, double %1053, double 0.000000e+00
  %1068 = load double, ptr %"omega1_0'de", align 8
  %1069 = fadd fast double %1068, %1053
  %1070 = select fast i1 %1057, double %1069, double %1068
  store double %1070, ptr %"omega1_0'de", align 8
  %1071 = select fast i1 %1058, double %1054, double 0.000000e+00
  %1072 = load double, ptr %"add43'de", align 8
  %1073 = fadd fast double %1072, %1054
  %1074 = select fast i1 %1057, double %1072, double %1073
  store double %1074, ptr %"add43'de", align 8
  %1075 = select fast i1 %1058, double %1055, double 0.000000e+00
  %1076 = load double, ptr %"add50'de", align 8
  %1077 = fadd fast double %1076, %1055
  %1078 = select fast i1 %1057, double %1076, double %1077
  store double %1078, ptr %"add50'de", align 8
  %1079 = select fast i1 %1057, double %1055, double 0.000000e+00
  %1080 = load double, ptr %"omega2_0'de", align 8
  %1081 = fadd fast double %1080, %1055
  %1082 = select fast i1 %1057, double %1081, double %1080
  store double %1082, ptr %"omega2_0'de", align 8
  br i1 %1057, label %invertentry, label %incinvertfor.body

incinvertfor.body:                                ; preds = %invertfor.body
  %1083 = load i64, ptr %"iv'ac", align 8
  %1084 = add nsw i64 %1083, -1
  store i64 %1084, ptr %"iv'ac", align 8
  br label %invertfor.body
}

declare noalias ptr @malloc(i64)

; Function Attrs: nocallback nofree nounwind willreturn memory(argmem: write)
declare void @llvm.memset.p0.i64(ptr nocapture writeonly, i8, i64, i1 immarg) #8

declare void @free(ptr)

; Function Attrs: mustprogress nofree norecurse nosync nounwind uwtable
define internal { double, double } @diffeloss_omega2(double noundef nofpclass(nan inf) %omega2_0, double noundef nofpclass(nan inf) %omega1_0, double %differeturn) #7 {
entry:
  %"call'de" = alloca double, align 8
  store double 0.000000e+00, ptr %"call'de", align 8
  %"omega1_0'de" = alloca double, align 8
  store double 0.000000e+00, ptr %"omega1_0'de", align 8
  %"omega2_0'de" = alloca double, align 8
  store double 0.000000e+00, ptr %"omega2_0'de", align 8
  br label %invertentry

invertentry:                                      ; preds = %entry
  store double %differeturn, ptr %"call'de", align 8
  %0 = load double, ptr %"call'de", align 8
  %1 = call { double, double } @diffeloss_omega1(double %omega1_0, double %omega2_0, double %0)
  %2 = extractvalue { double, double } %1, 0
  %3 = load double, ptr %"omega1_0'de", align 8
  %4 = fadd fast double %3, %2
  store double %4, ptr %"omega1_0'de", align 8
  %5 = extractvalue { double, double } %1, 1
  %6 = load double, ptr %"omega2_0'de", align 8
  %7 = fadd fast double %6, %5
  store double %7, ptr %"omega2_0'de", align 8
  store double 0.000000e+00, ptr %"call'de", align 8
  %8 = load double, ptr %"omega2_0'de", align 8
  %9 = load double, ptr %"omega1_0'de", align 8
  %10 = insertvalue { double, double } undef, double %8, 0
  %11 = insertvalue { double, double } %10, double %9, 1
  ret { double, double } %11
}

attributes #0 = { nofree norecurse nosync nounwind memory(none) uwtable "approx-func-fp-math"="true" "denormal-fp-math"="preserve-sign,preserve-sign" "min-legal-vector-width"="0" "no-infs-fp-math"="true" "no-nans-fp-math"="true" "no-signed-zeros-fp-math"="true" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" "unsafe-fp-math"="true" }
attributes #1 = { nocallback nofree nosync nounwind willreturn memory(argmem: readwrite) }
attributes #2 = { nocallback nofree nosync nounwind speculatable willreturn memory(none) }
attributes #3 = { nounwind uwtable "approx-func-fp-math"="true" "denormal-fp-math"="preserve-sign,preserve-sign" "min-legal-vector-width"="0" "no-infs-fp-math"="true" "no-nans-fp-math"="true" "no-signed-zeros-fp-math"="true" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" "unsafe-fp-math"="true" }
attributes #4 = { "approx-func-fp-math"="true" "denormal-fp-math"="preserve-sign,preserve-sign" "no-infs-fp-math"="true" "no-nans-fp-math"="true" "no-signed-zeros-fp-math"="true" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" "unsafe-fp-math"="true" }
attributes #5 = { nofree nounwind "approx-func-fp-math"="true" "denormal-fp-math"="preserve-sign,preserve-sign" "no-infs-fp-math"="true" "no-nans-fp-math"="true" "no-signed-zeros-fp-math"="true" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" "unsafe-fp-math"="true" }
attributes #6 = { nofree nounwind }
attributes #7 = { mustprogress nofree norecurse nosync nounwind uwtable "approx-func-fp-math"="true" "denormal-fp-math"="preserve-sign,preserve-sign" "min-legal-vector-width"="0" "no-infs-fp-math"="true" "no-nans-fp-math"="true" "no-signed-zeros-fp-math"="true" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" "unsafe-fp-math"="true" }
attributes #8 = { nocallback nofree nounwind willreturn memory(argmem: write) }
attributes #9 = { nounwind }
attributes #10 = { mustprogress willreturn }

!llvm.module.flags = !{!0, !1, !2, !3}
!llvm.ident = !{!4}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{i32 8, !"PIC Level", i32 2}
!2 = !{i32 7, !"PIE Level", i32 2}
!3 = !{i32 7, !"uwtable", i32 2}
!4 = !{!"clang version 18.1.8 (https://github.com/llvm/llvm-project.git 3b5b5c1ec4a3095ab096dd780e84d7ab81f3d7ff)"}
!5 = distinct !{!5, !6}
!6 = !{!"llvm.loop.mustprogress"}
!7 = distinct !{!7, !6, !8}
!8 = !{!"llvm.loop.peeled.count", i32 1}
!9 = !{!10, !11, i64 0}
!10 = !{!"", !11, i64 0, !11, i64 8, !11, i64 16, !11, i64 24}
!11 = !{!"double", !12, i64 0}
!12 = !{!"omnipotent char", !13, i64 0}
!13 = !{!"Simple C/C++ TBAA"}
!14 = !{!10, !11, i64 8}
!15 = !{!10, !11, i64 16}
!16 = !{!10, !11, i64 24}
!17 = !{!11, !11, i64 0}
!18 = !{!19}
!19 = distinct !{}
!20 = distinct !{}
!21 = !{!22}
!22 = distinct !{}
!23 = distinct !{}
!24 = !{!25}
!25 = distinct !{}
!26 = distinct !{}
!27 = !{!28}
!28 = distinct !{}
!29 = distinct !{}
!30 = !{i64 8}
!31 = distinct !{}
!32 = distinct !{}
!33 = distinct !{}
!34 = distinct !{}
