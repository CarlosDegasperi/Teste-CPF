*---------------------------------------------------------------------------*
* DIGITO VERIFICADOR CPF/CGC                                                *
*---------------------------------------------------------------------------*
FUNC DV_CPF
PARA N_0,LL0,CC0,TP0
PRIV N_0,N_1,N_2,N_3,DV_1,DV_2
DO CASE
   CASE LEN(TRIM(N_0))=11
      * C P F --------------------------------------------------------------*
      N_0=SUBS(N_0,01,03)+"."+SUBS(N_0,04,03)+"."+SUBS(N_0,07,03)+"-"+SUBS(N_0,10,02)+SPACE(04)
   CASE LEN(TRIM(N_0))=14 .AND. SUBS(N_0,04,01)!="."
      * C N P J ------------------------------------------------------------*
      N_0=SUBS(N_0,01,02)+"."+SUBS(N_0,03,03)+"."+SUBS(N_0,06,03)+"/"+SUBS(N_0,09,04)+"-"+SUBS(N_0,13,02)
ENDCASE

SAVE SCRE TO T_DV
CD_NOM5:=N_0

DO CASE
   CASE TP0==" "
      CD_CGC1:=N_0
      @ LL0,CC0 SAY TRIM(CD_CGC1)
   * TRANSPORTADOR
   CASE TP0=="T"
      CD_CG11:=N_0
      @ LL0,CC0 SAY CD_CG11
ENDCASE
DO CASE
   * C P F -----------------------------------------------------------------*
   CASE LEN(TRIM(N_0))=14
      N_D=SUBS(N_0,13,02)
      N_0=SUBS(N_0,01,03)+SUBS(N_0,05,03)+SUBS(N_0,09,03)
      N_1=01
      N_2=00
      N_3=09
      DO WHILE N_3>=01
         N_1=N_1+01
         N_2=N_2+(N_1*(VAL(SUBS(N_0,N_3,01))))
         N_3=N_3-01
      ENDDO N_3
      DV_1=11-(N_2-(INT(N_2/11)*11))
      IF DV_1>09
         DV_1=00
      ENDIF
      N_0=N_0+STR(DV_1,01)
      N_1=01
      N_2=00
      N_3=10
      DO WHILE N_3>=02
         N_1=N_1+01
         N_2=N_2+(N_1*(VAL(SUBS(N_0,N_3,01))))
         N_3=N_3-01
      ENDDO N_3
      DV_2=11-(N_2-(INT(N_2/11)*11))
      IF DV_2>09
         DV_2=00
      ENDIF
      DV_0=STR(DV_1,01)+STR(DV_2,01)
*     IF DV_0!=SUBS(CD_CGC1,13,02)
      IF DV_0!=N_D
         DO BEEP
*        DO BEEP
*        RETU(.F.)
         @ 23,11 SAY "NUMERO DO (CPF) INCORRETO !!!"
*        SN=" "
*        @ 23,54 GET SN VALI LASTKEY()=13
*        READ
         INKEY(1.0)                   && AGUARDA 1 SEGUNDO
         @ 23,11 SAY SPACE(65)
         REST SCRE FROM T_DV
         RETU(.F.)
      ELSE
         RETU(.T.)
      ENDIF
   * CNPJ ------------------------------------------------------------------*
   CASE LEN(TRIM(N_0))=18
      CAUX:=SUBSTR(N_0,1,2)+SUBSTR(N_0,4,3)+SUBSTR(N_0,8,3)+SUBSTR(N_0,12,4)
      NVAR1:=0
      NVAR2:=5
      IF (!EMPTY(N_0))
         FOR NI:=1 TO 2
            FOR NII:=1 TO LEN(CAUX)
               NVAR1:=NVAR1+VAL(SUBSTR(CAUX,NII,1))*NVAR2
               NVAR2:=NVAR2-1
               NVAR2:=IIF(NVAR2 < 2,9,NVAR2)
            NEXT NII
            NVAR1:=IIF(11-MOD(NVAR1,11) > 9,0,11-MOD(NVAR1,11))
            CAUX:=CAUX+STR(NVAR1,1)
            NVAR1:=0
            NVAR2:=6
         NEXT NI
         IF (SUBSTR(N_0,17,2) != SUBSTR(CAUX,13,2))
*           MSGBOX({"Digito verificador incorreto","Digito correto - "+SUBSTR(CAUX,13,2)})
*           RSTENV(Local1)
*           RETU(.T.)
            DO BEEP
*           DO BEEP
            REST SCRE FROM T_DV
            RETU(.F.)
         ELSE
*           MSGBOX1("N�mero do CNPJ est� correto...")
*           RSTENV(Local1)
            RETU(.T.)
         ENDIF   && SUBSTR(Arg1,17,2) != SUBSTR(CAUX,13,2)
      ENDIF   && !EMPTY(Arg1)

   OTHE
      IF N_0==SPACE(18)
         RETU(.T.)
      ENDIF
      REST SCRE FROM T_DV
      RETU(.F.)
ENDCASE
*---------------------------------------------------------------------------*