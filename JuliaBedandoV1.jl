# Szükséges csomagok telepítése
import Pkg
Pkg.add("DataFrames")           # Adatkeretek kezelése
Pkg.add("CSV")                  # CSV fájlok olvasása és írása
Pkg.add("Statistics")           # Statisztikai műveletek
Pkg.add("CategoricalArrays")    # Kategorikus változók kezelése
Pkg.add("GLM")                  # Generalizált lineáris modellek
Pkg.add("Plots")                # Adatok vizualizálása

# Szükséges csomagok betöltése
using DataFrames, CSV, Statistics, CategoricalArrays, GLM, Plots

# Betöltjük az adatokat a CSV fájlból egy DataFrame-be
file_path = raw"C:\\Medical Cost Personal Datasets.csv"
data = CSV.read(file_path, DataFrame)

# Adattisztítás
data = dropmissing(data)

# Adattisztítás: típuskonverziók
data.age = convert.(Int, data.age)              # Életkor konvertálása egész számra
data.bmi = convert.(Float64, data.bmi)          # BMI konvertálása lebegőpontos számra
data.children = convert.(Int, data.children)    # Gyermekek száma konvertálása egész számra
data.charges = convert.(Float64, data.charges)  # Orvosi költségek konvertálása lebegőpontos számra

# Kategorikus változók létrehozása
data.sex = categorical(data.sex)                # Nem konvertálása kategorikus változóra
data.smoker = categorical(data.smoker)          # Dohányzási szokások konvertálása kategorikus változóra
data.region = categorical(data.region)          # Régió konvertálása kategorikus változóra

# Elemzés: leíró statisztikák készítése az adatokra
summary_stats = describe(data)

# Elemzés: átlagos költségek kiszámítása nemenként
mean_charges_by_sex = combine(groupby(data, :sex), :charges => mean => :mean_charges)

# Elemzés: átlagos költségek kiszámítása régiónként
mean_charges_by_region = combine(groupby(data, :region), :charges => mean => :mean_charges)

# Elemzés: korreláció számítása az életkor és a költségek között
correlation_age_charges = cor(data.age, data.charges)

# BMI kategóriák létrehozása és az átlagos költségek számítása ezen kategóriák szerint
bmi_categories = cut(data.bmi, [0, 18.5, 24.9, 29.9, Inf], labels=["Sovány", "Normális", "Túlsúly", "Elhízott"])
data[!, :bmi_category] = bmi_categories
mean_charges_by_bmi = combine(groupby(data, :bmi_category), :charges => mean => :mean_charges)

# Elemzés: átlagos költségek kiszámítása a dohányzási szokások alapján
mean_charges_by_smoker = combine(groupby(data, :smoker), :charges => mean => :mean_charges)

# Lineáris regressziós modell illesztése az adatokra
model = lm(@formula(charges ~ age + bmi + children + smoker), data)

# Modell összegzésének elkészítése
model_summary = coeftable(model)

# Előrejelzések készítése a modell alapján
predictions = predict(model)

# Vizualizáció: szórt pont diagram készítése a tényleges és előrejelzett költségek összehasonlítására
p1 = plot(data.charges, predictions, seriestype = :scatter, label = "Előrejelzések vs. tényleges", xlabel = "Tényleges költségek", ylabel = "Előrejelzett költségek")
plot!(p1, identity, color = :red, label = "Ideális illesztés")

# Átlagos orvosi költségek nemek szerint
p2 = bar(mean_charges_by_sex.sex, mean_charges_by_sex.mean_charges, xlabel = "Nem", ylabel = "Átlagos orvosi költségek", label = "Átlagos költségek nemenként")

# Átlagos orvosi költségek régiónként
p3 = bar(mean_charges_by_region.region, mean_charges_by_region.mean_charges, xlabel = "Régió", ylabel = "Átlagos orvosi költségek", label = "Átlagos költségek régiónként")

# Átlagos orvosi költségek BMI kategóriák szerint
p4 = bar(mean_charges_by_bmi.bmi_category, mean_charges_by_bmi.mean_charges, xlabel = "BMI kategória", ylabel = "Átlagos orvosi költségek", label = "Átlagos költségek BMI kategóriák szerint")

# A diagramok elmentése fájlokba
savefig(p1, raw"C:\\Users\\Rajzolo\\Documents\\JuliaWorkSpace\\predictions_vs_actual.png")
savefig(p2, raw"C:\\Users\\Rajzolo\\Documents\\JuliaWorkSpace\\mean_charges_by_sex.png")
savefig(p3, raw"C:\\Users\\Rajzolo\\Documents\\JuliaWorkSpace\\mean_charges_by_region.png")
savefig(p4, raw"C:\\Users\\Rajzolo\\Documents\\JuliaWorkSpace\\mean_charges_by_bmi.png")

# Markdown riport generálása és mentése egy fájlba
open(raw"C:\\Users\\Rajzolo\\Documents\\JuliaWorkSpace\\MarkDownReport.md", "w") do f
    # A riport eleje, címekkel és bevezető szöveggel
    write(f, """
# Orvosi Költségek Elemzése

## Összefoglaló
Ez a riport az orvosi költségek elemzését tartalmazza. 
Az elemzés célja az, hogy feltárja az orvosi költségek és különböző tényezők (például életkor, nem, BMI, dohányzási szokások és régió) közötti összefüggéseket.

## Leíró Statisztikák
Az alábbi táblázat összefoglalja az adatok legfontosabb statisztikai jellemzőit.

$(summary_stats)

## Átlagos Orvosi Költségek Nemek Szerint
Az alábbi táblázat az átlagos orvosi költségeket mutatja nemenkénti bontásban.

$(mean_charges_by_sex)

![Átlagos költségek nemenként](C:\\Users\\Rajzolo\\Documents\\JuliaWorkSpace\\mean_charges_by_sex.png)

## Átlagos Orvosi Költségek Régiónként
Az alábbi táblázat az átlagos orvosi költségeket mutatja régiónkénti bontásban.

$(mean_charges_by_region)

![Átlagos költségek régiónként](C:\\Users\\Rajzolo\\Documents\\JuliaWorkSpace\\mean_charges_by_region.png)

## Kor és Orvosi Költségek Közötti Korreláció
Az alábbi érték mutatja az életkor és az orvosi költségek közötti korrelációt.

$(correlation_age_charges)

## Átlagos Orvosi Költségek BMI Kategóriák Szerint
Az alábbi táblázat az átlagos orvosi költségeket mutatja BMI kategóriák szerint.

$(mean_charges_by_bmi)

![Átlagos költségek BMI kategóriák szerint](C:\\Users\\Rajzolo\\Documents\\JuliaWorkSpace\\mean_charges_by_bmi.png)

## Dohányzási Szokások Hatása az Orvosi Költségekre
Az alábbi táblázat az átlagos orvosi költségeket mutatja a dohányzási szokások szerint.

$(mean_charges_by_smoker)

## Lineáris Regressziós Modell Összegzése
Az alábbi táblázat a lineáris regressziós modell összegzését mutatja, amely az életkor, BMI, gyermekek száma és dohányzási szokások hatását vizsgálja az orvosi költségekre.

$(model_summary)

## Vizualizáció
Az alábbi grafikon a tényleges és előrejelzett orvosi költségeket hasonlítja össze.

![Előrejelzések vs. tényleges](C:\\Users\\Rajzolo\\Documents\\JuliaWorkSpace\\predictions_vs_actual.png)
""")
end
