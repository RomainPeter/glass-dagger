; ModuleID = 'pendulum_opt_enzyme.ll'
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
define dso_local nofpclass(nan inf) double @loss_omega1(double noundef nofpclass(nan inf) %omega1_0, double noundef nofpclass(nan inf) %omega2_0) local_unnamed_addr #0 {
entry:
  %0 = insertelement <2 x double> poison, double %omega1_0, i64 0
  %1 = insertelement <2 x double> %0, double %omega2_0, i64 1
  br label %for.body

for.cond.cleanup:                                 ; preds = %for.body
  %2 = tail call fast <2 x double> @llvm.sin.v2f64(<2 x double> %139)
  %shift = shufflevector <2 x double> %2, <2 x double> poison, <2 x i32> <i32 1, i32 poison>
  %3 = fadd fast <2 x double> %2, %shift
  %4 = extractelement <2 x double> %139, i64 0
  %5 = tail call fast double @llvm.cos.f64(double %4)
  %6 = extractelement <2 x double> %139, i64 1
  %7 = tail call fast double @llvm.cos.f64(double %6)
  %8 = fadd fast double %5, %7
  %sub57 = fsub fast double 1.800000e+00, %8
  %9 = fmul fast <2 x double> %3, %3
  %mul58 = extractelement <2 x double> %9, i64 0
  %mul59 = fmul fast double %sub57, %sub57
  %mul61 = fmul fast double %omega1_0, %omega1_0
  %mul62 = fmul fast double %omega2_0, %omega2_0
  %add63 = fadd fast double %mul62, %mul61
  %mul64 = fmul fast double %add63, 1.000000e-03
  %add60 = fadd fast double %mul58, %mul64
  %add65 = fadd fast double %add60, %mul59
  ret double %add65

for.body:                                         ; preds = %for.body, %entry
  %i.0183 = phi i32 [ 0, %entry ], [ %inc, %for.body ]
  %10 = phi <2 x double> [ %1, %entry ], [ %140, %for.body ]
  %11 = phi <2 x double> [ <double 0x3FE921FB54442D18, double 0x3FE0C152382D7365>, %entry ], [ %139, %for.body ]
  %12 = extractelement <2 x double> %11, i64 0
  %13 = extractelement <2 x double> %11, i64 1
  %sub.i = fsub fast double %12, %13
  %14 = tail call fast double @llvm.cos.f64(double %sub.i)
  %15 = tail call fast double @llvm.sin.f64(double %sub.i)
  %mul1.i = fmul fast double %sub.i, 2.000000e+00
  %16 = tail call fast double @llvm.cos.f64(double %mul1.i)
  %sub3.i = fsub fast double 3.000000e+00, %16
  %17 = tail call fast double @llvm.sin.f64(double %12)
  %mul7.i = fmul fast double %17, -2.943000e+01
  %mul9.i = fmul fast double %13, 2.000000e+00
  %sub10.i = fsub fast double %12, %mul9.i
  %18 = tail call fast double @llvm.sin.f64(double %sub10.i)
  %19 = fmul fast <2 x double> %10, %10
  %20 = extractelement <2 x double> %19, i64 0
  %mul19.i = fmul fast double %14, %20
  %21 = extractelement <2 x double> %19, i64 1
  %add20.i = fadd fast double %mul19.i, %21
  %mul28.i = fmul fast double %20, 2.000000e+00
  %22 = tail call fast double @llvm.cos.f64(double %12)
  %mul31.i = fmul fast double %22, 1.962000e+01
  %add32.i = fadd fast double %mul28.i, %mul31.i
  %23 = insertelement <2 x double> poison, double %18, i64 0
  %24 = insertelement <2 x double> %23, double %14, i64 1
  %25 = insertelement <2 x double> %19, double -9.810000e+00, i64 0
  %26 = fmul fast <2 x double> %24, %25
  %27 = fmul fast <2 x double> %10, <double 5.000000e-04, double 5.000000e-04>
  %28 = fadd fast <2 x double> %27, %11
  %29 = extractelement <2 x double> %28, i64 0
  %30 = extractelement <2 x double> %28, i64 1
  %sub.i93 = fsub fast double %29, %30
  %31 = tail call fast double @llvm.cos.f64(double %sub.i93)
  %32 = tail call fast double @llvm.sin.f64(double %sub.i93)
  %mul1.i94 = fmul fast double %sub.i93, 2.000000e+00
  %33 = tail call fast double @llvm.cos.f64(double %mul1.i94)
  %sub3.i95 = fsub fast double 3.000000e+00, %33
  %34 = tail call fast double @llvm.sin.f64(double %29)
  %mul7.i96 = fmul fast double %34, -2.943000e+01
  %mul9.i97 = fmul fast double %30, 2.000000e+00
  %sub10.i98 = fsub fast double %29, %mul9.i97
  %35 = tail call fast double @llvm.sin.f64(double %sub10.i98)
  %mul13.i99 = fmul fast double %32, 2.000000e+00
  %36 = tail call fast double @llvm.cos.f64(double %29)
  %mul31.i109 = fmul fast double %36, 1.962000e+01
  %mul13.i = fmul fast double %15, 2.000000e+00
  %37 = fmul fast double %add20.i, %mul13.i
  %38 = insertelement <2 x double> poison, double %mul7.i, i64 0
  %39 = insertelement <2 x double> %38, double %add32.i, i64 1
  %40 = fadd fast <2 x double> %26, %39
  %41 = insertelement <2 x double> poison, double %37, i64 0
  %42 = insertelement <2 x double> %41, double %mul13.i, i64 1
  %43 = fsub fast <2 x double> %40, %42
  %44 = fmul fast <2 x double> %40, %42
  %45 = shufflevector <2 x double> %43, <2 x double> %44, <2 x i32> <i32 0, i32 3>
  %46 = insertelement <2 x double> poison, double %sub3.i, i64 0
  %47 = shufflevector <2 x double> %46, <2 x double> poison, <2 x i32> zeroinitializer
  %48 = fdiv fast <2 x double> %45, %47
  %49 = fmul fast <2 x double> %48, <double 5.000000e-04, double 5.000000e-04>
  %50 = fadd fast <2 x double> %49, %10
  %51 = fmul fast <2 x double> %50, %50
  %52 = extractelement <2 x double> %51, i64 0
  %mul19.i102 = fmul fast double %52, %31
  %53 = extractelement <2 x double> %51, i64 1
  %add20.i103 = fadd fast double %mul19.i102, %53
  %54 = fmul fast double %add20.i103, %mul13.i99
  %55 = insertelement <2 x double> poison, double %35, i64 0
  %56 = shufflevector <2 x double> %55, <2 x double> %51, <2 x i32> <i32 0, i32 2>
  %57 = fmul fast <2 x double> %56, <double -9.810000e+00, double 2.000000e+00>
  %mul36.i111 = fmul fast double %53, %31
  %add32.i110 = fadd fast double %mul36.i111, %mul31.i109
  %58 = insertelement <2 x double> poison, double %mul7.i96, i64 0
  %59 = insertelement <2 x double> %58, double %add32.i110, i64 1
  %60 = fadd fast <2 x double> %57, %59
  %61 = insertelement <2 x double> poison, double %54, i64 0
  %62 = insertelement <2 x double> %61, double %mul13.i99, i64 1
  %63 = fsub fast <2 x double> %60, %62
  %64 = fmul fast <2 x double> %60, %62
  %65 = shufflevector <2 x double> %63, <2 x double> %64, <2 x i32> <i32 0, i32 3>
  %66 = insertelement <2 x double> poison, double %sub3.i95, i64 0
  %67 = shufflevector <2 x double> %66, <2 x double> poison, <2 x i32> zeroinitializer
  %68 = fdiv fast <2 x double> %65, %67
  %69 = fmul fast <2 x double> %50, <double 5.000000e-04, double 5.000000e-04>
  %70 = fadd fast <2 x double> %69, %11
  %71 = fmul fast <2 x double> %68, <double 5.000000e-04, double 5.000000e-04>
  %72 = fadd fast <2 x double> %71, %10
  %73 = extractelement <2 x double> %70, i64 0
  %74 = extractelement <2 x double> %70, i64 1
  %sub.i115 = fsub fast double %73, %74
  %75 = tail call fast double @llvm.cos.f64(double %sub.i115)
  %76 = tail call fast double @llvm.sin.f64(double %sub.i115)
  %mul1.i116 = fmul fast double %sub.i115, 2.000000e+00
  %77 = tail call fast double @llvm.cos.f64(double %mul1.i116)
  %sub3.i117 = fsub fast double 3.000000e+00, %77
  %78 = tail call fast double @llvm.sin.f64(double %73)
  %mul7.i118 = fmul fast double %78, -2.943000e+01
  %mul9.i119 = fmul fast double %74, 2.000000e+00
  %sub10.i120 = fsub fast double %73, %mul9.i119
  %79 = tail call fast double @llvm.sin.f64(double %sub10.i120)
  %mul13.i121 = fmul fast double %76, 2.000000e+00
  %80 = fmul fast <2 x double> %72, %72
  %81 = extractelement <2 x double> %80, i64 0
  %mul19.i124 = fmul fast double %81, %75
  %82 = extractelement <2 x double> %80, i64 1
  %add20.i125 = fadd fast double %mul19.i124, %82
  %83 = fmul fast double %add20.i125, %mul13.i121
  %84 = insertelement <2 x double> poison, double %79, i64 0
  %85 = shufflevector <2 x double> %84, <2 x double> %80, <2 x i32> <i32 0, i32 2>
  %86 = fmul fast <2 x double> %85, <double -9.810000e+00, double 2.000000e+00>
  %87 = tail call fast double @llvm.cos.f64(double %73)
  %mul31.i131 = fmul fast double %87, 1.962000e+01
  %mul36.i133 = fmul fast double %82, %75
  %add32.i132 = fadd fast double %mul36.i133, %mul31.i131
  %88 = insertelement <2 x double> poison, double %mul7.i118, i64 0
  %89 = insertelement <2 x double> %88, double %add32.i132, i64 1
  %90 = fadd fast <2 x double> %86, %89
  %91 = insertelement <2 x double> poison, double %83, i64 0
  %92 = insertelement <2 x double> %91, double %mul13.i121, i64 1
  %93 = fsub fast <2 x double> %90, %92
  %94 = fmul fast <2 x double> %90, %92
  %95 = shufflevector <2 x double> %93, <2 x double> %94, <2 x i32> <i32 0, i32 3>
  %96 = insertelement <2 x double> poison, double %sub3.i117, i64 0
  %97 = shufflevector <2 x double> %96, <2 x double> poison, <2 x i32> zeroinitializer
  %98 = fdiv fast <2 x double> %95, %97
  %99 = fmul fast <2 x double> %72, <double 1.000000e-03, double 1.000000e-03>
  %100 = fadd fast <2 x double> %99, %11
  %101 = fmul fast <2 x double> %98, <double 1.000000e-03, double 1.000000e-03>
  %102 = fadd fast <2 x double> %101, %10
  %103 = extractelement <2 x double> %100, i64 0
  %104 = extractelement <2 x double> %100, i64 1
  %sub.i137 = fsub fast double %103, %104
  %105 = tail call fast double @llvm.cos.f64(double %sub.i137)
  %106 = tail call fast double @llvm.sin.f64(double %sub.i137)
  %mul1.i138 = fmul fast double %sub.i137, 2.000000e+00
  %107 = tail call fast double @llvm.cos.f64(double %mul1.i138)
  %sub3.i139 = fsub fast double 3.000000e+00, %107
  %108 = tail call fast double @llvm.sin.f64(double %103)
  %mul7.i140 = fmul fast double %108, -2.943000e+01
  %mul9.i141 = fmul fast double %104, 2.000000e+00
  %sub10.i142 = fsub fast double %103, %mul9.i141
  %109 = tail call fast double @llvm.sin.f64(double %sub10.i142)
  %110 = fmul fast <2 x double> %102, %102
  %111 = extractelement <2 x double> %110, i64 0
  %mul19.i146 = fmul fast double %111, %105
  %112 = extractelement <2 x double> %110, i64 1
  %add20.i147 = fadd fast double %mul19.i146, %112
  %mul28.i152 = fmul fast double %111, 2.000000e+00
  %113 = tail call fast double @llvm.cos.f64(double %103)
  %mul31.i153 = fmul fast double %113, 1.962000e+01
  %add32.i154 = fadd fast double %mul28.i152, %mul31.i153
  %mul13.i143 = fmul fast double %106, 2.000000e+00
  %114 = fmul fast double %add20.i147, %mul13.i143
  %115 = insertelement <2 x double> %110, double %109, i64 0
  %116 = insertelement <2 x double> <double -9.810000e+00, double poison>, double %105, i64 1
  %117 = fmul fast <2 x double> %115, %116
  %118 = insertelement <2 x double> poison, double %mul7.i140, i64 0
  %119 = insertelement <2 x double> %118, double %add32.i154, i64 1
  %120 = fadd fast <2 x double> %117, %119
  %121 = insertelement <2 x double> poison, double %114, i64 0
  %122 = insertelement <2 x double> %121, double %mul13.i143, i64 1
  %123 = fsub fast <2 x double> %120, %122
  %124 = fmul fast <2 x double> %120, %122
  %125 = shufflevector <2 x double> %123, <2 x double> %124, <2 x i32> <i32 0, i32 3>
  %126 = insertelement <2 x double> poison, double %sub3.i139, i64 0
  %127 = shufflevector <2 x double> %126, <2 x double> poison, <2 x i32> zeroinitializer
  %128 = fdiv fast <2 x double> %125, %127
  %129 = fadd fast <2 x double> %72, %50
  %130 = fmul fast <2 x double> %129, <double 2.000000e+00, double 2.000000e+00>
  %131 = fadd fast <2 x double> %130, %10
  %132 = fadd fast <2 x double> %131, %102
  %133 = fmul fast <2 x double> %132, <double 0x3F25D867C3ECE2A5, double 0x3F25D867C3ECE2A5>
  %134 = fadd fast <2 x double> %98, %68
  %135 = fmul fast <2 x double> %134, <double 2.000000e+00, double 2.000000e+00>
  %136 = fadd fast <2 x double> %135, %48
  %137 = fadd fast <2 x double> %136, %128
  %138 = fmul fast <2 x double> %137, <double 0x3F25D867C3ECE2A5, double 0x3F25D867C3ECE2A5>
  %139 = fadd fast <2 x double> %133, %11
  %140 = fadd fast <2 x double> %138, %10
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
define dso_local nofpclass(nan inf) double @loss_omega2(double noundef nofpclass(nan inf) %omega2_0, double noundef nofpclass(nan inf) %omega1_0) local_unnamed_addr #0 {
entry:
  %call = tail call fast nofpclass(nan inf) double @loss_omega1(double noundef nofpclass(nan inf) %omega1_0, double noundef nofpclass(nan inf) %omega2_0)
  ret double %call
}

