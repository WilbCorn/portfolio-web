#let primary_color = rgb("#1b3478")
#let secondary_color = rgb("#0f3547")
#let text_color = rgb(black)

#let apply_styles(doc) = {

  show heading: set text(
    fill: text_color,
  )

  doc
}