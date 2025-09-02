#import "../format.typ" : *
#import "../math.typ" : *
#import "./UC.typ" : *

#let OTP = $sans("OTP")$
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
  )<UC-Ideal-NIZK-Arg>
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

        *Create*: Upon receiving $(create, sid, s_otp, z)$ from the sender $P$, ignore if $(z, s_otp) in.not Rel$. Send $(prove, x)$ to $calS$ and wait for answer $(proofTxt, pi)$. Upon receiving the answer store $(z, pi)$ and send $(proofTxt, sid, pi)$ to $P$. Also, send $create$ to the receiver and store $s_otp$

        *Verifying Phase*: Upon receiving $(verify, sid, $z$, pi)$ from party $V$ check whether $(z, pi)$ is stored. If not, send $(verify, z)$ to $calS$ and wait for answer $(witness, w)$. Upon receiving the answer, check whether $(z, w) in Rel$ and if yes, store $(z, pi)$. If $(z, pi)$ has been stored return $(verification, sid, accept)$ to $V$ and store $accepted$ else return $(verification, sid, reject)$.

        *Execute*: Upon receiving $(execute, sid, x in {0, 1}^b)$ from the receiver, if $s_otp$ is stored and $accepted$ is stored, u, compute $y = f(s_otp, x)$ and delete $s_otp$ and $accepted$.
      ]
    ],
    caption: [
      OTP ideal functionality $calF_OTP$ for program $f : {0, 1}^a times {0, 1}^b -> {0, 1}^c$ #if citation != 0 { [#cite(citation)] } // TODO: would be nice to have a better citation system rather than just passing it in
    ],
  )<UC-Ideal-NIZK-Arg>
]