; Function Attrs: nofree norecurse nosync nounwind uwtable
define dso_local nofpclass(nan inf) double @dloss_domega1(double noundef nofpclass(nan inf) %omega1_0, double noundef nofpclass(nan inf) %omega2_0) local_unnamed_addr #3 {
entry:
  %0 = tail call fastcc { double, double } @diffeloss_omega1(double %omega1_0, double %omega2_0)
  %1 = extractvalue { double, double } %0, 0
  ret double %1
}

; Function Attrs: nofree norecurse nosync nounwind uwtable
define dso_local nofpclass(nan inf) double @dloss_domega2(double noundef nofpclass(nan inf) %omega1_0, double noundef nofpclass(nan inf) %omega2_0) local_unnamed_addr #3 {
entry:
  %0 = tail call fastcc { double, double } @diffeloss_omega1(double %omega1_0, double %omega2_0)
  %1 = extractvalue { double, double } %0, 1
  ret double %1
}

; Function Attrs: nounwind uwtable
define dso_local i32 @main() local_unnamed_addr #4 {
if.end.peel:
  %y0 = alloca %struct.State, align 8
  %yT = alloca %struct.State, align 8
  %x2 = alloca double, align 8
  %y2 = alloca double, align 8
  %puts = tail call i32 @puts(ptr nonnull dereferenceable(1) @str)
  %call1 = tail call i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @.str.1, double noundef nofpclass(nan inf) 0.000000e+00, double noundef nofpclass(nan inf) -1.800000e+00, double noundef nofpclass(nan inf) 1.000000e+00)
  %call2 = tail call fast nofpclass(nan inf) double @loss_omega1(double noundef nofpclass(nan inf) 0.000000e+00, double noundef nofpclass(nan inf) 0.000000e+00)
  %call3 = tail call i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @.str.2, double noundef nofpclass(nan inf) 0.000000e+00, double noundef nofpclass(nan inf) 0.000000e+00, double noundef nofpclass(nan inf) %call2)
  %0 = tail call fastcc { double, double } @diffeloss_omega1(double 0.000000e+00, double 0.000000e+00)
  %1 = extractvalue { double, double } %0, 0
  %2 = tail call fastcc { double, double } @diffeloss_omega1(double 0.000000e+00, double 0.000000e+00)
  %3 = extractvalue { double, double } %2, 1
  %4 = insertelement <2 x double> poison, double %3, i64 0
  %5 = insertelement <2 x double> %4, double %1, i64 1
  %6 = fmul fast <2 x double> %5, <double -2.000000e-02, double -2.000000e-02>
  %7 = extractelement <2 x double> %6, i64 0
  %8 = extractelement <2 x double> %6, i64 1
  %call8.peel = tail call fast nofpclass(nan inf) double @loss_omega1(double noundef nofpclass(nan inf) %8, double noundef nofpclass(nan inf) %7)
  %call12.peel = tail call i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @.str.3, i32 noundef 1, double noundef nofpclass(nan inf) %8, double noundef nofpclass(nan inf) %7, double noundef nofpclass(nan inf) %call8.peel)
  %cmp13.peel = fcmp fast uge double %call8.peel, 0x3EB0C6F7A0B5ED8D
  br i1 %cmp13.peel, label %for.cond, label %cleanup18

for.cond:                                         ; preds = %if.end.peel, %if.end
  %i.0 = phi i32 [ %add, %if.end ], [ 1, %if.end.peel ]
  %9 = phi <2 x double> [ %19, %if.end ], [ %6, %if.end.peel ]
  %exitcond.not = icmp eq i32 %i.0, 200
  %10 = extractelement <2 x double> %9, i64 0
  %11 = extractelement <2 x double> %9, i64 1
  br i1 %exitcond.not, label %cleanup18, label %for.body

for.body:                                         ; preds = %for.cond
  %12 = tail call fastcc { double, double } @diffeloss_omega1(double %11, double %10)
  %13 = extractvalue { double, double } %12, 0
  %14 = tail call fastcc { double, double } @diffeloss_omega1(double %11, double %10)
  %15 = extractvalue { double, double } %14, 1
  %16 = insertelement <2 x double> poison, double %15, i64 0
  %17 = insertelement <2 x double> %16, double %13, i64 1
  %18 = fmul fast <2 x double> %17, <double 2.000000e-02, double 2.000000e-02>
  %19 = fsub fast <2 x double> %9, %18
  %20 = extractelement <2 x double> %19, i64 0
  %21 = extractelement <2 x double> %19, i64 1
  %call8 = tail call fast nofpclass(nan inf) double @loss_omega1(double noundef nofpclass(nan inf) %21, double noundef nofpclass(nan inf) %20)
  %add = add nuw nsw i32 %i.0, 1
  %rem.lhs.trunc = trunc i32 %add to i8
  %rem78 = urem i8 %rem.lhs.trunc, 10
  %cmp9 = icmp eq i8 %rem78, 0
  br i1 %cmp9, label %if.then, label %if.end

