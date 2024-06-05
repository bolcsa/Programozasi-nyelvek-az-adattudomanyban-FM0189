import Pkg
Pkg.add("DataFrames")
Pkg.add("CSV")
Pkg.add("Statistics")
Pkg.add("CategoricalArrays")
Pkg.add("GLM")
Pkg.add("Plots")

using DataFrames, CSV, Statistics, CategoricalArrays, GLM, Plots

# Betöltjük az adatokat
file_path = raw"C:\\Medical Cost Personal Datasets.csv"
data = CSV.read(file_path, DataFrame)

# Adattisztítás
data = dropmissing(data)
data.age = convert.(Int, data.age)
data.bmi = convert.(Float64, data.bmi)
data.children = convert.(Int, data.children)
data.charges = convert.(Float64, data.charges)
data.sex = categorical(data.sex)
data.smoker = categorical(data.smoker)
data.region = categorical(data.region)

# Elemzés
summary_stats = describe(data)
mean_charges_by_sex = combine(groupby(data, :sex), :charges => mean)
mean_charges_by_region = combine(groupby(data, :region), :charges => mean)
correlation_age_charges = cor(data.age, data.charges)
bmi_categories = cut(data.bmi, [0, 18.5, 24.9, 29.9, Inf], labels=["Sovány", "Normális", "Túlsúly", "Elhízott"])
data[!, :bmi_category] = bmi_categories
mean_charges_by_bmi = combine(groupby(data, :bmi_category), :charges => mean)
mean_charges_by_smoker = combine(groupby(data, :smoker), :charges => mean)
model = lm(@formula(charges ~ age + bmi + children + smoker), data)
model_summary = coeftable(model)
predictions = predict(model)

# Vizualizáció
p = plot(data.charges, predictions, seriestype = :scatter, label = "Előrejelzések vs. tényleges", xlabel = "Tényleges költségek", ylabel = "Előrejelzett költségek")
plot!(p, identity, color = :red, label = "Ideális illesztés")
savefig(p, raw"C:\\Users\\Rajzolo\\Documents\\JuliaWorkSpace\\predictions_vs_actual.png")

# Markdown riport generálása
open(raw"C:\\Users\\Rajzolo\\Documents\\JuliaWorkSpace\\MarkDownReport.md", "w") do f
    write(f, """
# Riport generálása

### Átlagos orvosi költségek nemenként
$(mean_charges_by_sex)

### Átlagos orvosi költségek régiónként
$(mean_charges_by_region)

### Kor és orvosi költségek közötti korreláció
$(correlation_age_charges)

### Átlagos orvosi költségek BMI kategóriák szerint
$(mean_charges_by_bmi)

### Dohányzási szokások hatása az orvosi költségekre
$(mean_charges_by_smoker)

### Lineáris regressziós modell összegzése
$(model_summary)

### Vizualizáció, mentett kép file helye
# C:\\Users\\Rajzolo\\Documents\\JuliaWorkSpace\\predictions_vs_actual.png)
""")
end
