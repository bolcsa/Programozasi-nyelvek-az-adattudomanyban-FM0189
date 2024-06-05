# Riport generálása

### Átlagos orvosi költségek nemenként
2×2 DataFrame
 Row │ sex     charges_mean
     │ Cat…    Float64
─────┼──────────────────────
   1 │ female       12569.6
   2 │ male         13956.8

### Átlagos orvosi költségek régiónként
4×2 DataFrame
 Row │ region     charges_mean
     │ Cat…       Float64
─────┼─────────────────────────
   1 │ northeast       13406.4
   2 │ northwest       12417.6
   3 │ southeast       14735.4
   4 │ southwest       12346.9

### Kor és orvosi költségek közötti korreláció
0.2990081933306475

### Átlagos orvosi költségek BMI kategóriák szerint
4×2 DataFrame
 Row │ bmi_category  charges_mean
     │ Categorical…  Float64
─────┼────────────────────────────
   1 │ Sovány              8852.2
   2 │ Normális           10379.5
   3 │ Túlsúly            11030.3
   4 │ Elhízott           15460.5

### Dohányzási szokások hatása az orvosi költségekre
2×2 DataFrame
 Row │ smoker  charges_mean
     │ Cat…    Float64
─────┼──────────────────────
   1 │ no           8434.27
   2 │ yes         32050.2

### Lineáris regressziós modell összegzése
─────────────────────────────────────────────────────────────────────────────
                  Coef.  Std. Error       t  Pr(>|t|)   Lower 95%   Upper 95%
─────────────────────────────────────────────────────────────────────────────
(Intercept)  -12102.8      941.984   -12.85    <1e-34  -13950.7    -10254.8
age             257.85      11.8964   21.67    <1e-88     234.512     281.187
bmi             321.851     27.3776   11.76    <1e-29     268.143     375.559
children        473.502    137.792     3.44    0.0006     203.19      743.814
smoker: yes   23811.4      411.22     57.90    <1e-99   23004.7     24618.1
─────────────────────────────────────────────────────────────────────────────

### Vizualizáció, mentett kép file helye
# C:\Users\Rajzolo\Documents\JuliaWorkSpace\predictions_vs_actual.png)