if.then:                                          ; preds = %for.body
  %call12 = tail call i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @.str.3, i32 noundef %add, double noundef nofpclass(nan inf) %21, double noundef nofpclass(nan inf) %20, double noundef nofpclass(nan inf) %call8)
  br label %if.end

if.end:                                           ; preds = %if.then, %for.body
  %cmp13 = fcmp fast uge double %call8, 0x3EB0C6F7A0B5ED8D
  br i1 %cmp13, label %for.cond, label %cleanup18, !llvm.loop !7

cleanup18:                                        ; preds = %if.end, %for.cond, %if.end.peel
  %omega2.1 = phi double [ %7, %if.end.peel ], [ %10, %for.cond ], [ %20, %if.end ]
  %omega1.1 = phi double [ %8, %if.end.peel ], [ %11, %for.cond ], [ %21, %if.end ]
  call void @llvm.lifetime.start.p0(i64 32, ptr nonnull %y0) #12
  store double 0x3FE921FB54442D18, ptr %y0, align 8, !tbaa !9
  %omega119 = getelementptr inbounds %struct.State, ptr %y0, i64 0, i32 1
  store double %omega1.1, ptr %omega119, align 8, !tbaa !14
  %theta2 = getelementptr inbounds %struct.State, ptr %y0, i64 0, i32 2
  store double 0x3FE0C152382D7365, ptr %theta2, align 8, !tbaa !15
  %omega220 = getelementptr inbounds %struct.State, ptr %y0, i64 0, i32 3
  store double %omega2.1, ptr %omega220, align 8, !tbaa !16
  call void @llvm.lifetime.start.p0(i64 32, ptr nonnull %yT) #12
  call void @simulate(ptr dead_on_unwind nonnull writable sret(%struct.State) align 8 %yT, ptr noundef nonnull byval(%struct.State) align 8 %y0, i32 noundef 1000, double noundef nofpclass(nan inf) 1.000000e-03, ptr noundef nonnull @params) #12
  call void @llvm.lifetime.start.p0(i64 8, ptr nonnull %x2) #12
  call void @llvm.lifetime.start.p0(i64 8, ptr nonnull %y2) #12
  call void @get_bob2_position(ptr noundef nonnull %yT, ptr noundef nonnull @params, ptr noundef nonnull %x2, ptr noundef nonnull %y2) #12
  %puts74 = call i32 @puts(ptr nonnull dereferenceable(1) @str.11)
  %call22 = call i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @.str.5, double noundef nofpclass(nan inf) %omega1.1, double noundef nofpclass(nan inf) %omega2.1)
  %22 = load double, ptr %x2, align 8, !tbaa !17
  %23 = load double, ptr %y2, align 8, !tbaa !17
  %call23 = call i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @.str.6, double noundef nofpclass(nan inf) %22, double noundef nofpclass(nan inf) %23)
  %call24 = call i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @.str.7, double noundef nofpclass(nan inf) 0.000000e+00, double noundef nofpclass(nan inf) -1.800000e+00)
  %24 = load double, ptr %x2, align 8, !tbaa !17
  %mul27 = fmul fast double %24, %24
  %25 = load double, ptr %y2, align 8, !tbaa !17
  %sub28 = fadd fast double %25, 1.800000e+00
  %mul30 = fmul fast double %sub28, %sub28
  %add31 = fadd fast double %mul30, %mul27
  %26 = call fast double @llvm.sqrt.f64(double %add31)
  %call32 = call i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @.str.8, double noundef nofpclass(nan inf) %26)
  %27 = load double, ptr %x2, align 8, !tbaa !17
  %mul35 = fmul fast double %27, %27
  %28 = load double, ptr %y2, align 8, !tbaa !17
  %sub36 = fadd fast double %28, 1.800000e+00
  %mul38 = fmul fast double %sub36, %sub36
  %add39 = fadd fast double %mul38, %mul35
  %29 = call fast double @llvm.sqrt.f64(double %add39)
  %cmp40 = fcmp fast uge double %29, 3.000000e-01
  %str.13.str.12 = select i1 %cmp40, ptr @str.12, ptr @str.13
  %. = zext i1 %cmp40 to i32
  %puts75 = call i32 @puts(ptr nonnull dereferenceable(1) %str.13.str.12)
  call void @llvm.lifetime.end.p0(i64 8, ptr nonnull %y2) #12
  call void @llvm.lifetime.end.p0(i64 8, ptr nonnull %x2) #12
  call void @llvm.lifetime.end.p0(i64 32, ptr nonnull %yT) #12
  call void @llvm.lifetime.end.p0(i64 32, ptr nonnull %y0) #12
  ret i32 %.
}

; Function Attrs: nofree nounwind
declare noundef i32 @printf(ptr nocapture noundef readonly, ...) local_unnamed_addr #5

declare void @simulate(ptr dead_on_unwind writable sret(%struct.State) align 8, ptr noundef byval(%struct.State) align 8, i32 noundef, double noundef nofpclass(nan inf), ptr noundef) local_unnamed_addr #6

declare void @get_bob2_position(ptr noundef, ptr noundef, ptr noundef, ptr noundef) local_unnamed_addr #6

; Function Attrs: mustprogress nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare double @llvm.sqrt.f64(double) #2

; Function Attrs: nofree nounwind
declare noundef i32 @puts(ptr nocapture noundef readonly) local_unnamed_addr #7

; Function Attrs: mustprogress nofree norecurse nosync nounwind memory(readwrite, argmem: none) uwtable
define internal fastcc { double, double } @diffeloss_omega1(double noundef nofpclass(nan inf) %omega1_0, double noundef nofpclass(nan inf) %omega2_0) unnamed_addr #8 {
entry:
  %theta1.0187_malloccache = tail call noalias nonnull dereferenceable(8000) dereferenceable_or_null(8000) ptr @malloc(i64 8000), !enzyme_cache_alloc !18
  %omega1.0186_malloccache = tail call noalias nonnull dereferenceable(8000) dereferenceable_or_null(8000) ptr @malloc(i64 8000), !enzyme_cache_alloc !20
  %theta2.0185_malloccache = tail call noalias nonnull dereferenceable(8000) dereferenceable_or_null(8000) ptr @malloc(i64 8000), !enzyme_cache_alloc !22
  %omega2.0184_malloccache = tail call noalias nonnull dereferenceable(8000) dereferenceable_or_null(8000) ptr @malloc(i64 8000), !enzyme_cache_alloc !24
  %0 = insertelement <2 x double> poison, double %omega1_0, i64 0
  %1 = insertelement <2 x double> %0, double %omega2_0, i64 1
  br label %for.body

for.cond.cleanup:                                 ; preds = %for.body
  %2 = extractelement <2 x double> %149, i64 0
  %3 = tail call fast double @llvm.sin.f64(double %2) #13
  %4 = extractelement <2 x double> %149, i64 1
  %5 = tail call fast double @llvm.sin.f64(double %4) #13
  %add53 = fadd fast double %3, %5
  %6 = tail call fast <2 x double> @llvm.cos.v2f64(<2 x double> %149)
  %shift = shufflevector <2 x double> %6, <2 x double> poison, <2 x i32> <i32 1, i32 poison>
  %7 = fadd fast <2 x double> %6, %shift
  %8 = extractelement <2 x double> %7, i64 0
  %9 = fmul fast <2 x double> %1, <double 2.000000e-03, double 2.000000e-03>
  %10 = fmul fast double %8, 2.000000e+00
  %factor = fsub fast double 3.600000e+00, %10
  %factor301 = fmul fast double %add53, 2.000000e+00
  %11 = insertelement <2 x double> poison, double %factor, i64 0
  %12 = shufflevector <2 x double> %11, <2 x double> poison, <2 x i32> zeroinitializer
  %13 = insertelement <2 x double> poison, double %3, i64 0
  %14 = insertelement <2 x double> %13, double %5, i64 1
  %15 = fmul fast <2 x double> %12, %14
  %16 = insertelement <2 x double> poison, double %factor301, i64 0
  %17 = shufflevector <2 x double> %16, <2 x double> poison, <2 x i32> zeroinitializer
  %18 = fmul fast <2 x double> %17, %6
  %19 = fadd fast <2 x double> %15, %18
  br label %invertfor.body

