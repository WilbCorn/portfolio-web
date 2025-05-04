#import "../styles/styles.typ": primary_color

#let section_header(title) = {
  text(title, weight: "bold", size: 12pt, fill: primary_color)
  v(-10pt)
  line(length: 100%, stroke: 1pt + primary_color)
  v(-5pt)
}