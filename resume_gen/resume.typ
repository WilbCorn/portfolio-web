// Settings
#import "styles/styles.typ": apply_styles, secondary_color, primary_color
#import "components/section_header.typ": section_header
#import "components/icon_text.typ": icon_text

// Data paths
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
    #h(10pt)
    #icon_text(
      link(external_profile.portfolio_web.link)[#external_profile.portfolio_web.profile_name],
      icon_name: "link",
    )
  ]
  line(length: 100%, stroke: 1pt)
  v(-15pt)
  line(length: 100%)
  v(-5pt)
}

// About me section
#let about_me_section() = {
  section_header("About Me")
  text(personal_info.description + ".", size: 8.5pt)
  parbreak()
}

// Experiences section
#let experiences_section() = {
  section_header("Experiences")

  for experience in (experiences) {
    if experience.in_resume == true {
      text(experience.name, weight: "bold", size: 10pt)
      h(1fr)
      text(experience.year, size: 9pt)
      v(-5pt)

      text(experience.role, size: 9pt, weight: "bold", fill: secondary_color)
      h(1fr)
      text(style: "italic", experience.organization, size: 9pt)
      v(-5pt)

      list(..experience.summary_contribution.map(contr => text(contr, size: 8.5pt)))
      v(5pt)
    }
  }

  parbreak()
}

// Education section
#let education_section() = {
  section_header("Education")

  for education in (educations) {
    // Row 1
    text(education.name, weight: "bold", size: 10pt)
    v(-5pt)

    // Row 2
    text(education.location.school, size: 9pt, style: "italic")
    h(1fr)
    text("CGPA: ", size: 8.5pt)
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
    list(..education.achievements.map(achv => text(achv.name + " (" + achv.start + " - " + achv.end + ")", size: 8.5pt)))
  }
}

#let list_with_skills(achievements, skills) = {
  list(
    spacing: auto,
    ..achievements.map(achv => text(achv, size: 8.5pt)),
    {
      text("Skills Used: ", size: 8.5pt, weight: "bold")
      let skills_count = skills.len()
      for (i, skill) in skills.enumerate() {
        text(skill, size: 8.5pt)
        if i < skills_count - 1 {
          text(", ", size: 8.5pt)
        }
      }
      "."
    },
  )
}

// Projects section
#let project_section() = {
  section_header("Projects")

  for project in (projects) {
    if project.in_resume == true {
      text(project.name, weight: "bold", size: 10pt)
      v(-5pt)

      // text(project.description, size: 7pt)
      // v(-5pt)

      list_with_skills(project.summary_achievements, project.hard_skills_utilized)
    }
  }
}


#let list_with_techs(achievements, techs) = {
  list(
    spacing: auto,
    ..achievements.map(achv => text(achv, size: 8.5pt)),
    {
      text("Techs Used: ", size: 8.5pt, weight: "bold")
      let techs_count = techs.len()
      for (i, tech) in techs.enumerate() {
        text(tech, size: 8.5pt)
        if i < techs_count - 1 {
          text(", ", size: 8.5pt)
        }
      }
      "."
    },
  )
}

// Careers section
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
        text(" | ", size: 8.5pt)
      }
    }
    v(-5pt)

    // Row 4
    list_with_techs(career.summary_achievements, career.technologies)
  }
}

// Tech Skills section
#let tech_skills_section(withHeader: true) = {
  if withHeader {
    section_header("Tech Skills")
  }

  // Group by category, show each as a row: Category: skill1, skill2, skill3
  for category in tech_skills {
    text(category.category + ":", weight: "bold", size: 8.5pt)
    h(6pt)
    let skills_count = category.skills.len()
    for (i, skill) in category.skills.enumerate() {
      text(skill.name, size: 8.5pt)
      if i < skills_count - 1 {
        text(" | ", size: 8.5pt)
      }
    }
    v(-4pt)
  }
}

// Soft Skills section
#let soft_skills_section(withHeader: true) = {
  if withHeader {
    section_header("Soft Skills")
  }

  let all_skills = soft_skills.sorted()
  text(all_skills.join(" | "), size: 8.5pt)
  v(2pt)
}

#let combined_skills_section() = {
  section_header("Skills");
  tech_skills_section(withHeader:false);
  text("Soft Skills: ", weight: "bold", size: 8.5pt);
  soft_skills_section(withHeader:false);
}

// Languages section
#let lang_skills_section() = {
  section_header("Languages")

  list(
    ..languages.map(lang => text(
      strong(lang.name)
        + ": "
        + lang.expertise
        + if lang.certification != none and lang.certification.len() > 0 {
          " (" + lang.certification.map(cert => cert.name + ": " + cert.score).join(", ") + ")"
        } else {
          ""
        },
      size: 8.5pt,
    )),
  )
}

// Certifications section
#let cert_section() = {
  section_header("Certifications")

  columns(2, gutter: 15pt)[
    #for cert in certifications [
      • #text(cert.name, weight: "medium", size: 8.5pt)
      #linebreak()
      #h(6pt)
      #text(cert.provider, style: "italic", size: 8.5pt)
      #if cert.start != none [
        #text("(" + cert.start + ")", size: 8.5pt)
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
#combined_skills_section();
#lang_skills_section()
// #cert_section()