for.body:                                         ; preds = %for.body, %entry
  %iv = phi i64 [ %iv.next, %for.body ], [ 0, %entry ]
  %20 = phi <2 x double> [ %150, %for.body ], [ %1, %entry ]
  %21 = phi <2 x double> [ %149, %for.body ], [ <double 0x3FE921FB54442D18, double 0x3FE0C152382D7365>, %entry ]
  %22 = getelementptr inbounds double, ptr %theta1.0187_malloccache, i64 %iv
  %23 = extractelement <2 x double> %21, i64 0
  store double %23, ptr %22, align 8, !invariant.group !26
  %24 = getelementptr inbounds double, ptr %omega2.0184_malloccache, i64 %iv
  %25 = extractelement <2 x double> %20, i64 1
  store double %25, ptr %24, align 8, !invariant.group !27
  %26 = getelementptr inbounds double, ptr %theta2.0185_malloccache, i64 %iv
  %27 = extractelement <2 x double> %21, i64 1
  store double %27, ptr %26, align 8, !invariant.group !28
  %28 = getelementptr inbounds double, ptr %omega1.0186_malloccache, i64 %iv
  %29 = extractelement <2 x double> %20, i64 0
  store double %29, ptr %28, align 8, !invariant.group !29
  %iv.next = add nuw i64 %iv, 1
  %sub.i = fsub fast double %23, %27
  %30 = tail call fast double @llvm.cos.f64(double %sub.i) #13
  %31 = tail call fast double @llvm.sin.f64(double %sub.i) #13
  %mul1.i = fmul fast double %sub.i, 2.000000e+00
  %32 = tail call fast double @llvm.cos.f64(double %mul1.i) #13
  %sub3.i = fsub fast double 3.000000e+00, %32
  %33 = tail call fast double @llvm.sin.f64(double %23) #13
  %mul7.i = fmul fast double %33, -2.943000e+01
  %mul9.i = fmul fast double %27, 2.000000e+00
  %sub10.i = fsub fast double %23, %mul9.i
  %34 = tail call fast double @llvm.sin.f64(double %sub10.i) #13
  %mul13.i = fmul fast double %31, 2.000000e+00
  %mul11.neg.i = fmul fast double %34, -9.810000e+00
  %.neg.i = fadd fast double %mul11.neg.i, %mul7.i
  %35 = tail call fast double @llvm.cos.f64(double %23) #13
  %mul31.i = fmul fast double %35, 1.962000e+01
  %36 = fmul fast <2 x double> %20, %20
  %37 = extractelement <2 x double> %36, i64 0
  %mul19.i = fmul fast double %30, %37
  %38 = extractelement <2 x double> %36, i64 1
  %add20.i = fadd fast double %mul19.i, %38
  %39 = fmul fast double %add20.i, %mul13.i
  %sub22.i = fsub fast double %.neg.i, %39
  %40 = insertelement <2 x double> <double 2.000000e+00, double poison>, double %30, i64 1
  %41 = fmul fast <2 x double> %40, %36
  %42 = extractelement <2 x double> %41, i64 0
  %add32.i = fadd fast double %42, %mul31.i
  %43 = extractelement <2 x double> %41, i64 1
  %add37.i = fadd fast double %add32.i, %43
  %mul38.i = fmul fast double %add37.i, %mul13.i
  %44 = fmul fast <2 x double> %20, <double 5.000000e-04, double 5.000000e-04>
  %45 = fadd fast <2 x double> %44, %21
  %46 = extractelement <2 x double> %45, i64 0
  %47 = extractelement <2 x double> %45, i64 1
  %sub.i93 = fsub fast double %46, %47
  %48 = tail call fast double @llvm.cos.f64(double %sub.i93) #13
  %49 = tail call fast double @llvm.sin.f64(double %sub.i93) #13
  %mul1.i94 = fmul fast double %sub.i93, 2.000000e+00
  %50 = tail call fast double @llvm.cos.f64(double %mul1.i94) #13
  %sub3.i95 = fsub fast double 3.000000e+00, %50
  %51 = tail call fast double @llvm.sin.f64(double %46) #13
  %mul7.i96 = fmul fast double %51, -2.943000e+01
  %mul9.i97 = fmul fast double %47, 2.000000e+00
  %sub10.i98 = fsub fast double %46, %mul9.i97
  %52 = tail call fast double @llvm.sin.f64(double %sub10.i98) #13
  %53 = tail call fast double @llvm.cos.f64(double %46) #13
  %mul31.i109 = fmul fast double %53, 1.962000e+01
  %54 = insertelement <2 x double> poison, double %sub22.i, i64 0
  %55 = insertelement <2 x double> %54, double %mul38.i, i64 1
  %56 = insertelement <2 x double> poison, double %sub3.i, i64 0
  %57 = shufflevector <2 x double> %56, <2 x double> poison, <2 x i32> zeroinitializer
  %58 = fdiv fast <2 x double> %55, %57
  %59 = fmul fast <2 x double> %58, <double 5.000000e-04, double 5.000000e-04>
  %60 = fadd fast <2 x double> %59, %20
  %61 = fmul fast <2 x double> %60, %60
  %62 = extractelement <2 x double> %61, i64 0
  %mul19.i102 = fmul fast double %62, %48
  %63 = extractelement <2 x double> %61, i64 1
  %add20.i103 = fadd fast double %mul19.i102, %63
  %mul36.i111 = fmul fast double %63, %48
  %add32.i110 = fadd fast double %mul36.i111, %mul31.i109
  %mul13.i99 = fmul fast double %49, 2.000000e+00
  %64 = fmul fast double %add20.i103, %mul13.i99
  %65 = insertelement <2 x double> poison, double %52, i64 0
  %66 = shufflevector <2 x double> %65, <2 x double> %61, <2 x i32> <i32 0, i32 2>
  %67 = fmul fast <2 x double> %66, <double -9.810000e+00, double 2.000000e+00>
  %68 = insertelement <2 x double> poison, double %mul7.i96, i64 0
  %69 = insertelement <2 x double> %68, double %add32.i110, i64 1
  %70 = fadd fast <2 x double> %67, %69
  %71 = insertelement <2 x double> poison, double %64, i64 0
  %72 = insertelement <2 x double> %71, double %mul13.i99, i64 1
  %73 = fsub fast <2 x double> %70, %72
  %74 = fmul fast <2 x double> %70, %72
  %75 = shufflevector <2 x double> %73, <2 x double> %74, <2 x i32> <i32 0, i32 3>
  %76 = insertelement <2 x double> poison, double %sub3.i95, i64 0
  %77 = shufflevector <2 x double> %76, <2 x double> poison, <2 x i32> zeroinitializer
  %78 = fdiv fast <2 x double> %75, %77
  %79 = fmul fast <2 x double> %60, <double 5.000000e-04, double 5.000000e-04>
  %80 = fadd fast <2 x double> %79, %21
  %81 = fmul fast <2 x double> %78, <double 5.000000e-04, double 5.000000e-04>
  %82 = fadd fast <2 x double> %81, %20
  %83 = extractelement <2 x double> %80, i64 0
  %84 = extractelement <2 x double> %80, i64 1
  %sub.i115 = fsub fast double %83, %84
  %85 = tail call fast double @llvm.cos.f64(double %sub.i115) #13
  %86 = tail call fast double @llvm.sin.f64(double %sub.i115) #13
  %mul1.i116 = fmul fast double %sub.i115, 2.000000e+00
  %87 = tail call fast double @llvm.cos.f64(double %mul1.i116) #13
  %sub3.i117 = fsub fast double 3.000000e+00, %87
  %88 = tail call fast double @llvm.sin.f64(double %83) #13
  %mul7.i118 = fmul fast double %88, -2.943000e+01
  %mul9.i119 = fmul fast double %84, 2.000000e+00
  %sub10.i120 = fsub fast double %83, %mul9.i119
  %89 = tail call fast double @llvm.sin.f64(double %sub10.i120) #13
  %mul13.i121 = fmul fast double %86, 2.000000e+00
  %90 = fmul fast <2 x double> %82, %82
  %91 = extractelement <2 x double> %90, i64 0
  %mul19.i124 = fmul fast double %91, %85
  %92 = extractelement <2 x double> %90, i64 1
  %add20.i125 = fadd fast double %mul19.i124, %92
  %93 = fmul fast double %add20.i125, %mul13.i121
  %94 = insertelement <2 x double> poison, double %89, i64 0
  %95 = shufflevector <2 x double> %94, <2 x double> %90, <2 x i32> <i32 0, i32 2>
  %96 = fmul fast <2 x double> %95, <double -9.810000e+00, double 2.000000e+00>
  %97 = tail call fast double @llvm.cos.f64(double %83) #13
  %mul31.i131 = fmul fast double %97, 1.962000e+01
  %mul36.i133 = fmul fast double %92, %85
  %add32.i132 = fadd fast double %mul36.i133, %mul31.i131
  %98 = insertelement <2 x double> poison, double %mul7.i118, i64 0
  %99 = insertelement <2 x double> %98, double %add32.i132, i64 1
  %100 = fadd fast <2 x double> %96, %99
  %101 = insertelement <2 x double> poison, double %93, i64 0
  %102 = insertelement <2 x double> %101, double %mul13.i121, i64 1
  %103 = fsub fast <2 x double> %100, %102
  %104 = fmul fast <2 x double> %100, %102
  %105 = shufflevector <2 x double> %103, <2 x double> %104, <2 x i32> <i32 0, i32 3>
  %106 = insertelement <2 x double> poison, double %sub3.i117, i64 0
  %107 = shufflevector <2 x double> %106, <2 x double> poison, <2 x i32> zeroinitializer
  %108 = fdiv fast <2 x double> %105, %107
  %109 = fmul fast <2 x double> %82, <double 1.000000e-03, double 1.000000e-03>
  %110 = fadd fast <2 x double> %109, %21
  %111 = fmul fast <2 x double> %108, <double 1.000000e-03, double 1.000000e-03>
  %112 = fadd fast <2 x double> %111, %20
  %113 = extractelement <2 x double> %110, i64 0
  %114 = extractelement <2 x double> %110, i64 1
  %sub.i137 = fsub fast double %113, %114
  %115 = tail call fast double @llvm.cos.f64(double %sub.i137) #13
  %116 = tail call fast double @llvm.sin.f64(double %sub.i137) #13
  %mul1.i138 = fmul fast double %sub.i137, 2.000000e+00
  %117 = tail call fast double @llvm.cos.f64(double %mul1.i138) #13
  %sub3.i139 = fsub fast double 3.000000e+00, %117
  %118 = tail call fast double @llvm.sin.f64(double %113) #13
  %mul7.i140 = fmul fast double %118, -2.943000e+01
  %mul9.i141 = fmul fast double %114, 2.000000e+00
  %sub10.i142 = fsub fast double %113, %mul9.i141
  %119 = tail call fast double @llvm.sin.f64(double %sub10.i142) #13
  %120 = fmul fast <2 x double> %112, %112
  %121 = extractelement <2 x double> %120, i64 0
  %mul19.i146 = fmul fast double %121, %115
  %122 = extractelement <2 x double> %120, i64 1
  %add20.i147 = fadd fast double %mul19.i146, %122
  %mul28.i152 = fmul fast double %121, 2.000000e+00
  %123 = tail call fast double @llvm.cos.f64(double %113) #13
  %mul31.i153 = fmul fast double %123, 1.962000e+01
  %add32.i154 = fadd fast double %mul28.i152, %mul31.i153
  %124 = fadd fast <2 x double> %82, %60
  %125 = fmul fast <2 x double> %124, <double 2.000000e+00, double 2.000000e+00>
  %126 = fadd fast <2 x double> %125, %20
  %127 = fadd fast <2 x double> %126, %112
  %128 = fmul fast <2 x double> %127, <double 0x3F25D867C3ECE2A5, double 0x3F25D867C3ECE2A5>
  %mul13.i143 = fmul fast double %116, 2.000000e+00
  %129 = fmul fast double %add20.i147, %mul13.i143
  %130 = insertelement <2 x double> %120, double %119, i64 0
  %131 = insertelement <2 x double> <double -9.810000e+00, double poison>, double %115, i64 1
  %132 = fmul fast <2 x double> %130, %131
  %133 = insertelement <2 x double> poison, double %mul7.i140, i64 0
  %134 = insertelement <2 x double> %133, double %add32.i154, i64 1
  %135 = fadd fast <2 x double> %132, %134
  %136 = insertelement <2 x double> poison, double %129, i64 0
  %137 = insertelement <2 x double> %136, double %mul13.i143, i64 1
  %138 = fsub fast <2 x double> %135, %137
  %139 = fmul fast <2 x double> %135, %137
  %140 = shufflevector <2 x double> %138, <2 x double> %139, <2 x i32> <i32 0, i32 3>
  %141 = insertelement <2 x double> poison, double %sub3.i139, i64 0
  %142 = shufflevector <2 x double> %141, <2 x double> poison, <2 x i32> zeroinitializer
  %143 = fdiv fast <2 x double> %140, %142
  %144 = fadd fast <2 x double> %108, %78
  %145 = fmul fast <2 x double> %144, <double 2.000000e+00, double 2.000000e+00>
  %146 = fadd fast <2 x double> %145, %58
  %147 = fadd fast <2 x double> %146, %143
  %148 = fmul fast <2 x double> %147, <double 0x3F25D867C3ECE2A5, double 0x3F25D867C3ECE2A5>
  %149 = fadd fast <2 x double> %128, %21
  %150 = fadd fast <2 x double> %148, %20
  %151 = and i64 %iv, 4294967295
  %exitcond.not = icmp eq i64 %151, 999
  br i1 %exitcond.not, label %for.cond.cleanup, label %for.body, !llvm.loop !5

