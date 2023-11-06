include shared-gdrive(
"dcic-2021",
"1wyQZj_L0qqV9Ekgr9au6RX2iqt2Ga8Ep")
include gdrive-sheets
include data-source



ssid = "1RYN0i4Zx_UETVuYacgaGfnFcv4l9zd9toQTTdkQkj7g"

kWh-wealthy-consumer-data =
  load-table: komponent, energi
  source: load-spreadsheet(ssid).sheet-by-name("kWh", true)
  sanitize energi using string-sanitizer
end

fun car-energy-per-day(distance :: Number, distance-per-unit :: Number) -> Number:
doc: "Calculates the energy used per day with a car based on the provided formula"
  (distance / distance-per-unit) * 10
end 

#calculation of the energy use for car using numbers taken from withoutair.com
car = car-energy-per-day(50, 12)


fun energi-to-number(str :: String) -> Number:
doc: "takes a string and changes it to a number if it has a value. If it finds none, substitutes for the car value"
  cases (Option) string-to-number(str):
    | some(a) => a
    | none => car
  end
  where:
    energi-to-number("") is car
    energi-to-number("48") is 48
end

temp-number-table = transform-column(kWh-wealthy-consumer-data, "energi", energi-to-number)

sum(temp-number-table, "energi")

bar-chart(temp-number-table, "komponent", "energi")
