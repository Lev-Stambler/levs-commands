#import "../format.typ" : *
#import "../math.typ" : *
#import "./UC.typ" : *

#let OTP = $sans("OTP")$
#let OTPComp = $sans("OTP")^*$
#let VOTP = $"Ver-"sans("OTP")$
#let otp = $sans("otp")$
#let votp = $sans("v-otp")$
#let crs = $mono("crs")$
#let create = $bold("create")$
#let execute = $bold("execute")$
#let verify = $bold("verify")$
#let proofTxt = $bold("proof")$
#let prove = $bold("prove")$
#let Rel = $calR$
#let accepted = $mono("accepted")$
#let witness = $bold("witness")$
#let verification = $bold("verification")$
#let accept = $mono("accept")$
#let reject = $mono("reject")$


#let UC-OTP(citation) = [
  #figure(
    kind: "ideal",
    supplement: [Ideal Functionality],
    fbox[
      #align(center)[*Functionality* $calF_OTP$]
      #align(left)[
        Running parties $P_1, dots, P_n$ and adversary $calS$:

        *Create*: Upon receiving $(create, sid, s_otp)$ from the sender, send $create$ to the receiver and store $s_otp$

        *Execute*: Upon receiving $(execute, sid, x in {0, 1}^b)$ from the receiver, if $s_otp$ is stored, compute $y = f(s_otp, x)$ and delete $s_otp$.
      ]
    ],
    caption: [
      OTP ideal functionality $calF_OTP$ for program $f : {0, 1}^a times {0, 1}^b -> {0, 1}^c$ #cite(citation) // TODO: would be nice to have a better citation system rather than just passing it in
    ],
  )<UC-Ideal-OTP>
]

#let UC-OTPComp() = [
  #figure(
    kind: "ideal",
    supplement: [Ideal Functionality],
    fbox[
      #align(center)[*Functionality* $calF_OTPComp$]
      #align(left)[
        Parameterized by non-interactive ideal functionalities $calF_1, dots, calF_m$ and running parties $P_1, dots, P_n$ and adversary $calS$:

        *Create*: Upon receiving $(create, sid, s_otp)$ from the sender, send $create$ to the receiver and store $s_otp$

        *Execute*: Upon receiving $(execute, sid, x in {0, 1}^b)$ from the receiver, if $s_otp$ is stored, compute $y = f^(calF_1, dots, calF_m)(s_otp, x)$ and delete $s_otp$.
      ]
    ],
    caption: [
      Composable OTP ideal functionality $calF_OTPComp$ for program $f^(calF_1, dots, calF_m) : {0, 1}^a times {0, 1}^b -> {0, 1}^c$ and non-interactive ideal functionalities $calF_1, dots, calF_m$
    ],
  )<UC-Ideal-OTPComp>
]



#let VerOTP = $"Ver-"sans("OTP")$
#let UC-VerOTP(citation: 0) = [
  #figure(
    kind: "ideal",
    supplement: [Ideal Functionality],
    fbox[
      // https://dl.acm.org/doi/pdf/10.1145/2220357.2220358?casa_token=XYrP0sGDY-sAAAAA:bagPvzoelujdyMPr4vOtS4Q_fTvB5Pc0D_lfa_g2PsQu3dhY6wYUrbmYiq1cQX_-mzsbSK9Fpw Page 21 ideal func
      #align(center)[*Functionality* $calF_VerOTP$]
      #align(left)[
        Parameterized with relation $Rel$ Running parties $P_1, dots, P_n$ and adversary $calS$:

        *Create*: Upon receiving $(create, sid, s_otp, z)$ from the sender $P$, ignore if $(z, s_otp) in.not Rel$. Send $(prove, z)$ to $calS$ and wait for answer $(proofTxt, pi, s^*)$.
        If $s^* != bot$, set $s_otp = s^*$.  // allows simulator to change secret if needed
        Send $(proofTxt, sid, pi)$ to $P$. Also, send $create$ to the receiver and store $(z, pi, s_otp)$

        *Verifying Phase*: Upon receiving $(verify, sid, $z$, pi)$ from party $V$ check whether $(z, pi, s_otp)$ is stored.
        //If not, send $(verify, z)$ to $calS$ and wait for answer $(witness, w)$. Upon receiving the answer, check whether $(z, w) in Rel$ and if yes, store $(z, pi)$. TODO: we do not use this as we have an assumed "injectivity" with the secret
        If $(z, pi, s_otp)$ has been stored return $(verification, sid, accept)$ to $V$ and store $accepted$ else return $(verification, sid, reject)$.

        *Execute*: Upon receiving $(execute, sid, x in {0, 1}^b)$ from the receiver, if $s_otp$ is stored and $accepted$ is stored, u, compute $y = f(s_otp, x)$ and delete $s_otp$ and $accepted$.
      ]
    ],
    caption: [
      Verifiable OTP ideal functionality $calF_VerOTP$ for program $f : {0, 1}^a times {0, 1}^b -> {0, 1}^c$ #if citation != 0 { [#cite(citation)] } // TODO: would be nice to have a better citation system rather than just passing it in
    ],
  )<UC-Ideal-VerOTP>
]