invertentry:                                      ; preds = %invertfor.body
  %152 = extractelement <2 x double> %468, i64 0
  %153 = insertvalue { double, double } undef, double %152, 0
  %154 = extractelement <2 x double> %468, i64 1
  %155 = insertvalue { double, double } %153, double %154, 1
  tail call void @free(ptr nonnull %theta1.0187_malloccache), !enzyme_cache_free !18
  tail call void @free(ptr nonnull %omega1.0186_malloccache), !enzyme_cache_free !20
  tail call void @free(ptr nonnull %theta2.0185_malloccache), !enzyme_cache_free !22
  tail call void @free(ptr nonnull %omega2.0184_malloccache), !enzyme_cache_free !24
  ret { double, double } %155

invertfor.body:                                   ; preds = %incinvertfor.body, %for.cond.cleanup
  %"iv'ac.0" = phi i64 [ 999, %for.cond.cleanup ], [ %515, %incinvertfor.body ]
  %156 = phi <2 x double> [ zeroinitializer, %for.cond.cleanup ], [ %464, %incinvertfor.body ]
  %157 = phi <2 x double> [ %19, %for.cond.cleanup ], [ %514, %incinvertfor.body ]
  %158 = phi <2 x double> [ %9, %for.cond.cleanup ], [ %468, %incinvertfor.body ]
  %159 = fmul fast <2 x double> %156, <double 0x3F25D867C3ECE2A5, double 0x3F25D867C3ECE2A5>
  %160 = fmul fast <2 x double> %157, <double 0x3F25D867C3ECE2A5, double 0x3F25D867C3ECE2A5>
  %161 = fmul fast <2 x double> %157, <double 0x3F35D867C3ECE2A5, double 0x3F35D867C3ECE2A5>
  %162 = fmul fast <2 x double> %156, <double 0x3F35D867C3ECE2A5, double 0x3F35D867C3ECE2A5>
  %163 = getelementptr inbounds double, ptr %theta1.0187_malloccache, i64 %"iv'ac.0"
  %164 = load double, ptr %163, align 8, !invariant.group !26
  %165 = getelementptr inbounds double, ptr %omega1.0186_malloccache, i64 %"iv'ac.0"
  %166 = load double, ptr %165, align 8, !invariant.group !29
  %mul_unwrap = fmul fast double %166, 5.000000e-04
  %add_unwrap = fadd fast double %mul_unwrap, %164
  %167 = getelementptr inbounds double, ptr %theta2.0185_malloccache, i64 %"iv'ac.0"
  %168 = load double, ptr %167, align 8, !invariant.group !28
  %169 = getelementptr inbounds double, ptr %omega2.0184_malloccache, i64 %"iv'ac.0"
  %170 = load double, ptr %169, align 8, !invariant.group !27
  %mul3_unwrap = fmul fast double %170, 5.000000e-04
  %add4_unwrap = fadd fast double %mul3_unwrap, %168
  %mul9.i97_unwrap = fmul fast double %add4_unwrap, 2.000000e+00
  %171 = tail call fast double @llvm.sin.f64(double %add_unwrap) #13
  %mul7.i96_unwrap = fmul fast double %171, -2.943000e+01
  %mul9.i_unwrap = fmul fast double %168, 2.000000e+00
  %sub10.i_unwrap = fsub fast double %164, %mul9.i_unwrap
  %172 = tail call fast double @llvm.sin.f64(double %sub10.i_unwrap) #13
  %mul11.neg.i_unwrap = fmul fast double %172, -9.810000e+00
  %173 = tail call fast double @llvm.sin.f64(double %164) #13
  %mul7.i_unwrap = fmul fast double %173, -2.943000e+01
  %.neg.i_unwrap = fadd fast double %mul11.neg.i_unwrap, %mul7.i_unwrap
  %sub.i_unwrap = fsub fast double %164, %168
  %174 = tail call fast double @llvm.cos.f64(double %sub.i_unwrap) #13
  %mul17.i_unwrap = fmul fast double %166, %166
  %mul19.i_unwrap = fmul fast double %174, %mul17.i_unwrap
  %mul15.i_unwrap = fmul fast double %170, %170
  %add20.i_unwrap = fadd fast double %mul19.i_unwrap, %mul15.i_unwrap
  %175 = tail call fast double @llvm.sin.f64(double %sub.i_unwrap) #13
  %mul1.i_unwrap = fmul fast double %sub.i_unwrap, 2.000000e+00
  %176 = tail call fast double @llvm.cos.f64(double %mul1.i_unwrap) #13
  %sub3.i_unwrap = fsub fast double 3.000000e+00, %176
  %177 = tail call fast double @llvm.cos.f64(double %164) #13
  %mul31.i_unwrap = fmul fast double %177, 1.962000e+01
  %mul28.i_unwrap = fmul fast double %mul17.i_unwrap, 2.000000e+00
  %add32.i_unwrap = fadd fast double %mul28.i_unwrap, %mul31.i_unwrap
  %mul36.i_unwrap = fmul fast double %174, %mul15.i_unwrap
  %add37.i_unwrap = fadd fast double %add32.i_unwrap, %mul36.i_unwrap
  %178 = tail call fast double @llvm.cos.f64(double %add_unwrap) #13
  %mul31.i109_unwrap = fmul fast double %178, 1.962000e+01
  %179 = icmp eq i64 %"iv'ac.0", 0
  %180 = insertelement <2 x double> poison, double %add_unwrap, i64 0
  %181 = shufflevector <2 x double> %180, <2 x double> poison, <2 x i32> zeroinitializer
  %182 = insertelement <2 x double> poison, double %add4_unwrap, i64 0
  %183 = insertelement <2 x double> %182, double %mul9.i97_unwrap, i64 1
  %184 = fsub fast <2 x double> %181, %183
  %185 = extractelement <2 x double> %184, i64 1
  %186 = tail call fast double @llvm.sin.f64(double %185) #13
  %mul11.neg.i104_unwrap = fmul fast double %186, -9.810000e+00
  %.neg.i105_unwrap = fadd fast double %mul11.neg.i104_unwrap, %mul7.i96_unwrap
  %187 = insertelement <2 x double> poison, double %175, i64 0
  %188 = shufflevector <2 x double> %187, <2 x double> poison, <2 x i32> zeroinitializer
  %189 = fmul fast <2 x double> %188, <double -2.000000e+00, double 2.000000e+00>
  %190 = extractelement <2 x double> %189, i64 1
  %191 = fmul fast double %add20.i_unwrap, %190
  %sub22.i_unwrap = fsub fast double %.neg.i_unwrap, %191
  %mul38.i_unwrap = fmul fast double %add37.i_unwrap, %190
  %192 = insertelement <2 x double> poison, double %sub22.i_unwrap, i64 0
  %193 = insertelement <2 x double> %192, double %mul38.i_unwrap, i64 1
  %194 = insertelement <2 x double> poison, double %sub3.i_unwrap, i64 0
  %195 = shufflevector <2 x double> %194, <2 x double> poison, <2 x i32> zeroinitializer
  %196 = fdiv fast <2 x double> %193, %195
  %197 = fmul fast <2 x double> %196, <double 5.000000e-04, double 5.000000e-04>
  %198 = insertelement <2 x double> poison, double %166, i64 0
  %199 = insertelement <2 x double> %198, double %170, i64 1
  %200 = fadd fast <2 x double> %197, %199
  %201 = tail call fast <2 x double> @llvm.cos.v2f64(<2 x double> %184)
  %202 = extractelement <2 x double> %184, i64 0
  %203 = tail call fast double @llvm.sin.f64(double %202) #13
  %204 = insertelement <2 x double> poison, double %203, i64 0
  %205 = shufflevector <2 x double> %204, <2 x double> poison, <2 x i32> zeroinitializer
  %206 = fmul fast <2 x double> %205, <double -2.000000e+00, double 2.000000e+00>
  %207 = extractelement <2 x double> %206, i64 1
  %mul1.i94_unwrap = fmul fast double %202, 2.000000e+00
  %208 = tail call fast double @llvm.cos.f64(double %mul1.i94_unwrap) #13
  %sub3.i95_unwrap = fsub fast double 3.000000e+00, %208
  %209 = insertelement <2 x double> poison, double %sub3.i95_unwrap, i64 0
  %210 = shufflevector <2 x double> %209, <2 x double> poison, <2 x i32> zeroinitializer
  %211 = fmul fast <2 x double> %200, <double 5.000000e-04, double 5.000000e-04>
  %212 = insertelement <2 x double> poison, double %164, i64 0
  %213 = insertelement <2 x double> %212, double %168, i64 1
  %214 = fadd fast <2 x double> %211, %213
  %215 = extractelement <2 x double> %214, i64 1
  %mul9.i119_unwrap = fmul fast double %215, 2.000000e+00
  %216 = extractelement <2 x double> %214, i64 0
  %sub10.i120_unwrap = fsub fast double %216, %mul9.i119_unwrap
  %217 = tail call fast double @llvm.sin.f64(double %sub10.i120_unwrap) #13
  %218 = tail call fast double @llvm.sin.f64(double %216) #13
  %mul7.i118_unwrap = fmul fast double %218, -2.943000e+01
  %sub.i115_unwrap = fsub fast double %216, %215
  %219 = tail call fast double @llvm.cos.f64(double %sub.i115_unwrap) #13
  %220 = tail call fast double @llvm.sin.f64(double %sub.i115_unwrap) #13
  %221 = insertelement <2 x double> poison, double %220, i64 0
  %222 = shufflevector <2 x double> %221, <2 x double> poison, <2 x i32> zeroinitializer
  %223 = fmul fast <2 x double> %222, <double -2.000000e+00, double 2.000000e+00>
  %224 = extractelement <2 x double> %223, i64 1
  %mul1.i116_unwrap = fmul fast double %sub.i115_unwrap, 2.000000e+00
  %225 = tail call fast double @llvm.cos.f64(double %mul1.i116_unwrap) #13
  %sub3.i117_unwrap = fsub fast double 3.000000e+00, %225
  %226 = tail call fast double @llvm.cos.f64(double %216) #13
  %mul31.i131_unwrap = fmul fast double %226, 1.962000e+01
  %227 = insertelement <2 x double> poison, double %217, i64 0
  %228 = insertelement <2 x double> poison, double %mul7.i118_unwrap, i64 0
  %229 = insertelement <2 x double> poison, double %sub3.i117_unwrap, i64 0
  %230 = shufflevector <2 x double> %229, <2 x double> poison, <2 x i32> zeroinitializer
  %231 = insertelement <2 x double> poison, double %219, i64 0
  %232 = shufflevector <2 x double> %231, <2 x double> poison, <2 x i32> zeroinitializer
  %233 = tail call fast double @llvm.cos.f64(double %sub10.i120_unwrap)
  %234 = tail call fast double @llvm.sin.f64(double %mul1.i116_unwrap)
  %235 = fmul fast double %234, 2.000000e+00
  %236 = insertelement <2 x double> %232, double %233, i64 1
  %237 = fmul fast <2 x double> %236, <double 2.000000e+00, double -9.810000e+00>
  %238 = shufflevector <2 x double> %201, <2 x double> poison, <2 x i32> zeroinitializer
  %239 = fmul fast <2 x double> %200, %200
  %shift2 = shufflevector <2 x double> %239, <2 x double> poison, <2 x i32> <i32 1, i32 poison>
  %240 = fmul fast <2 x double> %shift2, %201
  %mul36.i111_unwrap = extractelement <2 x double> %240, i64 0
  %add32.i110_unwrap = fadd fast double %mul36.i111_unwrap, %mul31.i109_unwrap
  %241 = shufflevector <2 x double> %239, <2 x double> poison, <2 x i32> zeroinitializer
  %242 = insertelement <2 x double> %201, double 2.000000e+00, i64 1
  %243 = fmul fast <2 x double> %241, %242
  %244 = shufflevector <2 x double> %239, <2 x double> poison, <2 x i32> <i32 1, i32 poison>
  %245 = insertelement <2 x double> %244, double %add32.i110_unwrap, i64 1
  %246 = fadd fast <2 x double> %243, %245
  %247 = extractelement <2 x double> %246, i64 0
  %248 = fmul fast double %247, %207
  %sub22.i106_unwrap = fsub fast double %.neg.i105_unwrap, %248
  %249 = fmul fast <2 x double> %246, %206
  %250 = insertelement <2 x double> %249, double %sub22.i106_unwrap, i64 0
  %251 = fdiv fast <2 x double> %250, %210
  %252 = fmul fast <2 x double> %251, <double 5.000000e-04, double 5.000000e-04>
  %253 = fadd fast <2 x double> %252, %199
  %254 = fmul fast <2 x double> %253, <double 1.000000e-03, double 1.000000e-03>
  %255 = fadd fast <2 x double> %254, %213
  %256 = extractelement <2 x double> %255, i64 0
  %257 = extractelement <2 x double> %255, i64 1
  %sub.i137_unwrap = fsub fast double %256, %257
  %mul1.i138_unwrap = fmul fast double %sub.i137_unwrap, 2.000000e+00
  %258 = tail call fast double @llvm.cos.f64(double %mul1.i138_unwrap) #13
  %sub3.i139_unwrap = fsub fast double 3.000000e+00, %258
  %259 = tail call fast double @llvm.cos.f64(double %256) #13
  %260 = tail call fast double @llvm.cos.f64(double %sub.i137_unwrap) #13
  %261 = tail call fast double @llvm.sin.f64(double %sub.i137_unwrap) #13
  %262 = insertelement <2 x double> poison, double %sub3.i139_unwrap, i64 0
  %263 = shufflevector <2 x double> %262, <2 x double> poison, <2 x i32> zeroinitializer
  %264 = fdiv fast <2 x double> %159, %263
  %265 = insertelement <2 x double> poison, double %261, i64 0
  %266 = shufflevector <2 x double> %265, <2 x double> poison, <2 x i32> zeroinitializer
  %267 = fmul fast <2 x double> %266, <double -2.000000e+00, double 2.000000e+00>
  %268 = fmul fast <2 x double> %267, %264
  %269 = tail call fast double @llvm.sin.f64(double %256)
  %270 = extractelement <2 x double> %268, i64 1
  %271 = fmul fast double %270, 2.000000e+00
  %mul9.i141_unwrap = fmul fast double %257, 2.000000e+00
  %sub10.i142_unwrap = fsub fast double %256, %mul9.i141_unwrap
  %272 = tail call fast double @llvm.sin.f64(double %sub10.i142_unwrap) #13
  %273 = extractelement <2 x double> %264, i64 0
  %274 = insertelement <2 x double> poison, double %260, i64 0
  %275 = shufflevector <2 x double> %274, <2 x double> poison, <2 x i32> zeroinitializer
  %276 = fmul fast <2 x double> %268, %275
  %277 = shufflevector <2 x double> %268, <2 x double> poison, <2 x i32> <i32 poison, i32 0>
  %278 = insertelement <2 x double> %277, double %271, i64 0
  %279 = fadd fast <2 x double> %276, %278
  %280 = tail call fast double @llvm.cos.f64(double %sub10.i142_unwrap)
  %281 = insertelement <2 x double> poison, double %269, i64 0
  %282 = insertelement <2 x double> %281, double %280, i64 1
  %283 = fmul fast <2 x double> %282, <double -1.962000e+01, double -9.810000e+00>
  %284 = shufflevector <2 x double> %268, <2 x double> %264, <2 x i32> <i32 1, i32 2>
  %285 = fmul fast <2 x double> %283, %284
  %286 = fmul fast double %259, -2.943000e+01
  %287 = fmul fast double %286, %273
  %288 = tail call fast double @llvm.sin.f64(double %mul1.i138_unwrap)
  %289 = fmul fast double %288, 2.000000e+00
  %290 = fmul fast double %260, 2.000000e+00
  %291 = extractelement <2 x double> %285, i64 1
  %292 = fadd fast double %287, %291
  %293 = insertelement <2 x double> <double poison, double -2.000000e+00>, double %292, i64 0
  %294 = fadd fast <2 x double> %285, %293
  %295 = fmul fast <2 x double> %285, %293
  %296 = shufflevector <2 x double> %294, <2 x double> %295, <2 x i32> <i32 0, i32 3>
  %297 = fmul fast <2 x double> %253, %253
  %298 = extractelement <2 x double> %297, i64 0
  %mul19.i124_unwrap = fmul fast double %298, %219
  %299 = extractelement <2 x double> %297, i64 1
  %add20.i125_unwrap = fadd fast double %mul19.i124_unwrap, %299
  %300 = fmul fast double %add20.i125_unwrap, %224
  %mul36.i133_unwrap = fmul fast double %299, %219
  %add32.i132_unwrap = fadd fast double %mul36.i133_unwrap, %mul31.i131_unwrap
  %301 = shufflevector <2 x double> %227, <2 x double> %297, <2 x i32> <i32 0, i32 2>
  %302 = fmul fast <2 x double> %301, <double -9.810000e+00, double 2.000000e+00>
  %303 = insertelement <2 x double> %228, double %add32.i132_unwrap, i64 1
  %304 = fadd fast <2 x double> %302, %303
  %305 = insertelement <2 x double> %223, double %300, i64 0
  %306 = fsub fast <2 x double> %304, %305
  %307 = fmul fast <2 x double> %304, %305
  %308 = shufflevector <2 x double> %306, <2 x double> %307, <2 x i32> <i32 0, i32 3>
  %309 = fdiv fast <2 x double> %308, %230
  %310 = fmul fast <2 x double> %309, <double 1.000000e-03, double 1.000000e-03>
  %311 = fadd fast <2 x double> %310, %199
  %312 = fmul fast <2 x double> %311, %311
  %313 = extractelement <2 x double> %312, i64 0
  %314 = extractelement <2 x double> %312, i64 1
  %mul19.i146_unwrap = fmul fast double %313, %260
  %add20.i147_unwrap = fadd fast double %mul19.i146_unwrap, %314
  %315 = insertelement <2 x double> %281, double %259, i64 1
  %316 = fmul fast <2 x double> %315, <double 2.943000e+01, double 1.962000e+01>
  %317 = shufflevector <2 x double> %312, <2 x double> poison, <2 x i32> <i32 poison, i32 0>
  %318 = insertelement <2 x double> %317, double %272, i64 0
  %319 = fmul fast <2 x double> %318, <double 9.810000e+00, double 2.000000e+00>
  %320 = fadd fast <2 x double> %319, %316
  %321 = insertelement <2 x double> poison, double %add20.i147_unwrap, i64 0
  %322 = insertelement <2 x double> %321, double %260, i64 1
  %323 = shufflevector <2 x double> %267, <2 x double> %312, <2 x i32> <i32 1, i32 3>
  %324 = fmul fast <2 x double> %322, %323
  %325 = fadd fast <2 x double> %320, %324
  %326 = fmul fast <2 x double> %325, %264
  %327 = extractelement <2 x double> %326, i64 1
  %328 = shufflevector <2 x double> %264, <2 x double> %268, <2 x i32> <i32 0, i32 3>
  %329 = fmul fast <2 x double> %325, %328
  %shift3 = shufflevector <2 x double> %329, <2 x double> poison, <2 x i32> <i32 1, i32 poison>
  %330 = fsub fast <2 x double> %329, %shift3
  %331 = extractelement <2 x double> %330, i64 0
  %332 = fmul fast double %add20.i147_unwrap, %273
  %333 = fsub fast double %327, %332
  %334 = fmul fast <2 x double> %312, %268
  %shift4 = shufflevector <2 x double> %334, <2 x double> poison, <2 x i32> <i32 1, i32 poison>
  %335 = fadd fast <2 x double> %shift4, %334
  %336 = extractelement <2 x double> %335, i64 0
  %337 = fmul fast <2 x double> %311, <double 2.000000e+00, double 2.000000e+00>
  %338 = fmul fast <2 x double> %337, %279
  %339 = fadd fast <2 x double> %338, %160
  %340 = fmul fast double %289, %331
  %341 = fdiv fast double %340, %sub3.i139_unwrap
  %342 = fmul fast double %290, %333
  %.neg305 = fmul fast double %336, %261
  %343 = fsub fast double %342, %.neg305
  %344 = fadd fast double %343, %341
  %345 = insertelement <2 x double> poison, double %344, i64 0
  %346 = shufflevector <2 x double> %345, <2 x double> poison, <2 x i32> zeroinitializer
  %347 = fadd fast <2 x double> %296, %346
  %348 = fsub fast <2 x double> %296, %346
  %349 = shufflevector <2 x double> %347, <2 x double> %348, <2 x i32> <i32 0, i32 3>
  %350 = fmul fast <2 x double> %339, <double 1.000000e-03, double 1.000000e-03>
  %351 = fadd fast <2 x double> %350, %162
  %352 = fmul fast <2 x double> %349, <double 1.000000e-03, double 1.000000e-03>
  %353 = fdiv fast <2 x double> %351, %230
  %354 = fmul fast <2 x double> %223, %353
  %355 = extractelement <2 x double> %354, i64 1
  %356 = fmul fast double %355, 2.000000e+00
  %357 = insertelement <2 x double> %304, double %add20.i125_unwrap, i64 0
  %358 = fmul fast <2 x double> %353, %357
  %shift5 = shufflevector <2 x double> %358, <2 x double> poison, <2 x i32> <i32 1, i32 poison>
  %359 = fsub fast <2 x double> %shift5, %358
  %360 = fmul fast <2 x double> %354, %232
  %361 = shufflevector <2 x double> %354, <2 x double> poison, <2 x i32> <i32 poison, i32 0>
  %362 = insertelement <2 x double> %361, double %356, i64 0
  %363 = fadd fast <2 x double> %360, %362
  %364 = fmul fast <2 x double> %354, %297
  %shift6 = shufflevector <2 x double> %364, <2 x double> poison, <2 x i32> <i32 1, i32 poison>
  %365 = fadd fast <2 x double> %shift6, %364
  %366 = extractelement <2 x double> %365, i64 0
  %367 = fmul fast <2 x double> %253, <double 2.000000e+00, double 2.000000e+00>
  %368 = fmul fast <2 x double> %367, %363
  %369 = fadd fast <2 x double> %352, %161
  %370 = fadd fast <2 x double> %369, %368
  %371 = insertelement <2 x double> poison, double %226, i64 0
  %372 = insertelement <2 x double> %371, double %218, i64 1
  %373 = fmul fast <2 x double> %372, <double -2.943000e+01, double -1.962000e+01>
  %374 = shufflevector <2 x double> %353, <2 x double> %354, <2 x i32> <i32 0, i32 3>
  %375 = fmul fast <2 x double> %373, %374
  %376 = fmul fast <2 x double> %353, %309
  %shift7 = shufflevector <2 x double> %376, <2 x double> poison, <2 x i32> <i32 1, i32 poison>
  %377 = fadd fast <2 x double> %shift7, %376
  %378 = extractelement <2 x double> %377, i64 0
  %379 = fmul fast double %235, %378
  %380 = shufflevector <2 x double> %353, <2 x double> poison, <2 x i32> <i32 poison, i32 0>
  %381 = shufflevector <2 x double> %359, <2 x double> %380, <2 x i32> <i32 0, i32 3>
  %382 = fmul fast <2 x double> %237, %381
  %383 = fmul fast double %366, %220
  %384 = fadd fast double %379, %383
  %385 = insertelement <2 x double> <double poison, double -2.000000e+00>, double %384, i64 0
  %386 = fsub fast <2 x double> %382, %385
  %387 = fmul fast <2 x double> %382, %385
  %388 = shufflevector <2 x double> %386, <2 x double> %387, <2 x i32> <i32 0, i32 3>
  %shift8 = shufflevector <2 x double> %382, <2 x double> poison, <2 x i32> <i32 1, i32 poison>
  %389 = fadd fast <2 x double> %375, %shift8
  %shift9 = shufflevector <2 x double> %375, <2 x double> poison, <2 x i32> <i32 1, i32 poison>
  %390 = fadd fast <2 x double> %389, %shift9
  %391 = shufflevector <2 x double> %386, <2 x double> poison, <2 x i32> <i32 poison, i32 0>
  %392 = shufflevector <2 x double> %390, <2 x double> %391, <2 x i32> <i32 0, i32 3>
  %393 = fadd fast <2 x double> %388, %392
  %394 = fsub fast <2 x double> %388, %392
  %395 = shufflevector <2 x double> %393, <2 x double> %394, <2 x i32> <i32 0, i32 3>
  %396 = fmul fast <2 x double> %370, <double 5.000000e-04, double 5.000000e-04>
  %397 = fadd fast <2 x double> %396, %162
  %398 = fmul fast <2 x double> %395, <double 5.000000e-04, double 5.000000e-04>
  %399 = fdiv fast <2 x double> %397, %210
  %400 = fmul fast <2 x double> %206, %399
  %401 = extractelement <2 x double> %400, i64 1
  %402 = fmul fast double %401, 2.000000e+00
  %403 = fmul fast <2 x double> %399, %246
  %shift10 = shufflevector <2 x double> %403, <2 x double> poison, <2 x i32> <i32 1, i32 poison>
  %404 = fsub fast <2 x double> %shift10, %403
  %405 = fmul fast <2 x double> %400, %238
  %406 = shufflevector <2 x double> %400, <2 x double> poison, <2 x i32> <i32 poison, i32 0>
  %407 = insertelement <2 x double> %406, double %402, i64 0
  %408 = fadd fast <2 x double> %405, %407
  %409 = fmul fast <2 x double> %400, %239
  %shift11 = shufflevector <2 x double> %409, <2 x double> poison, <2 x i32> <i32 1, i32 poison>
  %410 = fadd fast <2 x double> %shift11, %409
  %411 = extractelement <2 x double> %410, i64 0
  %412 = fmul fast <2 x double> %200, <double 2.000000e+00, double 2.000000e+00>
  %413 = fmul fast <2 x double> %412, %408
  %414 = fadd fast <2 x double> %398, %161
  %415 = fadd fast <2 x double> %414, %413
  %416 = insertelement <2 x double> poison, double %178, i64 0
  %417 = insertelement <2 x double> %416, double %171, i64 1
  %418 = fmul fast <2 x double> %417, <double -2.943000e+01, double -1.962000e+01>
  %419 = shufflevector <2 x double> %399, <2 x double> %400, <2 x i32> <i32 0, i32 3>
  %420 = fmul fast <2 x double> %418, %419
  %421 = fmul fast <2 x double> %399, %251
  %shift12 = shufflevector <2 x double> %421, <2 x double> poison, <2 x i32> <i32 1, i32 poison>
  %422 = fadd fast <2 x double> %shift12, %421
  %423 = extractelement <2 x double> %422, i64 0
  %424 = tail call fast double @llvm.sin.f64(double %mul1.i94_unwrap)
  %425 = fmul fast double %424, 2.000000e+00
  %426 = fmul fast double %425, %423
  %427 = fmul fast <2 x double> %201, <double 2.000000e+00, double -9.810000e+00>
  %428 = shufflevector <2 x double> %399, <2 x double> poison, <2 x i32> <i32 poison, i32 0>
  %429 = shufflevector <2 x double> %404, <2 x double> %428, <2 x i32> <i32 0, i32 3>
  %430 = fmul fast <2 x double> %427, %429
  %431 = fmul fast double %411, %203
  %432 = fadd fast double %426, %431
  %433 = insertelement <2 x double> <double poison, double -2.000000e+00>, double %432, i64 0
  %434 = fsub fast <2 x double> %430, %433
  %435 = fmul fast <2 x double> %430, %433
  %436 = shufflevector <2 x double> %434, <2 x double> %435, <2 x i32> <i32 0, i32 3>
  %shift13 = shufflevector <2 x double> %430, <2 x double> poison, <2 x i32> <i32 1, i32 poison>
  %437 = fadd fast <2 x double> %420, %shift13
  %shift14 = shufflevector <2 x double> %420, <2 x double> poison, <2 x i32> <i32 1, i32 poison>
  %438 = fadd fast <2 x double> %437, %shift14
  %439 = shufflevector <2 x double> %434, <2 x double> poison, <2 x i32> <i32 poison, i32 0>
  %440 = shufflevector <2 x double> %438, <2 x double> %439, <2 x i32> <i32 0, i32 3>
  %441 = fadd fast <2 x double> %436, %440
  %442 = fsub fast <2 x double> %436, %440
  %443 = shufflevector <2 x double> %441, <2 x double> %442, <2 x i32> <i32 0, i32 3>
  %444 = fmul fast <2 x double> %415, <double 5.000000e-04, double 5.000000e-04>
  %445 = fadd fast <2 x double> %444, %159
  %446 = fmul fast <2 x double> %443, <double 5.000000e-04, double 5.000000e-04>
  %447 = fdiv fast <2 x double> %445, %195
  %448 = fmul fast <2 x double> %189, %447
  %449 = extractelement <2 x double> %448, i64 1
  %450 = fmul fast double %449, 2.000000e+00
  %451 = insertelement <2 x double> poison, double %174, i64 0
  %452 = shufflevector <2 x double> %451, <2 x double> poison, <2 x i32> zeroinitializer
  %453 = fmul fast <2 x double> %448, %452
  %454 = shufflevector <2 x double> %448, <2 x double> poison, <2 x i32> <i32 poison, i32 0>
  %455 = insertelement <2 x double> %454, double %450, i64 0
  %456 = fadd fast <2 x double> %453, %455
  %457 = fmul fast <2 x double> %199, <double 2.000000e+00, double 2.000000e+00>
  %458 = fmul fast <2 x double> %457, %456
  %459 = fadd fast <2 x double> %156, %160
  %460 = fadd fast <2 x double> %459, %339
  %461 = fadd fast <2 x double> %460, %370
  %462 = fadd fast <2 x double> %461, %415
  %463 = fadd fast <2 x double> %462, %446
  %464 = fadd fast <2 x double> %463, %458
  %465 = insertelement <2 x i1> poison, i1 %179, i64 0
  %466 = shufflevector <2 x i1> %465, <2 x i1> poison, <2 x i32> zeroinitializer
  %467 = select <2 x i1> %466, <2 x double> %464, <2 x double> zeroinitializer
  %468 = fadd fast <2 x double> %467, %158
  br i1 %179, label %invertentry, label %incinvertfor.body

