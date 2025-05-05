# Wilbert Cornelius – Portfolio Website

This is the personal portfolio website.

Built with [SvelteKit](https://kit.svelte.dev/) and [Tailwind CSS](https://tailwindcss.com/). The site showcases projects, skills, experience, and qualifications, and features light/dark themes, responsive design, animated components, and a downloadable resume (generated programmatically).

All portfolio and resume content is managed through shared JSON files, making updates simple and consistent. The resume is generated automatically using [Typst](https://typst.app/), and uses the same JSON data as the website, ensuring both always stay in sync.

## Features

- Responsive design for desktop and mobile
- Light/dark mode with seamless switching
- Animated transitions and smooth scrolling
- Modular, reusable Svelte components
- Portfolio and resume data managed from shared JSON files for easy updates
- Resume is generated programmatically with Typst using the same JSON data

## Getting Started

1. **Install dependencies:**
   ```sh
   npm install
   ```

2. **Run the development server:**
   ```sh
   npm run dev
   ```

3. **Build for production:**
   - Build the project:
     ```sh
     npm run build
     ```
   - Preview the production build:
     ```sh
     npm run preview
     ```

## Project Structure

- `src/` – SvelteKit source files (components, routes, styles)
- `resume_gen/` – Typst resume generator and assets
- `static/` – Static assets (images, PDFs, etc.)
- `src/lib/data/` – Shared JSON data for both the website and resume

## License

This project is open source and available under the [MIT License](LICENSE).