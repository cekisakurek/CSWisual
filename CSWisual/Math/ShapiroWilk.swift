//
//  ShapiroWilk.swift
//  DataAnalyzer
//
//  Created by Cihan E. Kisakurek on 17.08.21.
//  Copyright © 2021 cekisakurek. All rights reserved.
//


import Foundation

enum SwilkError: Error, Equatable {
    
    case noError
    case error1 //if n1 < 3
    case error2 //if n > 5000 (a non-fatal error, but the accuracy of the p-value is not guaranteed in this case)
    case error3 //if n2 < n/2
    case error4 //if n1 > n or (n1 < n and n < 20).
    case error5 //if the proportion censored (n - n1)/n > 0.8.
    case error6 //if the data have zero range.
    case error7 //if the sample values are not sorted in increasing order
    case error8 //if error return from ppnd7 (which should never occur in normal operation)

    // Throw in all other cases
    case unexpected(code: Int)
}

func swilk(x:[Double]) -> (Double, Double, SwilkError) {
    
    func l70() -> (Double, Double, SwilkError) {
        let gamma: Double
        let ld: Double
        let bf: Double
        let z95f: Double
        let z90f: Double
        let zfm: Double
        let zsd: Double
        let z99f: Double
        let zbar: Double
        var m: Double
        var r__1: Double
        var s: Double
        var y: Double
        var xx: Double
        
        
        w = 1.0 - w1
        
        if n == 3 {
            pw = pi6 * (asin(sqrt(w)) - stqr);
            return (0.0, 0.0, SwilkError.noError)
        }
        y = log(w1)
        xx = log(an)
        m = zero
        s = one
        
        if n <= 11 {
            gamma = poly(cc: g, nord: 2, x: an);
            if (y >= gamma) {
                pw = small_value;/* FIXME: rather use an even small_valueer value, or NA ? */
                return (0.0, 0.0, SwilkError.noError)
            }
            y = -log(gamma - y);
            m = poly(cc: c3, nord: 4, x: an);
            s = exp(poly(cc: c4, nord: 4, x: an));
        }
        else {
            m = poly(cc: c5, nord: 4, x: xx);
            s = exp(poly(cc: c6, nord: 3, x: xx));
        }
        
        /*DBG printf("c(w1=%g, w=%g, y=%g, m=%g, s=%g)\n",w1,*w,y,m,s); */
        if (ncens > 0) {/* <==>  n > n1 */
        /*  Censoring by proportion NCENS/N.
            Calculate mean and sd of normal equivalent deviate of W. */

            ld = -log(delta);
            bf = one + xx * bf1;
            r__1 = pow(xx90, Double(xx));
            z90f = z90 + bf * pow(poly(cc: c7, nord: 2, x: r__1), Double(ld))
            r__1 = pow(xx95, Double(xx));
            z95f = z95 + bf * pow(poly(cc: c8, nord: 2, x: r__1), Double(ld));
            z99f = z99 + bf * pow(poly(cc: c9, nord: 2, x: xx), Double(ld));

            /* Regress Z90F,...,Z99F on normal deviates Z90,...,Z99 to get
             * pseudo-mean and pseudo-sd of z as the slope and intercept
             */

            zfm = (z90f + z95f + z99f) / three;
            zsd = (z90 * (z90f - zfm) +
                        z95 * (z95f - zfm) + z99 * (z99f - zfm)) / zss;
            zbar = zfm - zsd * zm;
            m += zbar * s;
            s *= zsd;
        }
        
        pw = alnorm(x: (y-m)/s, upper: true);
        /*  = alnorm_(dble((Y - M)/S), 1); */

        // Results are returned in w, pw and ifault
        return (w,pw, SwilkError.noError)
    }
    
    let zero = 0.0
    let one = 1.0
    let two = 2.0
    let three = 3.0
    
    let z90 = 1.2816
    let z95 = 1.6449
    let z99 = 2.3263
    let zm = 1.7509
    let zss = 0.56268
    let bf1 = 0.8378
    let xx90 = 0.556
    let xx95 = 0.622
    let sqrth = 0.70711 /* sqrt(1/2) = .7071068 */
    let small_value = 1e-19
    let pi6 = 1.909859
    let stqr = 1.047198

    /* polynomial coefficients */
    let g = [-2.273, 0.459]
    let c1 = [0.0, 0.221157, -0.147981, -2.07119, 4.434685, -2.706056]
    let c2 = [0.0, 0.042981, -0.293762,-1.752461,5.682633, -3.582633]
    let c3 = [0.544, -0.39978, 0.025054, -6.714e-4]
    let c4 = [1.3822, -0.77857, 0.062767, -0.0020322]
    let c5 = [-1.5861, -0.31082, -0.083751, 0.0038915]
    let c6 = [-0.4803, -0.082676, 0.0030302]
    let c7 = [0.164, 0.533]
    let c8 = [0.1736, 0.315]
    let c9 = [0.256, -0.00635]
    
    
    /* System generated locals */
    
    let n = x.count
    let n2 = n / 2
    var a = [Double](repeating: 0.0, count: n)

    
    var j: Int
    let ncens: Int
    let i1: Int
    let nn2: Int
    let ssassx: Double
    var summ2: Double
    let ssumm2: Double
    let delta: Double
    let range: Double
    let a1: Double
    let a2: Double
    let an: Double
    
    
    
    var xx: Double
    var sa: Double
    var xi: Double
    var sx: Double
    
    
    var w1: Double
    
    let fac: Double
    var asa: Double
    let an25: Double
    var ssa: Double
    
    var sax: Double
    let rsn: Double
    var ssx: Double
    var xsx: Double
    
    
    var pw = 1.0
    var w = 1.0
    
    an = Double(n)
    nn2 = n / 2
    if n2 < nn2 {
        return (0.0, 0.0, SwilkError.error3)
    }
    
    if n < 3 {
        return (0.0, 0.0, SwilkError.error1)
    }
    
    if n == 3 {
        a[0] = sqrth
    }
    else {
        an25 = an + 0.25
        summ2 = zero
        
        for i in 1...n2 {
            a[i-1] = ppnd7(p: (Double(i) - 0.375) / Double(an25))
            summ2 += (a[i-1] * a[i-1])
        }
        
        summ2 *= two
        ssumm2 = sqrt(summ2)
        rsn = one / sqrt(an)
        a1 = poly(cc: c1, nord: 6, x: rsn) - a[0] / ssumm2;
        
        if n > 5 {
            i1 = 3
            a2 = -a[1] / ssumm2 + poly(cc: c2, nord: 6, x: rsn)
            fac = sqrt((summ2 - two * a[0] * a[0] - two * a[1] * a[1]) / (one - two * a1 * a1 - two * a2 * a2))
            a[1] = a2
        }
        else {
            i1 = 2;
            fac = sqrt((summ2 - two * a[0] * a[0]) / ( one  - two * a1 * a1));
        }
        a[0] = a1;
        for i in i1...nn2 {
            a[i-1] /= -fac
        }
    }
    
    let n1 = n
    
    if n1 < 3 {
        // ifault 1
    }
    ncens = n - n1
    if ncens < 0 || (ncens > 0 && n < 20) {
        // ifault 4
    }
    delta = Double(ncens) / an
    if delta > 0.8 {
        // ifault 5
    }
    
    if w < zero {
        w1 = 1.0 + w
        //ifault 0
        return l70()
    }
    
    
    range = x[n1 - 1] - x[0];
    if range < small_value {
        // ifault 6
        return (0.0, 0.0, SwilkError.error6)
    }
    
    xx = x[0] / range;
    sx = xx;
    sa = -a[0];
    j = n - 1;
    
    for i in 2...n1 {
        xi = x[i-1] / range;
        if (xx - xi > small_value) {
            // ifault 7
            return (0.0, 0.0, SwilkError.error7)
        }
        
        sx += xi;
        if i != j {
            sa += Double(sign(x: 1,y: i - j)) * a[min(i,j)-1];
        }
            xx = xi;
            j -= 1
    }
    if n > 5000 {
        return (0.0, 0.0, SwilkError.error2)
    }
    
    sa /= Double(n1)
    sx /= Double(n1)
    ssa = zero
    ssx = zero
    sax = zero
    j = n
    
    for i in 1...n1 {
        if i != j {
            asa = Double(sign(x: 1,y: i - j)) * a[min(i,j)-1] - sa;
        }
        else {
            asa = -sa
        }
        
        xsx = x[i-1] / range - sx;
        ssa += asa * asa;
        ssx += xsx * xsx;
        sax += asa * xsx;
        
        j -= 1
    }
   
    ssassx = sqrt(ssa * ssx);
    w1 = (ssassx - sax) * (ssassx + sax) / (ssa * ssx);
 
    

    return l70()
    
}


