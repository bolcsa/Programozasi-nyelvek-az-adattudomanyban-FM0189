# Orvosi Költségek Elemzése

## Összefoglaló
Ez a riport az orvosi költségek elemzését tartalmazza. 
Az elemzés célja az, hogy feltárja az orvosi költségek és különböző tényezők (például életkor, nem, BMI, dohányzási szokások és régió) közötti összefüggéseket.

## Leíró Statisztikák
Az alábbi táblázat összefoglalja az adatok legfontosabb statisztikai jellemzőit.

7×7 DataFrame
 Row │ variable  mean     min        median   max        nmissing  eltype
     │ Symbol    Union…   Any        Union…   Any        Int64     DataType
─────┼───────────────────────────────────────────────────────────────────────────────────────────────
   1 │ age       39.207   18         39.0     64                0  Int64
   2 │ sex                female              male              0  CategoricalValue{String7, UInt32}
   3 │ bmi       30.6634  15.96      30.4     53.13             0  Float64
   4 │ children  1.09492  0          1.0      5                 0  Int64
   5 │ smoker             no                  yes               0  CategoricalValue{String3, UInt32}
   6 │ region             northeast           southwest         0  CategoricalValue{String15, UInt3…
   7 │ charges   13270.4  1121.87    9382.03  63770.4           0  Float64

## Átlagos Orvosi Költségek Nemek Szerint
Az alábbi táblázat az átlagos orvosi költségeket mutatja nemenkénti bontásban.

2×2 DataFrame
 Row │ sex     mean_charges
     │ Cat…    Float64
─────┼──────────────────────
   1 │ female       12569.6
   2 │ male         13956.8

![Átlagos költségek nemenként](C:\Users\Rajzolo\Documents\JuliaWorkSpace\mean_charges_by_sex.png)

## Átlagos Orvosi Költségek Régiónként
Az alábbi táblázat az átlagos orvosi költségeket mutatja régiónkénti bontásban.

4×2 DataFrame
 Row │ region     mean_charges
     │ Cat…       Float64
─────┼─────────────────────────
   1 │ northeast       13406.4
   2 │ northwest       12417.6
   3 │ southeast       14735.4
   4 │ southwest       12346.9

![Átlagos költségek régiónként](C:\Users\Rajzolo\Documents\JuliaWorkSpace\mean_charges_by_region.png)

## Kor és Orvosi Költségek Közötti Korreláció
Az alábbi érték mutatja az életkor és az orvosi költségek közötti korrelációt.

0.2990081933306475

## Átlagos Orvosi Költségek BMI Kategóriák Szerint
Az alábbi táblázat az átlagos orvosi költségeket mutatja BMI kategóriák szerint.

4×2 DataFrame
 Row │ bmi_category  mean_charges
     │ Categorical…  Float64
─────┼────────────────────────────
   1 │ Sovány              8852.2
   2 │ Normális           10379.5
   3 │ Túlsúly            11030.3
   4 │ Elhízott           15460.5

![Átlagos költségek BMI kategóriák szerint](C:\Users\Rajzolo\Documents\JuliaWorkSpace\mean_charges_by_bmi.png)

## Dohányzási Szokások Hatása az Orvosi Költségekre
Az alábbi táblázat az átlagos orvosi költségeket mutatja a dohányzási szokások szerint.

2×2 DataFrame
 Row │ smoker  mean_charges
     │ Cat…    Float64
─────┼──────────────────────
   1 │ no           8434.27
   2 │ yes         32050.2

## Lineáris Regressziós Modell Összegzése
Az alábbi táblázat a lineáris regressziós modell összegzését mutatja, amely az életkor, BMI, gyermekek száma és dohányzási szokások hatását vizsgálja az orvosi költségekre.

─────────────────────────────────────────────────────────────────────────────
                  Coef.  Std. Error       t  Pr(>|t|)   Lower 95%   Upper 95%
─────────────────────────────────────────────────────────────────────────────
(Intercept)  -12102.8      941.984   -12.85    <1e-34  -13950.7    -10254.8
age             257.85      11.8964   21.67    <1e-88     234.512     281.187
bmi             321.851     27.3776   11.76    <1e-29     268.143     375.559
children        473.502    137.792     3.44    0.0006     203.19      743.814
smoker: yes   23811.4      411.22     57.90    <1e-99   23004.7     24618.1
─────────────────────────────────────────────────────────────────────────────

## Vizualizáció
Az alábbi grafikon a tényleges és előrejelzett orvosi költségeket hasonlítja össze.

![Előrejelzések vs. tényleges](C:\Users\Rajzolo\Documents\JuliaWorkSpace\predictions_vs_actual.png)