incinvertfor.body:                                ; preds = %invertfor.body
  %469 = tail call fast double @llvm.cos.f64(double %sub10.i_unwrap)
  %470 = fmul fast double %469, -9.810000e+00
  %471 = extractelement <2 x double> %447, i64 0
  %472 = fmul fast double %470, %471
  %473 = fmul fast double %472, -2.000000e+00
  %474 = tail call fast double @llvm.sin.f64(double %mul1.i_unwrap)
  %475 = insertelement <2 x double> %196, double %add37.i_unwrap, i64 1
  %476 = fmul fast <2 x double> %447, %475
  %477 = shufflevector <2 x double> %476, <2 x double> poison, <2 x i32> <i32 1, i32 0>
  %478 = insertelement <2 x double> %196, double %add20.i_unwrap, i64 0
  %479 = fmul fast <2 x double> %447, %478
  %480 = fsub fast <2 x double> %477, %479
  %481 = fadd fast <2 x double> %477, %479
  %482 = shufflevector <2 x double> %480, <2 x double> %481, <2 x i32> <i32 0, i32 3>
  %483 = insertelement <2 x double> %451, double %474, i64 1
  %484 = fmul fast <2 x double> %483, <double 2.000000e+00, double 2.000000e+00>
  %485 = fmul fast <2 x double> %484, %482
  %486 = fmul fast double %449, %mul15.i_unwrap
  %487 = extractelement <2 x double> %448, i64 0
  %488 = fmul fast double %487, %mul17.i_unwrap
  %489 = fadd fast double %486, %488
  %490 = fmul fast double %489, %175
  %491 = extractelement <2 x double> %485, i64 1
  %492 = fadd fast double %491, %490
  %493 = extractelement <2 x double> %485, i64 0
  %494 = fsub fast double %493, %492
  %495 = fadd fast <2 x double> %349, %157
  %496 = fadd fast <2 x double> %495, %395
  %497 = fmul fast double %173, -1.962000e+01
  %.neg318 = fmul fast double %497, %449
  %498 = fmul fast double %177, -2.943000e+01
  %499 = fmul fast double %498, %471
  %500 = shufflevector <2 x double> %496, <2 x double> %157, <2 x i32> <i32 0, i32 3>
  %501 = shufflevector <2 x double> %443, <2 x double> %349, <2 x i32> <i32 0, i32 3>
  %502 = fadd fast <2 x double> %500, %501
  %503 = insertelement <2 x double> %395, double %472, i64 0
  %504 = fadd fast <2 x double> %502, %503
  %505 = insertelement <2 x double> %443, double %499, i64 0
  %506 = fadd fast <2 x double> %504, %505
  %507 = insertelement <2 x double> poison, double %.neg318, i64 0
  %508 = insertelement <2 x double> %507, double %473, i64 1
  %509 = fadd fast <2 x double> %506, %508
  %510 = insertelement <2 x double> poison, double %494, i64 0
  %511 = shufflevector <2 x double> %510, <2 x double> poison, <2 x i32> zeroinitializer
  %512 = fadd fast <2 x double> %509, %511
  %513 = fsub fast <2 x double> %509, %511
  %514 = shufflevector <2 x double> %512, <2 x double> %513, <2 x i32> <i32 0, i32 3>
  %515 = add nsw i64 %"iv'ac.0", -1
  br label %invertfor.body
}

