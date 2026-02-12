; ModuleID = '../c/pendulum_opt.c'
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

for.body:                                         ; preds = %entry, %for.body
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

; Function Attrs: mustprogress nocallback nofree nosync nounwind willreturn memory(argmem: readwrite)
declare void @llvm.lifetime.start.p0(i64 immarg, ptr nocapture) #1

; Function Attrs: mustprogress nocallback nofree nosync nounwind willreturn memory(argmem: readwrite)
declare void @llvm.lifetime.end.p0(i64 immarg, ptr nocapture) #1

; Function Attrs: mustprogress nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare double @llvm.sin.f64(double) #2

; Function Attrs: mustprogress nocallback nofree nosync nounwind speculatable willreturn memory(none)
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
  %call = tail call fast nofpclass(nan inf) double @__enzyme_autodiff(ptr noundef nonnull @loss_omega1, double noundef nofpclass(nan inf) %omega1_0, double noundef nofpclass(nan inf) %omega2_0) #7
  ret double %call
}

declare nofpclass(nan inf) double @__enzyme_autodiff(ptr noundef, double noundef nofpclass(nan inf), double noundef nofpclass(nan inf)) local_unnamed_addr #4

; Function Attrs: nounwind uwtable
define dso_local nofpclass(nan inf) double @dloss_domega2(double noundef nofpclass(nan inf) %omega1_0, double noundef nofpclass(nan inf) %omega2_0) local_unnamed_addr #3 {
entry:
  %call = tail call fast nofpclass(nan inf) double @__enzyme_autodiff(ptr noundef nonnull @loss_omega2, double noundef nofpclass(nan inf) %omega2_0, double noundef nofpclass(nan inf) %omega1_0) #7
  ret double %call
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
  %call.i.peel = tail call fast nofpclass(nan inf) double @__enzyme_autodiff(ptr noundef nonnull @loss_omega1, double noundef nofpclass(nan inf) 0.000000e+00, double noundef nofpclass(nan inf) 0.000000e+00) #7
  %call.i77.peel = tail call fast nofpclass(nan inf) double @__enzyme_autodiff(ptr noundef nonnull @loss_omega2, double noundef nofpclass(nan inf) 0.000000e+00, double noundef nofpclass(nan inf) 0.000000e+00) #7
  %sub.peel = fmul fast double %call.i.peel, -2.000000e-02
  %sub7.peel = fmul fast double %call.i77.peel, -2.000000e-02
  %call8.peel = tail call fast nofpclass(nan inf) double @loss_omega1(double noundef nofpclass(nan inf) %sub.peel, double noundef nofpclass(nan inf) %sub7.peel)
  %call12.peel = tail call i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @.str.3, i32 noundef 1, double noundef nofpclass(nan inf) %sub.peel, double noundef nofpclass(nan inf) %sub7.peel, double noundef nofpclass(nan inf) %call8.peel)
  %cmp13.peel = fcmp fast uge double %call8.peel, 0x3EB0C6F7A0B5ED8D
  br i1 %cmp13.peel, label %for.cond, label %cleanup18

for.cond:                                         ; preds = %if.end.peel, %if.end
  %i.0 = phi i32 [ %add, %if.end ], [ 1, %if.end.peel ]
  %omega2.0 = phi double [ %sub7, %if.end ], [ %sub7.peel, %if.end.peel ]
  %omega1.0 = phi double [ %sub, %if.end ], [ %sub.peel, %if.end.peel ]
  %exitcond.not = icmp eq i32 %i.0, 200
  br i1 %exitcond.not, label %cleanup18, label %for.body

for.body:                                         ; preds = %for.cond
  %call.i = tail call fast nofpclass(nan inf) double @__enzyme_autodiff(ptr noundef nonnull @loss_omega1, double noundef nofpclass(nan inf) %omega1.0, double noundef nofpclass(nan inf) %omega2.0) #7
  %call.i77 = tail call fast nofpclass(nan inf) double @__enzyme_autodiff(ptr noundef nonnull @loss_omega2, double noundef nofpclass(nan inf) %omega2.0, double noundef nofpclass(nan inf) %omega1.0) #7
  %mul = fmul fast double %call.i, 2.000000e-02
  %sub = fsub fast double %omega1.0, %mul
  %mul6 = fmul fast double %call.i77, 2.000000e-02
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

if.end:                                           ; preds = %for.body, %if.then
  %cmp13 = fcmp fast uge double %call8, 0x3EB0C6F7A0B5ED8D
  br i1 %cmp13, label %for.cond, label %cleanup18, !llvm.loop !7

