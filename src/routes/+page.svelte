<script>
	import SeparatorWavy from "$lib/components/common/separator-wavy.svelte";
	import Footer from "$lib/components/footer.svelte";
	import AboutMeSection from "$lib/components/home/about_me/sections/about-me.svelte";
	import HeroSection from "$lib/components/home/hero.svelte";
	import ProjectSection from "$lib/components/home/project.svelte";

</script>

<svelte:head>
  <title>Wilbert - Software Engineer</title>
</svelte:head>

<div id="home">
    <HeroSection/>
</div>

<SeparatorWavy color="var(--bg-secondary)" spacing=50 />
<div id="about">
    <AboutMeSection/>
</div>

<div id="projects">
    <ProjectSection bg_color="var(--bg-secondary)"/>
	<SeparatorWavy color="var(--bg-secondary)" flipped={true}/>
</div>


<div id="contact">
    <Footer bg_color="var(--bg)"/>
</div>