func ppnd7(p: Double) -> Double {
    let zero = 0.0;
    let one = 1.0
    let half = 0.5;
    let split1 = 0.425;
    let split2 = 5.0;
    let const1 = 0.180625;
    let const2 = 1.6;
    let a0 = 3.3871327179E+00;
    let a1 = 5.0434271938E+01;
    let a2 = 1.5929113202E+02;
    let a3 = 5.9109374720E+01;
    let b1 = 1.7895169469E+01;
    let b2 = 7.8757757664E+01;
    let b3 = 6.7187563600E+01;
    let c0 = 1.4234372777E+00;
    let c1 = 2.7568153900E+00;
    let c2 = 1.3067284816E+00;
    let c3 = 1.7023821103E-01;
    let d1 = 7.3700164250E-01;
    let d2 = 1.2021132975E-01;
    let e0 = 6.6579051150E+00;
    let e1 = 3.0812263860E+00;
    let e2 = 4.2868294337E-01;
    let e3 = 1.7337203997E-02;
    let f1 = 2.4197894225E-01;
    let f2 = 1.2258202635E-02;
    
    var normal_dev: Double
    var q: Double
    var r: Double
    
    q = p - half
    
    if abs(q) <= split1 {
        r = const1 - (q * q)
        normal_dev = q * (((a3 * r + a2) * r + a1) * r + a0) /
                             (((b3 * r + b2) * r + b1) * r + one);
        return normal_dev;
    }
    else {
        if q < zero {
            r = p
        }
        else {
            r = one - p
        }
        if r <= zero {
            // fault 1
            normal_dev = zero
            return normal_dev
        }
        r = sqrt(-log(r))
        
        if r <= split2 {
            r = r - const2
            normal_dev = (((c3 * r + c2) * r + c1) * r + c0) / ((d2 * r + d1) * r + one);
        }
        else {
            r = r - split2;
            normal_dev = (((e3 * r + e2) * r + e1) * r + e0) / ((f2 * r + f1) * r + one);
        }
    }
    if (q < zero){
        normal_dev = -normal_dev;
    }
    return normal_dev
}


