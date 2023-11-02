include tables

flag-colors = table: country, color1, color2, color3
row: "Norway", "crimson", "white", "navy"
row: "Sweden", "royal-blue", "gold", none
row: "Denmark", "red", "white", none
row: "Finland", "white", "royal-blue", none
row: "Iceland", "royal-blue", "white", "red"
row: "Faroe Islands", "white", "royal-blue", "red"
end

fun find-row(country-name :: String, index :: Number) -> Row:
  if flag-colors.row-n(index)["country"] == country-name:
    flag-colors.row-n(index)
  else:
    find-row(country-name, index + 1)
 end
end


fun create-nordic-flag(flag-country :: String) -> Image:
  country-row = find-row(flag-country, 0)
  if country-row["color3"] == none:
    cross = overlay-xy(rectangle(220, 30, "solid", country-row["color2"]), 65, -65, rectangle(30, 160, "solid", country-row["color2"]))
    overlay(cross, rectangle(220, 160, "solid", country-row["color1"]))
  else:
    cross1 = overlay-xy(rectangle(220, 40, "solid", country-row["color2"]), 60, -60, rectangle(40, 160, "solid", country-row["color2"])) 
    cross2 = overlay-xy(rectangle(220, 20, "solid", country-row["color3"]), 70, -70, rectangle(20, 160, "solid", country-row["color3"]))
    overlay(overlay(cross2, cross1), rectangle(220, 160, "solid", country-row["color1"]))
  end
end
