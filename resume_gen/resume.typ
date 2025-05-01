// Settings
#import "styles/styles.typ": apply_styles, secondary_color, primary_color
#import "components/comp_personal_info.typ"

#let data_path = "../src/lib/data/"

#let data_settings = json(data_path + "data_settings.json")
#let personal_info = json(data_path + "personal_info.json")
#let external_profile = json(data_path + "external_profile.json")
#let experiences = json(data_path + "experiences.json")
#let educations = json(data_path + "education.json")
#let projects = json(data_path + "projects.json")
#let careers = json(data_path + "careers.json")
#let tech_skills = json(data_path + "tech_skills.json")
#let soft_skills = json(data_path + "soft_skills.json")
#let languages = json(data_path + "languages.json")
#let certifications = json(data_path + "certification.json")

// Apply the global styles
#show: apply_styles

// Set up the PDF document settings
#set document(
  title: [Resume - #personal_info.name],
  author: personal_info.name,
  description: data_settings.description + " " + data_settings.data_version,
  keywords: data_settings.tags,
  date: auto,
)

// Set up the page settings
#set page(
  paper: "a4",
  margin: 0.8cm,
  columns: 2,
)

// Set the whole doc to align justify
#set par(justify: true)

#let section-title(title) = {
  (
    text(weight: "bold", font: "Fira Code", size: 12pt)[
      #title
    ]
      + parbreak()
  )
}


// Text that accepts optional icon
#let icon_text(content, icon_name: none, spacing: 16pt, shift: 1.5pt, icon_dir: "icons/", text_size: 10pt) = {
  box(
    baseline: shift,
    height: 10pt,
    if icon_name != none {
      image("icons/" + icon_name + ".svg")
      h(spacing)
    },
  )
  text(content, size: text_size, weight: "regular")
}


// Header section function
#let header_section() = {
  align(center)[
    #text(weight: "bold", personal_info.name, size: 17pt)
    #v(-10pt)
    #text(personal_info.role, size: 13pt, fill: primary_color)
    #v(-5pt)
    #icon_text(link(external_profile.linked_in.link)[#external_profile.linked_in.profile_name], icon_name: "linkedin")
    #h(10pt)
    #icon_text(link(external_profile.github.link)[#external_profile.github.profile_name], icon_name: "github")
    #h(10pt)
    #icon_text(link("mailto:" + personal_info.email_address)[#personal_info.email_address], icon_name: "mail")
    #h(10pt)
    #icon_text(link("tel:" + personal_info.telp_no)[#personal_info.telp_no], icon_name: "phone")
  ]
  line(length: 100%)
  v(-15pt)
  line(length: 100%)
  v(-5pt)
}

// Reusable section header
#let section_header(title) = {
  text(title, weight: "bold", size: 13pt)
  v(-10pt)
  line(length: 100%)
}

// About me section
#let about_me_section() = {
  section_header("About Me")
  text(personal_info.description + ".", size: 10pt)
  parbreak()
}

// Experiences section
#let experiences_section() = {
  section_header("Experiences")

  for experience in (experiences) {
    text(experience.name, weight: "bold", size: 10pt)
    h(1fr)
    text(experience.year, size: 9pt)
    v(-5pt)

    text(experience.role, size: 9pt, fill: primary_color)
    h(1fr)
    text(style: "italic", experience.organization, size: 9pt)
    v(-5pt)

    list(..experience.contribution.map(contr => text(contr, size: 8pt)))
    v(5pt)
  }

  parbreak()
}

#let education_section() = {
  section_header("Education")

  for education in (educations) {
    // Row 1
    text(education.name, weight: "bold", size: 10pt)
    v(-5pt)

    // Row 2
    text(education.location.school, size: 9pt, style: "italic")
    h(1fr)
    text("CGPA: ", size: 8pt)
    text(str(education.score.current_cgpa), size: 9pt)
    " / "
    text(str(education.score.limit_cgpa), size: 9pt)
    v(-5pt)

    // Row 3
    text(education.location.town, size: 9pt)
    ", "
    text(education.location.country, size: 9pt)
    h(1fr)
    text(education.start.month, size: 9pt) + " "
    text(education.start.year, size: 9pt) + " - "
    text(education.end.month, size: 9pt) + " "
    text(education.end.year, size: 9pt)

    // Row 4
    list(..education.achievements.map(achv => text(achv.name + " (" + achv.start + " - " + achv.end + ")", size: 8pt)))
  }
}

#let project_section() = {
  section_header("Projects")

  for project in (projects) {
    text(project.name, weight: "bold", size: 10pt)
    v(-5pt)

    // text(project.description, size: 7pt)
    // v(-5pt)

    list(
      ..project.achievements.map(achv => text(achv, size: 8pt)),
      {
        text("Skills Used: ", size: 8pt, weight: "bold")
        let skills_count = project.hard_skills_utilized.len()
        for (i, skill) in project.hard_skills_utilized.enumerate() {
          text(skill, size: 8pt)
          if i < skills_count - 1 {
            text(", ", size: 8pt)
          }
        }
        "."
      },
    )
  }
}

