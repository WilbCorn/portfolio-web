#import "../styles/styles.typ": primary_color

#let icon_text(content, icon_name: none, spacing: 16pt, shift: 1.5pt, icon_dir: "icons/", text_size: 10pt) = {
  box(
    baseline: shift,
    height: 10pt,
    if icon_name != none {
      image("../icons/" + icon_name + ".svg", )
      h(spacing)
    },
  )
  text(content, size: text_size, weight: "regular")
}