cleanup18:                                        ; preds = %for.cond, %if.end, %if.end.peel
  %omega2.1 = phi double [ %sub7.peel, %if.end.peel ], [ %sub7, %if.end ], [ %omega2.0, %for.cond ]
  %omega1.1 = phi double [ %sub.peel, %if.end.peel ], [ %sub, %if.end ], [ %omega1.0, %for.cond ]
  call void @llvm.lifetime.start.p0(i64 32, ptr nonnull %y0) #7
  store double 0x3FE921FB54442D18, ptr %y0, align 8, !tbaa !9
  %omega119 = getelementptr inbounds %struct.State, ptr %y0, i64 0, i32 1
  store double %omega1.1, ptr %omega119, align 8, !tbaa !14
  %theta2 = getelementptr inbounds %struct.State, ptr %y0, i64 0, i32 2
  store double 0x3FE0C152382D7365, ptr %theta2, align 8, !tbaa !15
  %omega220 = getelementptr inbounds %struct.State, ptr %y0, i64 0, i32 3
  store double %omega2.1, ptr %omega220, align 8, !tbaa !16
  call void @llvm.lifetime.start.p0(i64 32, ptr nonnull %yT) #7
  call void @simulate(ptr dead_on_unwind nonnull writable sret(%struct.State) align 8 %yT, ptr noundef nonnull byval(%struct.State) align 8 %y0, i32 noundef 1000, double noundef nofpclass(nan inf) 1.000000e-03, ptr noundef nonnull @params) #7
  call void @llvm.lifetime.start.p0(i64 8, ptr nonnull %x2) #7
  call void @llvm.lifetime.start.p0(i64 8, ptr nonnull %y2) #7
  call void @get_bob2_position(ptr noundef nonnull %yT, ptr noundef nonnull @params, ptr noundef nonnull %x2, ptr noundef nonnull %y2) #7
  %puts74 = call i32 @puts(ptr nonnull dereferenceable(1) @str.11)
  %call22 = call i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @.str.5, double noundef nofpclass(nan inf) %omega1.1, double noundef nofpclass(nan inf) %omega2.1)
  %0 = load double, ptr %x2, align 8, !tbaa !17
  %1 = load double, ptr %y2, align 8, !tbaa !17
  %call23 = call i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @.str.6, double noundef nofpclass(nan inf) %0, double noundef nofpclass(nan inf) %1)
  %call24 = call i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @.str.7, double noundef nofpclass(nan inf) 0.000000e+00, double noundef nofpclass(nan inf) -1.800000e+00)
  %2 = load double, ptr %x2, align 8, !tbaa !17
  %mul27 = fmul fast double %2, %2
  %3 = load double, ptr %y2, align 8, !tbaa !17
  %sub28 = fadd fast double %3, 1.800000e+00
  %mul30 = fmul fast double %sub28, %sub28
  %add31 = fadd fast double %mul30, %mul27
  %4 = call fast double @llvm.sqrt.f64(double %add31)
  %call32 = call i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @.str.8, double noundef nofpclass(nan inf) %4)
  %5 = load double, ptr %x2, align 8, !tbaa !17
  %mul35 = fmul fast double %5, %5
  %6 = load double, ptr %y2, align 8, !tbaa !17
  %sub36 = fadd fast double %6, 1.800000e+00
  %mul38 = fmul fast double %sub36, %sub36
  %add39 = fadd fast double %mul38, %mul35
  %7 = call fast double @llvm.sqrt.f64(double %add39)
  %cmp40 = fcmp fast uge double %7, 3.000000e-01
  %str.13.str.12 = select i1 %cmp40, ptr @str.12, ptr @str.13
  %. = zext i1 %cmp40 to i32
  %puts75 = call i32 @puts(ptr nonnull dereferenceable(1) %str.13.str.12)
  call void @llvm.lifetime.end.p0(i64 8, ptr nonnull %y2) #7
  call void @llvm.lifetime.end.p0(i64 8, ptr nonnull %x2) #7
  call void @llvm.lifetime.end.p0(i64 32, ptr nonnull %yT) #7
  call void @llvm.lifetime.end.p0(i64 32, ptr nonnull %y0) #7
  ret i32 %.
}

; Function Attrs: nofree nounwind
declare noundef i32 @printf(ptr nocapture noundef readonly, ...) local_unnamed_addr #5

declare void @simulate(ptr dead_on_unwind writable sret(%struct.State) align 8, ptr noundef byval(%struct.State) align 8, i32 noundef, double noundef nofpclass(nan inf), ptr noundef) local_unnamed_addr #4

declare void @get_bob2_position(ptr noundef, ptr noundef, ptr noundef, ptr noundef) local_unnamed_addr #4

; Function Attrs: mustprogress nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare double @llvm.sqrt.f64(double) #2

; Function Attrs: nofree nounwind
declare noundef i32 @puts(ptr nocapture noundef readonly) local_unnamed_addr #6

attributes #0 = { nofree norecurse nosync nounwind memory(none) uwtable "approx-func-fp-math"="true" "denormal-fp-math"="preserve-sign,preserve-sign" "min-legal-vector-width"="0" "no-infs-fp-math"="true" "no-nans-fp-math"="true" "no-signed-zeros-fp-math"="true" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" "unsafe-fp-math"="true" }
attributes #1 = { mustprogress nocallback nofree nosync nounwind willreturn memory(argmem: readwrite) }
attributes #2 = { mustprogress nocallback nofree nosync nounwind speculatable willreturn memory(none) }
attributes #3 = { nounwind uwtable "approx-func-fp-math"="true" "denormal-fp-math"="preserve-sign,preserve-sign" "min-legal-vector-width"="0" "no-infs-fp-math"="true" "no-nans-fp-math"="true" "no-signed-zeros-fp-math"="true" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" "unsafe-fp-math"="true" }
attributes #4 = { "approx-func-fp-math"="true" "denormal-fp-math"="preserve-sign,preserve-sign" "no-infs-fp-math"="true" "no-nans-fp-math"="true" "no-signed-zeros-fp-math"="true" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" "unsafe-fp-math"="true" }
attributes #5 = { nofree nounwind "approx-func-fp-math"="true" "denormal-fp-math"="preserve-sign,preserve-sign" "no-infs-fp-math"="true" "no-nans-fp-math"="true" "no-signed-zeros-fp-math"="true" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" "unsafe-fp-math"="true" }
attributes #6 = { nofree nounwind }
attributes #7 = { nounwind }

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