#let career_section() = {
  section_header("Careers")

  for career in (careers) {
    // Row 1
    text(career.position, weight: "bold", size: 10pt)
    v(-5pt)

    // Row 2
    text(link(career.company_url)[#career.company], size: 9pt, style: "italic")
    h(1fr)
    text(career.location.city + ", " + career.location.country, size: 9pt)
    v(-5pt)

    // Row 3
    let period_count = career.periods.len()
    for (i, period) in career.periods.enumerate() {
      text(period.start.month, size: 9pt) + " "
      text(str(period.start.year), size: 9pt) + " - "
      if (period.end.month != none and period.end.month != "") {
        text(period.end.month, size: 9pt) + " "
        text(str(period.end.year), size: 9pt)
      } else {
        text("Present", size: 9pt)
      }
      if i < period_count - 1 {
        text(" | ", size: 8pt)
      }
    }
    v(-5pt)

    // Row 4
    list(
      ..career.achievements.map(achv => text(achv, size: 8pt)),
      {
        text("Techs Used: ", size: 8pt, weight: "bold")
        let techs_count = career.technologies.len()
        for (i, tech) in career.technologies.enumerate() {
          text(tech, size: 8pt)
          if i < techs_count - 1 {
            text(", ", size: 8pt)
          }
        }
        "."
      },
    )
  }
}

#let tech_skills_section() = {
  section_header("Tech Skills")

  // Collect all skills into a single flat list
  let all_skills = ()
  for category in tech_skills {
    for skill in category.skills {
      all_skills.push(skill.name)
    }
  }

  // Sort alphabetically
  all_skills = all_skills.sorted()

  let total = all_skills.len()
  let per_column = calc.ceil(total / 4)
  
  grid(
    columns: (1fr, 1fr, 1fr, 1fr),
    column-gutter: 15pt,
    row-gutter: 2pt, 
    
    // First column
    {
      for i in range(0, calc.min(per_column, total)) {
        box(width: 100%)[• #text(all_skills.at(i), size: 8pt)]
        linebreak()
      }
    },
    
    // Second column
    {
      for i in range(per_column, calc.min(per_column * 2, total)) {
        box(width: 100%)[• #text(all_skills.at(i), size: 8pt)]
        linebreak()
      }
    },
    
    // Third column
    {
      for i in range(per_column * 2, calc.min(per_column * 3, total)) {
        box(width: 100%)[• #text(all_skills.at(i), size: 8pt)]
        linebreak()
      }
    },
    
    // Fourth column
    {
      for i in range(per_column * 3, total) {
        box(width: 100%)[• #text(all_skills.at(i), size: 8pt)]
        linebreak()
      }
    }
  )
}

#let soft_skills_section() = {
  section_header("Soft Skills")
  // Sort alphabetically
  let all_skills = soft_skills.sorted()
  
  // Calculate items per column for balanced distribution
  let total = all_skills.len()
  let per_column = calc.ceil(total / 3)
  
  grid(
    columns: (1fr, 1fr, 1fr),
    column-gutter: 15pt,
    row-gutter: 2pt,
    
    // First column
    {
      for i in range(0, calc.min(per_column, total)) {
        box(width: 100%)[• #text(all_skills.at(i), size: 8pt)]
        linebreak()
      }
    },
    
    // Second column
    {
      for i in range(per_column, calc.min(per_column * 2, total)) {
        box(width: 100%)[• #text(all_skills.at(i), size: 8pt)]
        linebreak()
      }
    },
    
    // Third column
    {
      for i in range(per_column * 2, total) {
        box(width: 100%)[• #text(all_skills.at(i), size: 8pt)]
        linebreak()
      }
    }
  )}

#let lang_skills_section() = {
  section_header("Languages")

   list(..languages.map(lang => text(
    lang.name + ": " + lang.expertise +
    if lang.certification != none and lang.certification.len() > 0 {
      " (" + lang.certification.map(cert => cert.name + ": " + cert.score).join(", ") + ")"
    } else {
      ""
    },
    size: 8pt
  )))
}

#let cert_section() = {
  section_header("Certifications")
  
  columns(2, gutter: 15pt)[
    #for cert in certifications [
      • #text(cert.name, weight: "medium", size: 8pt)
      #linebreak()
      #h(6pt)
      #text(cert.provider, style: "italic", size: 8pt) 
      #if cert.start != none [
        #text("(" + cert.start + ")", size: 8pt)
      ]
      #v(5pt)
    ]
  ]
}

// Main Content
#place(
  top + center,
  scope: "parent",
  float: true,
  header_section(),
)
#about_me_section()
#career_section()
#project_section()
#education_section()
#experiences_section()
#tech_skills_section()
#soft_skills_section()
#lang_skills_section()
#cert_section()

