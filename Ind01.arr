include tables

flag-colors = table: country, color1, color2, color3
  row: "norway", "crimson", "white", "navy"
  row: "sweden", "royal-blue", "gold", none
  row: "denmark", "red", "white", none
  row: "finland", "white", "royal-blue", none
  row: "iceland", "royal-blue", "white", "red"
  row: "faroe islands", "white", "royal-blue", "red"
end

fun find-row(country-name :: String, index :: Number):
  ask:
    | string-equal(flag-colors.row-n(index)["country"], country-name) then: flag-colors.row-n(index)
    | (index + 1) >= flag-colors.length() then: false
    | otherwise: find-row(country-name, index + 1)
 end
end


fun create-nordic-flag(flag-country :: String):
  country-row = find-row(string-to-lower(flag-country), 0)
  ask: 
    | country-row == false then:
      "Country not found in list. Try: Denmark, Norway, Sweden, Finland, Iceland or Faroe Islands"
    | country-row["color3"] == none then:
      cross = overlay-xy(rectangle(220,30,"solid",country-row["color2"]),65,-65,rectangle(30, 160,"solid",country-row["color2"]))
      overlay(cross, rectangle(220, 160, "solid", country-row["color1"]))
    | otherwise:
      cross1 = overlay-xy(rectangle(220, 40, "solid", country-row["color2"]), 60, -60, rectangle(40, 160, "solid", country-row["color2"])) 
      cross2 = overlay-xy(rectangle(220, 20, "solid", country-row["color3"]), 70, -70, rectangle(20, 160, "solid", country-row["color3"]))
      overlay(overlay(cross2, cross1), rectangle(220, 160, "solid", country-row["color1"]))
  end
end
