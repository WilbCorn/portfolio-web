<script>
	import SeparatorWavy from "$lib/components/common/separator-wavy.svelte";
	import Footer from "$lib/components/footer.svelte";
	import AboutMeSection from "$lib/components/home/about_me/sections/about-me.svelte";
	import HeroSection from "$lib/components/home/hero.svelte";
	import ProjectSection from "$lib/components/home/project.svelte";

</script>

<HeroSection/>
<SeparatorWavy color="var(--bg-secondary)" spacing=50 />
<AboutMeSection/>
<SeparatorWavy color="var(--bg-secondary)" flipped={true} />
<ProjectSection/>
<Footer/>