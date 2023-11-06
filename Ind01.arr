include tables

flag-data = table: country, color1, color2, color3
  row: "norway", "crimson", "white", "navy"
  row: "sweden", "royal-blue", "gold", none
  row: "denmark", "red", "white", none
  row: "finland", "white", "royal-blue", none
  row: "iceland", "royal-blue", "white", "red"
  row: "faroe islands", "white", "royal-blue", "red"
end

fun find-row(country-list :: List, country :: String):
doc: "code finds and returns the row with the matching country name, raises an error if it can't find the country in the table"
  ask:
    |  country-list == empty then: raise("Country not found in list. Try: Denmark, Norway, Sweden, Finland, Iceland or Faroe Islands")
    |  country-list.first["country"] == country then: country-list.first
    |  otherwise: find-row(country-list.rest, country)
  end
end

fun create-nordic-flag(country :: String):
doc: "Uses find-row() to find the row for the flag being searched for. Checks if it is a double or single cross flag and runs the corresponding code"
  country-row = find-row(flag-data.all-rows(), string-to-lower(country))
  if  country-row["color3"] == none:
    cross = overlay-xy(rectangle(220,30,"solid",country-row["color2"]),65,-65,rectangle(30, 160,"solid",country-row["color2"]))
    overlay(cross, rectangle(220, 160, "solid", country-row["color1"]))
  else:
    cross1 = overlay-xy(rectangle(220, 40, "solid", country-row["color2"]), 60, -60, rectangle(40, 160, "solid", country-row["color2"])) 
    cross2 = overlay-xy(rectangle(220, 20, "solid", country-row["color3"]), 70, -70, rectangle(20, 160, "solid", country-row["color3"]))
    overlay(overlay(cross2, cross1), rectangle(220, 160, "solid", country-row["color1"]))
  end
end