func poly(cc: [Double], nord: Int, x: Double) -> Double {
    let n2: Int
    var j: Int
    var ret_val = cc[0]
    
    if nord == 1 {
        return ret_val
    }
    var p = x * cc[nord - 1]
    if nord != 2 {
        n2 = nord - 2
        j = n2 + 1
        for _ in 1...n2 {
            p = (p + cc[j-1])*x
            j -= 1
        }
    }
    ret_val = ret_val + p
    return ret_val
}


func sign(x: Int, y: Int) -> Int {
    if y < 0 {
        return -labs(x)
    }
    else {
        return labs(x)
    }
}

func alnorm(x: Double, upper: Bool) -> Double {
    let zero = 0;
    let one = 1;
    let half = 0.5;
    let con = 1.28;
    let ltone = 7.0;
    let utzero = 18.66;
    let p = 0.398942280444;
    let q = 0.39990348504;
    let r = 0.398942280385;
    let a1 = 5.75885480458;
    let a2 = 2.62433121679;
    let a3 = 5.92885724438;
    let b1 = -29.8213557807;
    let b2 = 48.6959930692;
    let c1 = -3.8052E-8;
    let c2 = 3.98064794E-4;
    let c3 = -0.151679116635;
    let c4 = 4.8385912808;
    let c5 = 0.742380924027;
    let c6 = 3.99019417011;
    let d1 = 1.00000615302;
    let d2 = 1.98615381364;
    let d3 = 5.29330324926;
    let d4 = -15.1508972451;
    let d5 = 30.789933034;
    
    var alnorm: Double
    var z: Double
    let y: Double
    var up = upper
    z = x
    
    if Int(z) < zero {
        up = !up
        z = -z
    }
    if (z <= ltone || (up && z <= utzero)) {
        y = half * z * z;
        if (z > con) {
            alnorm = r * exp(-y) / (z + c1 + d1 / (z + c2 + d2 / (z + c3 + d3 / (z + c4 + d4 / (z + c5 + d5 / (z + c6))))));
        } else {
            alnorm = half - z * (p - q * y / (y + a1 + b1 / (y + a2 + b2 / (y + a3))));
        }
    }
    else {
        alnorm = Double(zero)
    }
    if !up {
        alnorm = Double(one) - alnorm
    }
    return alnorm
    
}