; Function Attrs: mustprogress nofree nounwind willreturn allockind("alloc,uninitialized") allocsize(0) memory(inaccessiblemem: readwrite)
declare noalias noundef ptr @malloc(i64 noundef) local_unnamed_addr #9

; Function Attrs: mustprogress nounwind willreturn allockind("free") memory(argmem: readwrite, inaccessiblemem: readwrite)
declare void @free(ptr allocptr nocapture noundef) local_unnamed_addr #10

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare <2 x double> @llvm.sin.v2f64(<2 x double>) #11

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare <2 x double> @llvm.cos.v2f64(<2 x double>) #11

attributes #0 = { nofree norecurse nosync nounwind memory(none) uwtable "approx-func-fp-math"="true" "denormal-fp-math"="preserve-sign,preserve-sign" "min-legal-vector-width"="0" "no-infs-fp-math"="true" "no-nans-fp-math"="true" "no-signed-zeros-fp-math"="true" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" "unsafe-fp-math"="true" }
attributes #1 = { mustprogress nocallback nofree nosync nounwind willreturn memory(argmem: readwrite) }
attributes #2 = { mustprogress nocallback nofree nosync nounwind speculatable willreturn memory(none) }
attributes #3 = { nofree norecurse nosync nounwind uwtable "approx-func-fp-math"="true" "denormal-fp-math"="preserve-sign,preserve-sign" "min-legal-vector-width"="0" "no-infs-fp-math"="true" "no-nans-fp-math"="true" "no-signed-zeros-fp-math"="true" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" "unsafe-fp-math"="true" }
attributes #4 = { nounwind uwtable "approx-func-fp-math"="true" "denormal-fp-math"="preserve-sign,preserve-sign" "min-legal-vector-width"="0" "no-infs-fp-math"="true" "no-nans-fp-math"="true" "no-signed-zeros-fp-math"="true" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" "unsafe-fp-math"="true" }
attributes #5 = { nofree nounwind "approx-func-fp-math"="true" "denormal-fp-math"="preserve-sign,preserve-sign" "no-infs-fp-math"="true" "no-nans-fp-math"="true" "no-signed-zeros-fp-math"="true" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" "unsafe-fp-math"="true" }
attributes #6 = { "approx-func-fp-math"="true" "denormal-fp-math"="preserve-sign,preserve-sign" "no-infs-fp-math"="true" "no-nans-fp-math"="true" "no-signed-zeros-fp-math"="true" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" "unsafe-fp-math"="true" }
attributes #7 = { nofree nounwind }
attributes #8 = { mustprogress nofree norecurse nosync nounwind memory(readwrite, argmem: none) uwtable "approx-func-fp-math"="true" "denormal-fp-math"="preserve-sign,preserve-sign" "min-legal-vector-width"="0" "no-infs-fp-math"="true" "no-nans-fp-math"="true" "no-signed-zeros-fp-math"="true" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" "unsafe-fp-math"="true" }
attributes #9 = { mustprogress nofree nounwind willreturn allockind("alloc,uninitialized") allocsize(0) memory(inaccessiblemem: readwrite) "alloc-family"="malloc" }
attributes #10 = { mustprogress nounwind willreturn allockind("free") memory(argmem: readwrite, inaccessiblemem: readwrite) "alloc-family"="malloc" }
attributes #11 = { nocallback nofree nosync nounwind speculatable willreturn memory(none) }
attributes #12 = { nounwind }
attributes #13 = { mustprogress willreturn }

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
!20 = !{!21}
!21 = distinct !{}
!22 = !{!23}
!23 = distinct !{}
!24 = !{!25}
!25 = distinct !{}
!26 = distinct !{}
!27 = distinct !{}
!28 = distinct !{}
!29 = distinct !{}
